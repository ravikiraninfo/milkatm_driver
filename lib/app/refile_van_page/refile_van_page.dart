import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class RefileVanPage extends StatefulWidget {
  const RefileVanPage({super.key});

  @override
  State<RefileVanPage> createState() => _RefileVanPageState();
}

class _RefileVanPageState extends State<RefileVanPage> {
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
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Image.asset('assets/images/back.png',height: 34.h,width: 34.h,)),
                  w(10),
                  Text('Refile Van',style: AppTextStyle.medium20(AppColor.whiteColor),),
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
                    Text('300 ltr',style: AppTextStyle.medium48(AppColor.blackColor),),
                    h(4),
                    Text('Total Milk In Tank',style: AppTextStyle.medium24(AppColor.blackColor),textAlign: TextAlign.center,),
                    h(50),
                    Row(
                      children: [
                        w(18),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            decoration: BoxDecoration(
                              color: AppColor.lightGreyColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Image.asset('assets/images/subscribed.png',height: 62.h,width: 62.h,),
                                h(10),
                                Text('200 ltr',style: AppTextStyle.medium32(AppColor.blackColor),),
                                Text('Subscribed Milk',style: AppTextStyle.medium16(AppColor.blackAccentColor),),
                              ],
                            ),
                          ),
                        ),
                        w(18),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            decoration: BoxDecoration(
                              color: AppColor.lightGreyColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Image.asset('assets/images/milk.png',height: 62.h,width: 62.h,),
                                h(10),
                                Text('100 ltr',style: AppTextStyle.medium32(AppColor.blackColor),),
                                Text('Surplus Milk',style: AppTextStyle.medium16(AppColor.blackAccentColor),),
                              ],
                            ),
                          ),
                        ),
                        w(18),
                      ],
                    ),
                    spacer(),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomFilledButton(
                        height: 50.h,
                        onPressed: (){
                        }, title: "Start Route",
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
