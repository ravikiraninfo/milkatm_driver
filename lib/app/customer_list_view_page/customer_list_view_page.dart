import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/app/customer_detail_page/customer_detail_page.dart';
import 'package:milkshop_driver/common/common_textfield.dart';

import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../refile_van_page/refill_page_model.dart';
import 'customer_list_view_controller.dart';


class CustomerListViewPage extends StatefulWidget {
  const CustomerListViewPage({super.key});

  @override
  State<CustomerListViewPage> createState() => _CustomerListViewPageState();
}

class _CustomerListViewPageState extends State<CustomerListViewPage> {
  List<User> _resolveUsers(dynamic args) {
    if (args is List<User>) {
      return args;
    }
    if (args is List) {
      return args
          .map((user) => user is User
          ? user
          : User.fromJson(Map<String, dynamic>.from(user as Map)))
          .toList();
    }
    return <User>[];
  }

  late final CustomerListViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(CustomerListViewController());
    final List<User> initialUsers = _resolveUsers(Get.arguments);
    _controller.setUsers(initialUsers);
  }

  @override
  void dispose() {
    if (Get.isRegistered<CustomerListViewController>()) {
      Get.delete<CustomerListViewController>();
    }
    super.dispose();
  }

  void _openFilterSheet() {
    _controller.beginFilterSelection();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext context) {
        final CustomerListViewController controller = Get.find<CustomerListViewController>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Filter By', style: AppTextStyle.medium20(AppColor.blackColor)),
                    spacer(),
                    GestureDetector(
                      onTap: Get.back,
                      child: Image.asset('assets/images/close.png', height: 20.h, width: 20.h),
                    ),
                  ],
                ),
                h(24),
                Obx(() {
                  final List<String> options = controller.filterOptions;
                  return Column(
                    children: List<Widget>.generate(options.length, (int index) {
                      final String option = options[index];
                      final bool isSelected = controller.draftFilter.value == option;
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () => controller.selectFilterOption(option),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: AppTextStyle.regular17(AppColor.blackColor),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(Icons.check, color: AppColor.primaryColor, size: 20.w),
                                ],
                              ),
                            ),
                          ),
                          // if (index < options.length - 1)
                          Divider(color: AppColor.greyColor, height: 1.h),
                        ],
                      );
                    }),
                  );
                }),
                h(24),
                SizedBox(
                  height: 50.h,
                  child: CustomFilledButton(
                    onPressed: () {
                      controller.applyDraftFilter();
                      Get.back();
                    },
                    title: 'Apply Filter',
                    backgroundColor: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                  Text('Customer List View',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20.h,),
                ],
              ),
            ),
            Obx(() {
              if (!_controller.hasUsers) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_controller.selectedFilter.value, style: AppTextStyle.regular17(AppColor.blackColor)),
                    w(12),
                    InkWell(
                      onTap: _openFilterSheet,
                      child: Image.asset('assets/images/filter.png', height: 20.h, width: 20.h),
                    ),
                  ],
                ),
              );
            }),

            h(10),
            Expanded(
              child: Obx(() {
                if (!_controller.hasUsers) {
                  return Center(
                    child: Text(
                      "No Customers Available",
                      style: AppTextStyle.medium16(AppColor.blackColor),
                    ),
                  );
                }

                if (_controller.filteredUsers.isEmpty) {
                  return Center(
                    child: Text(
                      "No customers match the selected filter",
                      style: AppTextStyle.medium16(AppColor.blackColor),
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: _controller.filteredUsers.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,i){
                      final user = _controller.filteredUsers[i];
                      return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                      child:  InkWell(
                        onTap: (){
                          Get.to(()=> const CustomerDetailPage(),arguments: user);
                        },
                        child: Ink(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEFEFE),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F1FF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Image.asset("assets/images/milk_image.png"),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              user.fullName??'--',
                                              style:AppTextStyle.medium16(AppColor.blackAccentColor),
                                            ),
                                            spacer(),
                                            Container(
                                              height: 24.h,
                                              width: 24.h,
                                              decoration: BoxDecoration(
                                                color:user.orderId?.status=="delivered"? AppColor.greenColor:user.orderId?.status=="active"?AppColor.grey50:user.orderId?.status=="pause"?AppColor.yellowColor:user.orderId?.status=="missed"?AppColor.redColor:AppColor.grey50,
                                                shape: BoxShape.circle,
                                              ),
                                              child:user.orderId?.status!="active"?const Icon(
                                                Icons.check,
                                                size: 14,
                                                color: Colors.white,
                                              ):const SizedBox.shrink(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: <Widget>[
                                        _OrderMetric(title: 'Qty', value: "${user.liter??0}ltr"),
                                        const SizedBox(width: 14),
                                        _OrderMetric(title: 'Amount', value:"₹0"),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Text(
                                          "Delivery Type:",
                                          style: AppTextStyle.medium14( AppColor.blackAccentColor),
                                        ),
                                        w(4),
                                        Text(
                                          user.orderId?.deliveryType?.name??"-",
                                          style: AppTextStyle.medium16( AppColor.blackColor),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
              }),
            ),
          ],
        ),
      ),
    );
  }
}




class _OrderMetric extends StatelessWidget {
  const _OrderMetric({required this.title, required this.value});

  final String title;
  final  dynamic value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$title :",
          style: AppTextStyle.medium14( AppColor.blackAccentColor),
        ),
        w(4),
        Text(
          "$value",
          style: AppTextStyle.medium16( AppColor.blackColor),
        ),
      ],
    );
  }
}
