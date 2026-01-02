import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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
                  Text('Order Details',style: AppTextStyle.medium20(AppColor.whiteColor),),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 94.h,
                                  width: 94.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.lightGreyColor,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  // padding: EdgeInsets.all(12.w),
                                  child: Image.asset(
                                    'assets/images/milk_image.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                w(16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subscription',
                                        style: AppTextStyle.regular16(AppColor.lightBlackColor1),
                                      ),
                                      h(10),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          color: AppColor.greenColor,
                                          borderRadius: BorderRadius.circular(30.r),
                                        ),
                                        child: Text(
                                          'Bi-Weekly',
                                          style: AppTextStyle.medium16(AppColor.whiteColor),
                                        ),
                                      ),
                                      h(16),
                                      SizedBox(
                                        height: 8.h,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.r),
                                          child: LinearProgressIndicator(
                                            value: 0.72,
                                            backgroundColor: AppColor.lightGreyColor,
                                            valueColor: AlwaysStoppedAnimation<Color>(AppColor.greenColor),
                                          ),
                                        ),
                                      ),
                                      h(8),
                                      Text(
                                        'Only 3 days are left',
                                        style: AppTextStyle.regular13(AppColor.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            h(24),
                            Text(
                              'Order Id',
                              style: AppTextStyle.regular16(AppColor.blackAccentColor),
                            ),
                            h(4),
                            Text(
                              '#16122025TUE',
                              style: AppTextStyle.medium24(AppColor.blackColor),
                            ),
                            h(12),
                            Text(
                              'Shrikant Gadkar',
                              style: AppTextStyle.medium20(AppColor.blackColor),
                            ),
                            h(8),
                            Text(
                              '+91 XXXX XXXX XX',
                              style: AppTextStyle.regular14(AppColor.blackColor),
                            ),
                            h(12),
                            Text(
                              'Flat No. 57, IOC Rd, opposite Hanumanji Mandir, Akash Ganga Society, Chandkheda, Ahmedabad, Gujarat 382424',
                              style: AppTextStyle.regular16(AppColor.blackColor),
                            ),
                            h(26),
                            _DetailRow(
                              items: const [
                                _DetailItem(title: 'Quantity', value: '1 ltr'),
                                _DetailItem(title: 'Amount', value: '₹55'),
                                _DetailItem(title: 'Milk Type', value: 'Toned Loose Milk'),
                              ],
                            ),
                            h(18),
                            _DetailRow(
                              items: const [
                                _DetailItem(title: 'Delivery Time', value: 'Morning'),
                                _DetailItem(title: 'Delivery Type', value: 'Self Pickup'),
                                _DetailItem(title: 'Frequency', value: 'Daily'),
                              ],
                            ),
                            h(28),
                            CustomFilledButton(
                              onPressed: () {},
                              backgroundColor: AppColor.yellowColor,
                              title: 'Dispense',
                              style: AppTextStyle.medium18(AppColor.whiteColor),
                              height: 54.h,
                            ),
                            h(16),
                            CustomFilledButton(
                              onPressed: () {},
                              backgroundColor: AppColor.primaryColor,
                              title: 'Mark Delivery',
                              style: AppTextStyle.medium18(AppColor.whiteColor),
                              height: 54.h,
                            ),
                          ],
                        ),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.items});

  final List<_DetailItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(items.length, (index) {
        final bool isLast = index == items.length - 1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 12.w),
            child: _MetaTile(item: items[index]),
          ),
        );
      }),
    );
  }
}

class _MetaTile extends StatelessWidget {
  const _MetaTile({required this.item});

  final _DetailItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: AppTextStyle.medium15(AppColor.lightBlackColor),
        ),
        h(10),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColor.lightGreyColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            item.value,
            textAlign: TextAlign.center,
            style: AppTextStyle.medium16(AppColor.blackColor),
          ),
        ),
      ],
    );
  }
}

class _DetailItem {
  const _DetailItem({required this.title, required this.value});

  final String title;
  final String value;
}
