import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:milkshop_driver/app/login_page/otp_verification_screen.dart';

import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../data/local/shared_preference/shared_preference.dart';
import '../../data/local/shared_preference/shared_preference_key.dart';
import '../../services/base_services.dart';
import '../dashboard_page/dashboard_page.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? _lastVerificationId;
  int? _resendToken;

  @override
  void onInit() {
    if(kDebugMode){
      emailController.text = "9773203736";
    }
    super.onInit();
  }

  Future<void> sendOtp() async {
    final context = Get.context;
    if (context == null) {
      return;
    }

    final String rawInput = emailController.text.trim();
    final String? formattedNumber = _formatPhoneNumber(rawInput);

    if (formattedNumber == null) {
      CustomSnackBar.showToast(
        context,
        messages: 'Please enter valid mobile number',
      );
      return;
    }

    CustomSnackBar.showAlertDialog(
      context,
      message: 'Sending OTP...'
    );

    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedNumber,
        forceResendingToken: _resendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          _closeLoader();
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          _closeLoader();
          CustomSnackBar.showToast(
            context,
            messages: error.message ?? 'Failed to send OTP',
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _resendToken = resendToken;
          _lastVerificationId = verificationId;
          _closeLoader();
          Get.to(
            () => const OtpVerificationScreen(),
            arguments: {
              'verificationId': verificationId,
              'phoneNumber': formattedNumber,
              'resendToken': resendToken,
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _lastVerificationId = verificationId;
        },
      );
    } catch (error) {
      _closeLoader();
      if (kDebugMode) {
        debugPrint('Failed to initiate phone auth: $error');
      }
      CustomSnackBar.showToast(
        context,
        messages: 'Failed to send OTP',
      );
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    final context = Get.context;
    if (context == null) {
      return;
    }

    CustomSnackBar.showAlertDialog(
      context,
      message: 'Verifying OTP...'
    );

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

      await _completeBackendLogin(idToken);
    } on FirebaseAuthException catch (error) {
      _closeLoader();
      CustomSnackBar.showToast(
        context,
        messages: error.message ?? 'Failed to verify OTP',
      );
    } catch (error) {
      _closeLoader();
      if (kDebugMode) {
        debugPrint('Firebase credential sign-in failed: $error');
      }
      CustomSnackBar.showToast(
        context,
        messages: 'Failed to verify OTP',
      );
    }
  }

  Future<void> _completeBackendLogin(String idToken) async {
    final context = Get.context;
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
        await _persistAuthTokens(response?.data);
        _closeLoader();
        CustomSnackBar.showToast(
          context,
          messages: 'Login successful',
        );
        Get.offAll(() => const DashboardPage());
      } else {
        _closeLoader();
        CustomSnackBar.showToast(
          context,
          messages: response?.data['message'] ?? 'Something went wrong',
        );
      }
    } catch (error) {
      _closeLoader();
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
    final String? refreshToken = _extractRefreshToken(data);

    if (accessToken != null && accessToken.isNotEmpty) {
      await MySharedPref.setString(PreferenceKey.token, accessToken);
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await MySharedPref.setString(PreferenceKey.refreshToken, refreshToken);
    }
    await MySharedPref.setBool(PreferenceKey.isLogin, true);
  }

  String? _extractToken(Map<dynamic, dynamic> data) {
    if (data['token'] is String) {
      return data['token'] as String;
    }
    final dynamic nestedData = data['data'];
    if (nestedData is Map && nestedData['tokens'] is Map) {
      final dynamic token = nestedData['tokens']['accessToken'];
      if (token is String) {
        return token;
      }
    }
    return null;
  }

  String? _extractRefreshToken(Map<dynamic, dynamic> data) {
    if (data['refreshToken'] is String) {
      return data['refreshToken'] as String;
    }
    final dynamic nestedData = data['data'];
    if (nestedData is Map && nestedData['tokens'] is Map) {
      final dynamic token = nestedData['tokens']['refreshToken'];
      if (token is String) {
        return token;
      }
    }
    return null;
  }

  String? _formatPhoneNumber(String input) {
    if (input.isEmpty) {
      return null;
    }

    final String digitsOnly = input.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digitsOnly.startsWith('+')) {
      return digitsOnly;
    }

    if (digitsOnly.length == 10) {
      // Default to Indian country code when users enter a bare 10-digit number.
      return '+91$digitsOnly';
    }

    return null;
  }

  void _closeLoader() {
      Get.back();
  }
}