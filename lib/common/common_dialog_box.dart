import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';
import '../utils/app_text_style.dart';
import 'common_flex.dart';

class ClickProtector {
  static bool _isClicked = false;

  static void run(Function onClick, {int delayMillis = 1500}) {
    if (!_isClicked) {
      _isClicked = true;
      onClick();

      Future.delayed(Duration(milliseconds: delayMillis), () {
        _isClicked = false;
      });
    }
  }
}

showCustomDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelText,
  bool? popScope,
  String? confirmText,
  VoidCallback? onCancel,
  VoidCallback? onConfirm,
  Color? barrierColor,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor:barrierColor,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: PopScope(
        canPop: popScope ?? true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            h(12),
            Center(
              child: Text(
                title,
                style: AppTextStyle.medium16(AppColor.blackColor),
              ),
            ),
            h(12),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  content ?? "",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular13(
                    AppColor.greyColor,
                  ),
                ),
              ),
            ),
            h(12),
            Container(
              height: 1.h,
              color: AppColor.greyColor.withOpacity(0.5),
            ),
            cancelText != null
                ? Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ClickProtector.run(() {
                        if (onCancel != null) {
                          onCancel();
                        } else {
                          Get.back();
                        }
                      });
                    },
                    child: Ink(
                      height: 35.h,
                      child: Center(
                        child: Text(
                          cancelText ?? "Cancel",
                          style: AppTextStyle.regular15(
                            AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30.h,
                  width: 1.w,
                  color: AppColor.greyColor.withOpacity(0.5),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ClickProtector.run(() {
                        if (onConfirm != null) onConfirm();
                      });
                    },
                    child: Ink(
                      height: 35.h,
                      child: Center(
                        child: Text(
                          confirmText ?? "Confirm",
                          style: AppTextStyle.regular15(
                            AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : InkWell(
              onTap: () {
                ClickProtector.run(() {
                  if (onConfirm != null) onConfirm();
                });
              },
              child: Ink(
                height: 35.h,
                child: Center(
                  child: Text(
                    confirmText ?? "Confirm",
                    style: AppTextStyle.regular15(
                      AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}