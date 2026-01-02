import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class StopListViewPage extends StatefulWidget {
  const StopListViewPage({super.key});

  @override
  State<StopListViewPage> createState() => _StopListViewPageState();
}

class _StopListViewPageState extends State<StopListViewPage> {
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
                  Text('Stop List View',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                // itemCount: 10,
                itemBuilder: (context,i){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.greyColor.withOpacity(0.3),
                          blurRadius: 4.r,
                          offset: Offset(0,2.h),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 64.h,
                          width: 64.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F1FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:Icon(Icons.location_on,color: AppColor.blackAccentColor,size: 48.h,),
                        ),
                        w(12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Agaz Unit',style: AppTextStyle.medium16(AppColor.blackAccentColor),),
                            h(6),
                            Text('Total customers : 10',style: AppTextStyle.regular14(AppColor.blackAccentColor),),
                            h(6),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGreyColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text('02',style: AppTextStyle.regular10(AppColor.blackAccentColor),),
                                ),
                                w(8),
                                Container(
                                  padding: EdgeInsets.all(6.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.greenColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text('07',style: AppTextStyle.regular10(AppColor.whiteColor),),
                                ),
                                w(8),
                                Container(
                                  padding: EdgeInsets.all(6.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text('01',style: AppTextStyle.regular10(AppColor.whiteColor),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
