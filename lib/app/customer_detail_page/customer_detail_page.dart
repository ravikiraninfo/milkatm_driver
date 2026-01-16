import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../refile_van_page/refill_page_model.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({super.key});

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  late User user;

  @override
  void initState() {
    user = Get.arguments;
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
                  Text('Customer Details',style: AppTextStyle.medium20(AppColor.whiteColor),),
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
                            Text(
                              user.fullName??'--',
                              style: AppTextStyle.medium20(AppColor.blackColor),
                            ),
                            h(8),
                            Text(
                              '+91 ${user.mobile??'--'}',
                              style: AppTextStyle.regular14(AppColor.blackColor),
                            ),
                            h(12),
                            Text(
                              user.orderId?.address?.address??"--",
                              style: AppTextStyle.regular16(AppColor.lightBlackColor1),
                            ),
                            h(20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
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
                            ),
                            h(24),
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
                            h(10),
                            Text(
                              'Only 3 days are left',
                              style: AppTextStyle.regular10(AppColor.blackColor),
                            ),
                            h(26),
                            _DetailRow(
                              items:  [
                                _DetailItem(title: 'Quantity', value: "${user.liter??0} ltr"),
                                _DetailItem(title: 'Amount', value: "₹ ${user.orderId?.price??0}"),
                                _DetailItem(title: 'Milk Type', value: '${user.orderId?.milkType?.name}'),
                              ],
                            ),
                            h(18),
                            _DetailRow(
                              items:  [
                                _DetailItem(title: 'Delivery Time', value: user.orderId?.orderDate != null
                                ? DateFormat('d MMM, y').format(DateTime.parse(user.orderId!.orderDate!.toString()))
                                : '--',),
                                _DetailItem(title: 'Delivery Type', value: '${user.orderId?.deliveryType?.name}'),
                                _DetailItem(title: 'Frequency', value: '${user.orderId?.frequency}'),
                              ],
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
          textAlign: TextAlign.center,
          item.title,
          style: AppTextStyle.regular16(AppColor.lightBlackColor),
        ),
        h(10),
        Container(
          // height: 40.h,
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
            style: AppTextStyle.regular16(AppColor.blackColor),
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
