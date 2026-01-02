import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CustomSnackBar {
  static showCustomSnackBar(
      {required String title,
        required String message,
        Duration? duration,
        Color? colorText,
        Color? backgroundColor,
        Widget? icon}) {
    Get.snackbar(
      title,
      message,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeInOut,
      duration: duration ?? const Duration(seconds: 2),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: colorText ?? AppColor.whiteColor,
      backgroundColor: backgroundColor ?? AppColor.primaryColor,
      icon: icon,
    );
  }

  static showCustomErrorSnackBar(
      {required String title,
        required String message,
        Color? color,
        Duration? duration}) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 2),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeInOut,
      colorText:AppColor.whiteColor,
      backgroundColor: color ?? AppColor.redColor,
      icon: const Icon(
        Icons.error,
        color: AppColor.whiteColor,
      ),
    );
  }

  static dynamic showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text(message, style: const TextStyle(color: AppColor.primaryColor)),
        backgroundColor: AppColor.whiteColor,
      ),
    );
  }

  static showToast(context, {required String messages, Color? textColor}) {
    Fluttertoast.showToast(
      msg: messages,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontAsset: 'assets/fonts/Roboto-Regular.ttf',
      backgroundColor: AppColor.whiteColor,
      textColor: textColor ?? AppColor.blackColor,
      fontSize: 14.sp,
    );
  }

  static showAlertDialog(BuildContext context, {String? message,Color? backgroundColor}) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      backgroundColor: AppColor.whiteColor,
      elevation: 1,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
          ),
          Expanded(
            child: Container(
              margin:  EdgeInsets.only(left: 5.r),
              child:  Padding(
                padding: EdgeInsets.only(left: 10.r),
                child: Text(
                  message??  "Loading...",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.bold16(AppColor.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: backgroundColor,
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child: alert);
      },
    );
  }
}
