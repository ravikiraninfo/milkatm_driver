import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/common/common_flex.dart';
import 'package:milkshop_driver/utils/app_color.dart';
import '../../common/common_buttons.dart';
import '../../utils/app_text_style.dart';
import '../refile_van_page/refile_van_page.dart';
import 'package:intl/intl.dart';

import 'attendance_page_controller.dart';
class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  AttendancePageController controller = Get.put(AttendancePageController());
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 14.h),
              child: Row(
                children: [
                  Image.asset('assets/images/woman.png',height: 34.h,width: 34.h,),
                  w(10),
                  Text('Dustin Trailblazer',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColor.whiteColor,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    spacer(),
                    Container(
                      alignment: Alignment.center,
                      height: 180.h,
                      width: 180.h,
                      decoration: BoxDecoration(
                        color: AppColor.lightRedColor,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text(
                            DateFormat('hh:mm').format(_now),
                            style: AppTextStyle.bold32(AppColor.blackColor),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            DateFormat('a').format(_now),
                            style: AppTextStyle.bold24(AppColor.blackColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    h(20),
                   Text(DateFormat('dd MMMM yyyy').format(_now), style: AppTextStyle.bold24(AppColor.blackColor), textAlign: TextAlign.center,),
                    spacer(),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomFilledButton(
                        height: 50.h,
                        onPressed: (){
                          Get.to(()=>const RefileVanPage());
                        }, title: "Start Day",
                      ),
                    ),
                    h(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
