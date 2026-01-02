import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/common_buttons.dart';
import '../../common/common_textfield.dart';
import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class WalkinNewOrder extends StatefulWidget {
  const WalkinNewOrder({super.key});

  @override
  State<WalkinNewOrder> createState() => _WalkinNewOrderState();
}

class _WalkinNewOrderState extends State<WalkinNewOrder> {
  final TextEditingController _mobileController =
      TextEditingController(text: '+91 XXXX XXXX XX');
  final TextEditingController _nameController =
      TextEditingController(text: 'Shrikant Gadkar');

  int _quantity = 1;

  @override
  void dispose() {
    _mobileController.dispose();
    _nameController.dispose();
    super.dispose();
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
                  Text('Walk In Order',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColor.whiteColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 140.h,
                          width: 140.h,
                          decoration: BoxDecoration(
                            color:AppColor.lightRedColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/milk.png',
                            height: 100.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      h(32),
                      Text(
                        'Enter mobile number',
                        style: AppTextStyle.regular16(AppColor.blackColor),
                      ),
                      h(10),
                      CustomTextInput(
                        textEditController: _mobileController,
                        inputType: InputType.number,
                        borderColor: const Color(0xFFE6E6E6),
                        textColor: AppColor.blackColor,
                        hintTextString: '+91 XXXX XXXX XX',
                        cornerRadius: 16.r,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        maxLength: 10,
                        filled: true,
                        fillColor: AppColor.whiteColor,
                      ),
                      h(24),
                      Text(
                        'Enter full name',
                        style: AppTextStyle.regular16(AppColor.blackColor),
                      ),
                      h(10),
                      CustomTextInput(
                        textEditController: _nameController,
                        inputType: InputType.defaults,
                        borderColor: const Color(0xFFE6E6E6),
                        textColor: AppColor.blackColor,
                        hintTextString: 'Shrikant Gadkar',
                        cornerRadius: 16.r,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        filled: true,
                        fillColor: AppColor.whiteColor,
                      ),
                      h(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Milk in litter',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                          Text(
                            'Milk Type',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                        ],
                      ),
                      h(12),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: const Color(0xFFF6B4B4)),
                            ),
                            child: Row(
                              children: [
                                _QuantityButton(
                                  icon: Icons.remove,
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() => _quantity--);
                                    }
                                  },
                                ),
                                Container(
                                  width: 48.w,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$_quantity',
                                    style: AppTextStyle.medium18(AppColor.blackColor),
                                  ),
                                ),
                                _QuantityButton(
                                  icon: Icons.add,
                                  onTap: () {
                                    setState(() => _quantity++);
                                  },
                                ),
                              ],
                            ),
                          ),
                          w(20),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                'Toned Loose Milk',
                                style: AppTextStyle.regular16(AppColor.blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      h(40),
                      CustomFilledButton(
                        onPressed: () {},
                        title: 'Proceed to payment',

                        backgroundColor: AppColor.primaryColor,
                        style: AppTextStyle.medium18(AppColor.whiteColor),
                        height: 56.h,
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

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 36.h,
        width: 36.w,
        decoration: BoxDecoration(
          color: AppColor.lightRedColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppColor.whiteColor, size: 20.sp),
      ),
    );
  }
}


