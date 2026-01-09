import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import 'otp_controller.dart';


class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final OtpController otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Text('Verify your mobile number',style: AppTextStyle.medium20(AppColor.whiteColor),),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Get.height * 0.85,
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(color:Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(36)),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Enter your OTP code here",
                        style: AppTextStyle.medium18(AppColor.blackColor),
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        final String phone = otpController.phoneNumber.value;
                        if (phone.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          'OTP sent to $phone',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16(AppColor.grey600),
                        );
                      }),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: PinCodeTextField(
                          length: 6,
                          appContext: context,
                          keyboardType: TextInputType.phone,
                          enablePinAutofill: true,
                          hintCharacter: "-",
                          textStyle: TextStyle(color: AppColor.grey900),
                          pinTheme: PinTheme(
                            fieldHeight: 40,
                            fieldWidth: 40,
                            inactiveFillColor: AppColor.grey100,
                            selectedFillColor: AppColor.grey100,
                            activeFillColor: AppColor.grey100,
                            selectedColor: AppColor.grey100,
                            activeColor: AppColor.redColor,
                            inactiveColor: AppColor.grey100,
                            disabledColor: AppColor.grey100,
                            shape: PinCodeFieldShape.box,
                            errorBorderColor: AppColor.grey300,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          cursorColor: AppColor.redColor,
                          enableActiveFill: true,
                          controller: otpController.otpTextController,
                          onCompleted: (value) async {
                            await otpController.verifyOtp(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Don’t you receive any code?",
                        style:  AppTextStyle.medium16(AppColor.blackColor),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () async {
                          await otpController.resendOtp();
                        },
                        child: Text(
                          "Resend OTP",
                          style: AppTextStyle.medium16(Color(0xff252BEA)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
