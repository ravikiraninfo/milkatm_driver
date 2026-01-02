import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
                  Text('Payment',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(child: Column(
              children: [
                Image.asset('assets/images/qr.png',height: 350.h,width: 350.h,),
                Text('Dustin Trailblazer',style: AppTextStyle.medium20(AppColor.blackColor),),
                h(10),
                Text('UPI ID : namaste@ybl',style: AppTextStyle.medium20(AppColor.blackColor),),
                spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomFilledButton(
                    onPressed: () {},
                    title: 'Proceed',
                    backgroundColor: AppColor.primaryColor,
                    style: AppTextStyle.medium18(AppColor.whiteColor),
                    height: 56.h,
                  ),
                ),
                h(20),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
