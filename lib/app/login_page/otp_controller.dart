import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../data/local/shared_preference/shared_preference.dart';
import '../../data/local/shared_preference/shared_preference_key.dart';
import '../../services/base_services.dart';
import '../dashboard_page/dashboard_page.dart';

class OtpController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController otpTextController = TextEditingController();
  final RxString verificationId = ''.obs;
  final RxString phoneNumber = ''.obs;
  int? resendToken;

  @override
  void onInit() {
    final dynamic args = Get.arguments;
    if (args is Map) {
      verificationId.value = args['verificationId']?.toString() ?? '';
      phoneNumber.value = args['phoneNumber']?.toString() ?? '';
      final dynamic resend = args['resendToken'];
      if (resend is int) {
        resendToken = resend;
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> verifyOtp(String otp) async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return;
    }

    final String currentVerificationId = verificationId.value;
    if (currentVerificationId.isEmpty) {
      CustomSnackBar.showToast(
        context,
        messages: 'Verification session expired. Please resend OTP.',
      );
      return;
    }

    if (otp.length < 6) {
      CustomSnackBar.showToast(
        context,
        messages: 'Please enter the complete OTP',
      );
      return;
    }

    CustomSnackBar.showAlertDialog(
      context,
      message: 'Verifying OTP...'
    );

    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: currentVerificationId,
      smsCode: otp,
    );

    await _signInWithCredential(credential, showLoader: false);
  }

  Future<void> resendOtp() async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return;
    }

    final String phone = phoneNumber.value;
    if (phone.isEmpty) {
      CustomSnackBar.showToast(
        context,
        messages: 'Phone number not available',
      );
      return;
    }

    CustomSnackBar.showAlertDialog(
      context,
      message: 'Resending OTP...'
    );

    try {

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        forceResendingToken: resendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          _closeLoader();
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          _closeLoader();
          CustomSnackBar.showToast(
            context,
            messages: error.message ?? 'Failed to resend OTP',
          );
        },
        codeSent: (String newVerificationId, int? newResendToken) {
          verificationId.value = newVerificationId;
          resendToken = newResendToken;
          _closeLoader();
          CustomSnackBar.showToast(
            context,
            messages: 'OTP resent successfully',
          );
        },
        codeAutoRetrievalTimeout: (String newVerificationId) {
          verificationId.value = newVerificationId;
        },
      );
      Get.back();
    } catch (error) {
      Get.back();
      if (kDebugMode) {
        debugPrint('Resend OTP failed: $error');
      }
      CustomSnackBar.showToast(
        context,
        messages: 'Failed to resend OTP',
      );
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential, {bool showLoader = true}) async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return;
    }

    if (showLoader) {
      CustomSnackBar.showAlertDialog(
        context,
        message: 'Verifying OTP...'
      );
    }

    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final String? idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'token-not-found',
          message: 'Unable to fetch ID token',
        );
      }
      Get.back();
      await _completeBackendLogin(idToken);
    } on FirebaseAuthException catch (error) {
      Get.back();
      CustomSnackBar.showToast(
        context,
        messages: error.message ?? 'Failed to verify OTP',
      );
    } catch (error) {
      Get.back();
      if (kDebugMode) {
        debugPrint('Firebase sign-in failed: $error');
      }
      CustomSnackBar.showToast(
        context,
        messages: 'Failed to verify OTP',
      );
    }
  }

  Future<void> _completeBackendLogin(String idToken) async {
    final BuildContext? context = Get.context;
    if (context == null) {
      return;
    }

    try {
      final d.Response? response = await BaseService().post(
        ApiUrl.firebaseLogin,
        data: {
          'idToken': idToken,
        },
        isShowMessage: false,
      );

      if (response?.statusCode == 200) {
        await _persistAuthTokens(response?.data['data']);
        Get.back();
        CustomSnackBar.showToast(
          context,
          messages: 'Login successful',
        );
        MySharedPref.setString(PreferenceKey.driverID, response?.data['data']['user']['_id'].toString() ?? '');
        MySharedPref.setString(PreferenceKey.name, response?.data['data']['user']['fullName'].toString() ?? '');
        MySharedPref.setString(PreferenceKey.number, response?.data['data']['user']['mobile'].toString() ?? '');
        Get.offAll(() => const DashboardPage());
      } else {
        _closeLoader();
        CustomSnackBar.showToast(
          context,
          messages: response?.data['message'] ?? 'Something went wrong',
        );
      }
    } catch (error) {
      Get.back();
      if (kDebugMode) {
        debugPrint('Backend login failed: $error');
      }
      CustomSnackBar.showToast(
        context,
        messages: 'Something went wrong',
      );
    }
  }

  Future<void> _persistAuthTokens(dynamic data) async {
    if (data is! Map) {
      return;
    }
    final String? accessToken = _extractToken(data);
    if (accessToken != null && accessToken.isNotEmpty) {
      await MySharedPref.setString(PreferenceKey.token, accessToken);
    }
    await MySharedPref.setBool(PreferenceKey.isLogin, true);
  }

  String? _extractToken(Map<dynamic, dynamic> data) {
    if (data['token'] is String) {
      return data['token'] as String;
    }
    return null;
  }


  void _closeLoader() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}