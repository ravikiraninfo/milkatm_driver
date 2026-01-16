import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/common/common_flex.dart';
import 'package:milkshop_driver/utils/app_color.dart';
import '../../api/api_url.dart';
import '../../common/common_buttons.dart';
import '../../common/common_divider.dart';
import '../../common/common_snackbar.dart';
import '../../data/local/shared_preference/shared_preference.dart';
import '../../data/local/shared_preference/shared_preference_key.dart';
import '../../services/base_services.dart';
import '../../utils/app_text_style.dart';
import '../inventory_stock_page/inventory_stock_page.dart';
import '../notification_setting_page/notification_setting_page.dart';
import '../refile_van_page/refill_page_model.dart';
import '../route_map_page/route_map_page.dart';
import 'package:dio/dio.dart' as d;

import 'homepage_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoading = false.obs;
  Rx<HomepageModel> homepageModel = HomepageModel().obs;
  Future<d.Response?> getData()async{
    isLoading.value = true;
    d.Response? response = await BaseService().get(ApiUrl.summary(MySharedPref.getString(PreferenceKey.driverID)));
    if (response?.statusCode == 200) {
      isLoading.value = false;
      homepageModel.value = HomepageModel.fromJson(response!.data['data'][0]);
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
  Rx<VanDetails> vanDetails = VanDetails().obs;

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
    getData();
    startRoute();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  _scaffoldKey,
      drawer: const _HomeDrawer(),
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
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Image.asset('assets/images/woman.png',height: 34.h,width: 34.h,)),
                  w(10),
                  Text('Dustin Trailblazer',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Obx(()=>isLoading.value?Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ):Expanded(
              child: Container(
                width: double.infinity,
                color: AppColor.whiteColor,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      h(20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.h),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blackColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: AppColor.greyColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70.h,
                              width: 70.h,
                              padding: EdgeInsets.all(10.h),
                              margin: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: AppColor.lightRedColor,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/images/milk-van.png'),
                            ),
                            w(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("My Toddy's Route",style: AppTextStyle.regular20(AppColor.blackColor),textAlign: TextAlign.center,),
                                h(5),
                                Text("Namaste india food",style: AppTextStyle.regular16(AppColor.blackColor),textAlign: TextAlign.center,),
                                h(5),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 8.h),
                                  child: Image.asset('assets/images/track.png',height: 25.h,width: 75.h,),
                                ),
                                Text("South point mall",style: AppTextStyle.regular16(AppColor.blackColor),textAlign: TextAlign.center,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      h(20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.h),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blackColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: AppColor.greyColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70.h,
                              width: 70.h,
                              padding: EdgeInsets.all(10.h),
                              margin: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: AppColor.lightRedColor,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/images/milk-can.png'),
                            ),
                            w(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("My Sale",style: AppTextStyle.regular20(AppColor.blackColor),textAlign: TextAlign.center,),
                                h(5),
                                Text("${(homepageModel.value.deliveredMilkLiter??0)+(homepageModel.value.walkInMilkLiter??0)} Liter",style: AppTextStyle.regular16(AppColor.blackColor),textAlign: TextAlign.center,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      h(20), Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.h),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blackColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: AppColor.greyColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70.h,
                              width: 70.h,
                              padding: EdgeInsets.all(10.h),
                              margin: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: AppColor.lightRedColor,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/images/customer.png'),
                            ),
                            w(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Scheduled Orders",style: AppTextStyle.regular20(AppColor.blackColor),textAlign: TextAlign.center,),
                                h(5),
                                Text("${homepageModel.value.totalUserCount??0} Customers",style: AppTextStyle.regular16(AppColor.blackColor),textAlign: TextAlign.center,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      h(20), Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10.h),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.blackColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: AppColor.greyColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70.h,
                              width: 70.h,
                              padding: EdgeInsets.all(10.h),
                              margin: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: AppColor.lightRedColor,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('assets/images/customer.png'),
                            ),
                            w(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Walking Order",style: AppTextStyle.regular20(AppColor.blackColor),textAlign: TextAlign.center,),
                                h(5),
                                Text("${homepageModel.value.walkInUserCount??0} Customers",style: AppTextStyle.regular16(AppColor.blackColor),textAlign: TextAlign.center,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      h(20),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomFilledButton(
                          height: 50.h,
                          onPressed: (){
                            Get.to(()=>const RouteMapPage(),arguments: vanDetails.value.data?[0].route?.pickupPoints??[]);

                          }, title: "Route map view",
                        ),
                      ),
                      h(30),
                    ],
                  ),
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}

class CommonListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String trackImagePath;
  final String location;

  const CommonListItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.trackImagePath,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10.h),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColor.greyColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 70.h,
            width: 70.h,
            padding: EdgeInsets.all(10.h),
            margin: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              color: AppColor.lightRedColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(imagePath),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.regular20(AppColor.blackColor), textAlign: TextAlign.center),
              Text(subtitle, style: AppTextStyle.regular16(AppColor.blackColor), textAlign: TextAlign.center),
              Image.asset(trackImagePath, height: 25.h, width: 75.h),
              Text(location, style: AppTextStyle.regular16(AppColor.blackColor), textAlign: TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 96.h,
                  width: 96.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE6E6E6), width: 4.w),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/woman.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              h(18),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Jogindar Mistry',
                      style: AppTextStyle.medium20(AppColor.blackColor),
                    ),
                    h(6),
                    Text(
                      '+91 XXXX XXXX XX',
                      style: AppTextStyle.regular14(AppColor.lightBlackColor1),
                    ),
                  ],
                ),
              ),
              h(32),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/profile_setting.png',
                title: 'Profile setting',
                onTap: () {},
              ),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/notification.png',
                title: 'Notifications',
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const NotificationSettingPage());
                },
              ),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/inventory.png',
                title: 'Inventory',
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const InventoryStockPage());
                },
              ),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/logout.png',
                title: 'Logout',
                onTap: () {},
              ),
              divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.trailingColor,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final Color? trailingColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 26.h,
              width: 26.h,
              color: AppColor.blackColor,
              fit: BoxFit.contain,
            ),
            w(16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.regular16(AppColor.blackColor),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: trailingColor ?? AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}