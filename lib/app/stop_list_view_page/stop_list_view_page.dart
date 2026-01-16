import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/app/customer_list_view_page/customer_list_view_page.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../refile_van_page/refill_page_model.dart';

class StopListViewPage extends StatefulWidget {
  const StopListViewPage({super.key});

  @override
  State<StopListViewPage> createState() => _StopListViewPageState();
}

class _StopListViewPageState extends State<StopListViewPage> {
  late final List<PickupPoint> pickupPoints;

  List<PickupPoint> _resolvePickupPoints(dynamic args) {
    if (args is List<PickupPoint>) {
      return args;
    }
    if (args is List) {
      return args
          .map((point) => point is PickupPoint
          ? point
          : PickupPoint.fromJson(Map<String, dynamic>.from(point as Map)))
          .toList();
    }
    return [];
  }
  @override
  void initState() {
    pickupPoints = _resolvePickupPoints(Get.arguments);
    super.initState();
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
              child: pickupPoints.length==0?
              Center(
                child: Text(
                  "No Pickup Points Available",
                  style: AppTextStyle.medium16(AppColor.blackColor),
                ),
              )
                  :ListView.builder(
                itemCount: pickupPoints.length,
                itemBuilder: (context,i){
                  final point = pickupPoints[i];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>const CustomerListViewPage(),arguments: point.users);
                      },
                      child: Ink(
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
                                Text(point.name??"-",style: AppTextStyle.medium16(AppColor.blackAccentColor),),
                                h(6),
                                Text('Total customers : ${point.users?.length??0}',style: AppTextStyle.regular14(AppColor.blackAccentColor),),
                                h(6),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6.h),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightGreyColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text('${point.pendingCount??0}',style: AppTextStyle.regular10(AppColor.blackAccentColor),),
                                    ),
                                    w(8),
                                    Container(
                                      padding: EdgeInsets.all(6.h),
                                      decoration: BoxDecoration(
                                        color: AppColor.greenColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text('${point.deliveredCount??0}',style: AppTextStyle.regular10(AppColor.whiteColor),),
                                    ),
                                    w(8),
                                    Container(
                                      padding: EdgeInsets.all(6.h),
                                      decoration: BoxDecoration(
                                        color: AppColor.yellowColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text('${point.pausedCount??0}',style: AppTextStyle.regular10(AppColor.whiteColor),),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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
