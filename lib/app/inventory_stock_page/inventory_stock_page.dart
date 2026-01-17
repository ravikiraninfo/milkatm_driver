import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../api/api_url.dart';
import '../../common/common_flex.dart';
import '../../common/common_snackbar.dart';
import '../../data/local/shared_preference/shared_preference.dart';
import '../../data/local/shared_preference/shared_preference_key.dart';
import '../../services/base_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../refile_van_page/refill_page_model.dart';

class InventoryStockPage extends StatefulWidget {
  const InventoryStockPage({super.key});

  @override
  State<InventoryStockPage> createState() => _InventoryStockPageState();
}

class _InventoryStockPageState extends State<InventoryStockPage> {
  Rx<VanDetails> vanDetails = VanDetails().obs;

  RxBool isLoading = false.obs;
  Future<d.Response?> startRoute()async{
    isLoading.value = true;
    d.Response? response = await BaseService().get(ApiUrl.vanRoutes(MySharedPref.getString(PreferenceKey.driverID)));
    if (response?.statusCode == 200) {
      isLoading.value = false;
      vanDetails.value = VanDetails.fromJson(response!.data);
      return response;
    }else{
      isLoading.value = false;
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
    }
    return null;
  }
  @override
  void initState() {
    startRoute();
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
                  Text('Inventory',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child:Obx(()=>isLoading.value? Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ):Container(
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
                                children:  [
                                  _SummaryTile(title: 'Total Milk', value: '${vanDetails.value.data?[0].totalCapacity??0} ltr'),
                                  _SummaryTile(title: 'Sold Out', value:  '${vanDetails.value.data?[0].deliveredMilkLiter??0} ltr'),
                                  _SummaryTile(title: 'In Stock', value: '${(vanDetails.value.data?[0].subscriptionMilkLiter ?? 0) - (vanDetails.value.data?[0].deliveredMilkLiter ?? 0)} ltr'),                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                       _InventoryCard(
                        iconPath: 'assets/images/subscribed.png',
                        title: 'Subscribed Milk',
                        soldOut: '${(vanDetails.value.data?[0].subscriptionMilkLiter ?? 0) - (vanDetails.value.data?[0].deliveredMilkLiter ?? 0)} ltr',
                        inStock: '${vanDetails.value.data?[0].totalCapacity??0} ltr',
                      ),
                      h(18),
                       _InventoryCard(
                        iconPath: 'assets/images/milk.png',
                        title: 'Surplus Milk',
                        soldOut:'${(vanDetails.value.data?[0].surplusMilkLiter ?? 0) - (vanDetails.value.data?[0].deliveredMilkLiter ?? 0)} ltr',
                        inStock: '${vanDetails.value.data?[0].totalCapacity??0} ltr',
                      ),
                    ],
                  ),
                ),
              ),),
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


