import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/app/login_page/login_controller.dart';
import 'package:milkshop_driver/common/common_buttons.dart';
import 'package:milkshop_driver/common/common_flex.dart';
import 'package:milkshop_driver/common/common_textfield.dart';
import 'package:milkshop_driver/utils/app_color.dart';
import 'package:milkshop_driver/utils/app_text_style.dart';

import 'otp_verification_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        reverse: true,
        child: Form(
          key: loginController.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/truck.png',
                  fit: BoxFit.cover, width: double.infinity, height: 400.h,),
              h(20),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('Login with mobile', style: AppTextStyle.bold24(AppColor.blackColor),),
              ),
              h(10),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Text('We will send the confirmation code on your registered mobile', style: AppTextStyle.regular16(AppColor.blackColor),),
              ),
              h(30),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomTextInput(
                    textEditController: loginController.emailController,
                    hintTextString: 'Mobile number',
                  borderColor: AppColor.greyColor,
                  inputType: InputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter mobile number';
                    } else if (val.length < 10) {
                      return 'Please enter valid mobile number';
                    } else if (val.length > 10) {
                      return 'Please enter valid mobile number';
                    }else if(!RegExp(r'^[0-9]+$').hasMatch(val)){
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                ),
              ),
              h(20),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomFilledButton(
                    height: 50.h,
                    onPressed: () {
                      if (loginController.loginFormKey.currentState!
                          .validate()) {
                        loginController.sendOtp();
                      }
                    },
                  title: "Login",
                ),
              ),
              h(20),
            ],
          ),
        ),
      ),
    );
  }
}
