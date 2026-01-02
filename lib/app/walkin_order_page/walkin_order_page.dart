import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class WalkinOrderPage extends StatefulWidget {
  const WalkinOrderPage({super.key});

  @override
  State<WalkinOrderPage> createState() => _WalkinOrderPageState();
}

class _WalkinOrderPageState extends State<WalkinOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: AppColor.lightGreyColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'In Stock Milk :',
                        style: AppTextStyle.medium18(AppColor.blackColor),
                      ),

                      _StockTile(label: 'Subscribed Milk', value: '10 ltr'),
                      _StockTile(label: 'Surplus Milk', value: '10 ltr'),
                    ],
                  ),
                ),
                h(24),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE92E36), Color(0xFFFF625A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(26.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.25),
                        blurRadius: 24.r,
                        offset: Offset(0, 12.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Walkin Sale',
                        style: AppTextStyle.regular16(AppColor.whiteColor),
                      ),
                      h(20),
                      Text(
                        '₹220',
                        style: AppTextStyle.bold50(AppColor.whiteColor),
                      ),
                      h(10),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Place New Order',
                            style: AppTextStyle.medium16(AppColor.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                h(24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.separated(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => h(16),
                    itemBuilder: (context, index) {
                      return const _OrderTile();
                    },
                  ),
                ),
                h(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StockTile extends StatelessWidget {
  const _StockTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyle.medium18(AppColor.blackColor),
        ),
        h(6),
        Text(
          label,
          style: AppTextStyle.regular12(AppColor.blackAccentColor),
        ),
      ],
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: AppColor.lightGreyColor),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/credited.png',
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ),
          w(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order amount credited',
                  style: AppTextStyle.medium16(AppColor.blackColor),
                ),
                h(6),
                Text(
                  '#12122025FRI',
                  style: AppTextStyle.regular12(AppColor.blackAccentColor),
                ),
                h(6),
                Text(
                  '16 Dec 2025, 10:55 PM',
                  style: AppTextStyle.regular12(AppColor.blackAccentColor),
                ),
              ],
            ),
          ),
          w(12),
          Text(
            '₹55',
            style: AppTextStyle.medium16(AppColor.greenColor),
          ),
        ],
      ),
    );
  }
}

