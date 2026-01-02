import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              spacer(),

              Image.asset(
                "assets/images/done.png",
                height: 110.h,
                width: 110.h,
              ),
              h(30),
              Text(
                'Congratulations!!!',
                style: AppTextStyle.medium24(AppColor.blackColor),
              ),
              h(10),
              Text(
                'Your orders has been delivered successfully',
                style: AppTextStyle.regular16(AppColor.greyColor),
              ),
              spacer(),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Back to Home',
                  style: AppTextStyle.medium16(AppColor.blueColor),
                ),
              ),
              h(10),
            ],
          ),
        ),
      ),
    );
  }
}
