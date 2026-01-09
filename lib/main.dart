import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/app/login_page/login_page.dart';
import 'package:milkshop_driver/app/splash_page/splash_page.dart';
import 'package:milkshop_driver/utils/app_color.dart';
import 'package:milkshop_driver/utils/app_text_style.dart';
import 'common/common_flex.dart';
import 'data/local/shared_preference/shared_preference.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'firebase_options.dart';
bool _isConnectivityDialogOpen = false;

Future<void> main() async {

  Get.testMode = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MySharedPref.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
  ));
  Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
    final hasConnection =
    results.any((result) => result != ConnectivityResult.none);
    if (!hasConnection) {
      if (_isConnectivityDialogOpen) return;
      _isConnectivityDialogOpen = true;
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: PopScope(
            canPop: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                h(12),
                Center(
                  child: Icon(
                    Icons.signal_wifi_off,
                    size: 50.w,
                    color: AppColor.primaryColor,
                  ),
                ),
                Center(
                  child: Text(
                    "No Internet Connection",
                    style: AppTextStyle.medium16(AppColor.blackColor),
                  ),
                ),
                h(12),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      "Please check your internet or WiFi connection.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regular13(AppColor.greyColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      ).whenComplete(() {
        _isConnectivityDialogOpen = false;
      });
    } else {
      if (_isConnectivityDialogOpen && (Get.isDialogOpen == true)) {
        Get.back();
      }
      _isConnectivityDialogOpen = false;
    }
  });

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          theme: ThemeData(useMaterial3: false),
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          home: SplashPage(),
        );
      },
    ),
  );
}



