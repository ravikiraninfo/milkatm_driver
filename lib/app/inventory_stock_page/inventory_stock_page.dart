import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class InventoryStockPage extends StatefulWidget {
  const InventoryStockPage({super.key});

  @override
  State<InventoryStockPage> createState() => _InventoryStockPageState();
}

class _InventoryStockPageState extends State<InventoryStockPage> {
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
                  Text('Inventory',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColor.lightGreyColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blackColor.withOpacity(0.04),
                              blurRadius: 16.r,
                              offset: Offset(0, 8.h),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 160.h,
                              width: 160.h,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 160.h,
                                    width: 160.h,
                                    child: CircularProgressIndicator(
                                      value: 0.9,
                                      strokeWidth: 16.w,
                                      valueColor: const AlwaysStoppedAnimation<Color>(AppColor.greenColor),
                                        color: AppColor.greenColor,
                                      backgroundColor: AppColor.greyColor.withOpacity(0.3),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '90%',
                                        style: AppTextStyle.bold40(AppColor.blackColor),
                                      ),
                                      h(8),
                                      Text(
                                        'Great Job',
                                        style: AppTextStyle.regular14(AppColor.blackColor),
                                      ),
                                      h(2),
                                      Text(
                                        'Excellent Sale',
                                        style: AppTextStyle.regular14(AppColor.blackColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            h(26),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: const [
                                  _SummaryTile(title: 'Total Milk', value: '300 ltr'),
                                  _SummaryTile(title: 'Sold Out', value: '280 ltr'),
                                  _SummaryTile(title: 'In Stock', value: '20 ltr'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _InventoryCard(
                        iconPath: 'assets/images/subscribed.png',
                        title: 'Subscribed Milk',
                        soldOut: '190 ltr',
                        inStock: '10 ltr',
                      ),
                      h(18),
                      const _InventoryCard(
                        iconPath: 'assets/images/milk.png',
                        title: 'Surplus Milk',
                        soldOut: '90 ltr',
                        inStock: '10 ltr',
                      ),
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

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle.regular16(AppColor.lightBlackColor1),
          ),
          h(10),
          Text(
            value,
            style: AppTextStyle.bold20(AppColor.blackColor),
          ),
        ],
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  const _InventoryCard({
    required this.iconPath,
    required this.title,
    required this.soldOut,
    required this.inStock,
  });

  final String iconPath;
  final String title;
  final String soldOut;
  final String inStock;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.04),
            blurRadius: 16.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            iconPath,
            height: 60.h,
            width: 60.h,
            fit: BoxFit.contain,
          ),
          w(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.medium26(AppColor.blackColor),
                ),
                h(12),
                Text(
                  'Sold Out: $soldOut',
                  style: AppTextStyle.medium18(AppColor.blackColor),
                ),
                h(6),
                Text(
                  'In Stock: $inStock',
                  style: AppTextStyle.medium18(AppColor.blackColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


