import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milkshop_driver/app/walkin_new_order/walkin_new_order.dart';
import 'package:milkshop_driver/common/common_divider.dart';
import '../../common/common_buttons.dart';
import '../../common/common_flex.dart';
import '../../common/common_textfield.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import 'package:dio/dio.dart' as d;
import 'package:milkshop_driver/data/local/shared_preference/shared_preference.dart';
import 'package:milkshop_driver/data/local/shared_preference/shared_preference_key.dart';
import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../services/base_services.dart';

class WalkinNewOrder extends StatefulWidget {
  const WalkinNewOrder({super.key});

  @override
  State<WalkinNewOrder> createState() => _WalkinNewOrderState();
}

class _WalkinNewOrderState extends State<WalkinNewOrder> {
  final TextEditingController _mobileController =
      TextEditingController(text: '+91 XXXX XXXX XX');
  final TextEditingController _nameController =
      TextEditingController();

  int _quantity = 1;
  final List<int> _amountOptions = <int>[20, 50, 60];
  int _selectedAmountIndex = 1;

  int get _selectedAmount => _amountOptions[_selectedAmountIndex];

  Future<d.Response?> createWalkInOrder()async{
    CustomSnackBar.showAlertDialog(context);
    d.Response? response = await BaseService().post(ApiUrl.createWalkInOrder(MySharedPref.getString(PreferenceKey.driverID)),
        data: {
          "driverUserId": MySharedPref.getString(PreferenceKey.driverID),
          "name": _mobileController.text.trim(),
          "mobile": _nameController.text.trim(),
          "milkInLiter": _quantity,
          "milkTypeId": "6953b07ccc26a664c7d565f4"
        }
    );
    if (response?.statusCode == 200) {
      Get.back();
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
      return response;
    }else{
      Get.back();
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
    }
    return null;
  }
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
                        children: [
                          Expanded(child: divider(color: AppColor.greyColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              'Add Milk Quantity',
                              style: AppTextStyle.medium16(AppColor.greyColor),
                            ),
                          ),
                          Expanded(child: divider(color: AppColor.greyColor)),
                        ],
                      ),
                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select amount',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                          Text(
                            'Milk in litter',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                        ],
                      ),
                      h(10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: List<Widget>.generate(_amountOptions.length, (int index) {
                                final bool isSelected = _selectedAmountIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() => _selectedAmountIndex = index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: index == _amountOptions.length - 1 ? 0 : 12.w,
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColor.redColor : AppColor.grey40,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      '₹ ${_amountOptions[index]}',
                                      style: AppTextStyle.medium16(
                                        isSelected ? AppColor.whiteColor : AppColor.blackColor,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Text(
                            '$_quantity ltr',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                        ],
                      ),
                      h(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Milk in litter',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                          Text(
                            'Total Amount',
                            style: AppTextStyle.regular16(AppColor.blackColor),
                          ),
                        ],
                      ),
                      h(4),
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
                         spacer(),
                          Text(
                            '₹ ${_quantity * _selectedAmount}',
                            style: AppTextStyle.regular16(AppColor.blackColor),
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


