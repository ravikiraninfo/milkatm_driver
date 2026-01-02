import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      'assets/images/back.png',
                      height: 34.h,
                      width: 34.h,
                    ),
                  ),
                  w(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scan QR Code',
                        style: AppTextStyle.medium20(AppColor.whiteColor),
                      ),
                      Text(
                        '#FRI12122025',
                        style: AppTextStyle.regular12(AppColor.lightGreyColor),
                      ),
                    ],
                  ),
                  spacer(),
                  Image.asset(
                    'assets/images/notification.png',
                    height: 20.h,
                    width: 20.h,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/qr.png',
                        height: 350.h,
                        width: 350.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#USERID007',
                            style: AppTextStyle.medium20(AppColor.blackColor),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Text(
                              'Walk In',
                              style: AppTextStyle.regular16(AppColor.whiteColor),
                            ),
                          ),
                        ],
                      ),
                      h(10),
                      Text(
                        'Jogindar Mistry',
                        style: AppTextStyle.medium20(AppColor.blackColor),
                      ),
                      h(10),
                      Text(
                        '+91 XXXX XXXX XX',
                        style: AppTextStyle.medium20(AppColor.blackColor),
                      ),
                      h(10),
                      Text(
                        'Date :  December 2025.',
                        style: AppTextStyle.medium16(AppColor.blackColor),
                      ),
                      h(10),
                      Text(
                        'Quantity:  1Liter',
                        style: AppTextStyle.medium16(AppColor.blackColor),
                      ),
                      h(10),
                      Text(
                        'Amount:  ₹55',
                        style: AppTextStyle.medium16(AppColor.blackColor),
                      ),
                      h(10),
                      Text(
                        'Milk Type: Toned Loose Milk',
                        style: AppTextStyle.medium16(AppColor.blackColor),
                      ),
                      h(30),
                      CustomFilledButton(
                        onPressed: () {},
                        title: 'Done',
                        backgroundColor: AppColor.primaryColor,
                        style: AppTextStyle.medium18(AppColor.whiteColor),
                        height: 56.h,
                      ),
                      h(20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
