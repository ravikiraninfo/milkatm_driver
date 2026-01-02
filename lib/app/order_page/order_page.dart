import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/common/common_textfield.dart';

import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import 'order_page_controller.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<_OrderSummary> _orders = const <_OrderSummary>[
    _OrderSummary(
      id: '#16122025TUE',
      customerName: 'Jogindar Mistry',
      quantity: '1ltr',
      amount: '₹30',
      statusLabel: 'Delivered',
      statusColor: Color(0xFF4CAF50),
      deliveryTime: '1 Dec 2025, 7:00AM',
    ),
    _OrderSummary(
      id: '#16122025TUE',
      customerName: 'Jogindar Mistry',
      quantity: '1ltr',
      amount: '₹30',
      statusLabel: 'Delivered',
      statusColor: Color(0xFF4CAF50),
      deliveryTime: '1 Dec 2025, 7:00AM',
    ),
    _OrderSummary(
      id: '#16122025TUE',
      customerName: 'Jogindar Mistry',
      quantity: '1ltr',
      amount: '₹30',
      statusLabel: 'Delivered',
      statusColor: Color(0xFFFFC107),
      deliveryTime: '1 Dec 2025, 7:00AM',
    ),
    _OrderSummary(
      id: '#16122025TUE',
      customerName: 'Jogindar Mistry',
      quantity: '1ltr',
      amount: '₹30',
      statusLabel: 'Delivered',
      statusColor: Color(0xFFF44336),
      deliveryTime: '1 Dec 2025, 7:00AM',
    ),
  ];

  late final OrderPageController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(OrderPageController());
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (Get.isRegistered<OrderPageController>()) {
      Get.delete<OrderPageController>();
    }
    super.dispose();
  }

  void _openFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext context) {
        final OrderPageController controller = Get.find<OrderPageController>();
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
                      final bool isSelected = controller.selectedFilter.value == option;
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () => controller.selectFilter(option),
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
                    onPressed: Get.back,
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
              padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 20.h),
              child: Row(
                children: [
                  Text('Orders',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20.h,),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 16.h),
              child: Row(
                children: [
                  Text('16 Dec 2025',style: AppTextStyle.bold17(AppColor.blackColor),),
                  w(10),
                  Image.asset('assets/images/calender.png',height: 20.h,width: 20.h,color: AppColor.blackAccentColor,),
                  spacer(),
                  Obx(() => Text(_controller.selectedFilter.value, style: AppTextStyle.regular17(AppColor.blackColor))),
                  w(12),
                  InkWell(
                      onTap: _openFilterSheet,
                      child: Image.asset('assets/images/filter.png',height: 20.h,width: 20.h,)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextInput(
                fillColor: AppColor.whiteColor,
                filled: true,
                textEditController: _searchController,
                hintTextString: 'Search by customer name, order id...',
                borderColor: AppColor.greyColor,
                prefixIcon: Icon(Icons.search,color: AppColor.greyColor,),
                suffixIcon: null,
              ),
            ),
            h(10),
            Expanded(
              child: ListView.builder(
                  itemCount: _orders.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,i){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                  child: _OrderCard(_orders[i]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderSummary {
  const _OrderSummary({
    required this.id,
    required this.customerName,
    required this.quantity,
    required this.amount,
    required this.statusLabel,
    required this.statusColor,
    required this.deliveryTime,
  });

  final String id;
  final String customerName;
  final String quantity;
  final String amount;
  final String statusLabel;
  final Color statusColor;
  final String deliveryTime;
}

class _OrderCard extends StatelessWidget {
  const _OrderCard(this.summary);

  final _OrderSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 64,
            width: 64,
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
                          summary.id,
                          style: AppTextStyle.medium12(AppColor.blackAccentColor),
                        ),
                        spacer(),
                        Text(
                          summary.deliveryTime,
                          style: AppTextStyle.medium12(AppColor.blackAccentColor),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: summary.statusColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      summary.customerName,
                      style:AppTextStyle.bold16(AppColor.blackColor),
                    ),

                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _OrderMetric(title: 'Qty', value: summary.quantity),
                    const SizedBox(width: 24),
                    _OrderMetric(title: 'Amount', value: summary.amount),
                    const SizedBox(width: 24),
                    _OrderMetric(title: 'Status', value: summary.statusLabel),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderMetric extends StatelessWidget {
  const _OrderMetric({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyle.medium14( AppColor.blackAccentColor),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.medium16( AppColor.blackColor),
        ),
      ],
    );
  }
}
