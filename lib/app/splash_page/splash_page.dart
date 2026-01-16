import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/app/dashboard_page/dashboard_page.dart';
import 'package:milkshop_driver/app/login_page/login_page.dart';
import 'package:dio/dio.dart' as d;
import 'package:milkshop_driver/global/global.dart';
import '../../api/api_url.dart';
import '../../common/common_snackbar.dart';
import '../../data/local/shared_preference/shared_preference.dart';
import '../../data/local/shared_preference/shared_preference_key.dart';
import '../../services/base_services.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future<d.Response?> checkStatus() async{
    d.Response? response = await BaseService().get(ApiUrl.checkStatus(MySharedPref.getString(PreferenceKey.driverID)));
    if (response?.statusCode == 200) {
      Global.dayStarted.value = response?.data["data"]['dayStarted'];
      return response;
    }else{
      CustomSnackBar.showToast(
        Get.context!,
        messages:response?.data['message'] ?? "Something went wrong",
      );
    }
    return null;
  }
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if(MySharedPref.getBool(PreferenceKey.isLogin) == true){
        checkStatus();
        Get.to(()=>DashboardPage());
      }else{
        Get.to(()=>LoginPage());
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/images/splash.png',
          fit: BoxFit.cover, width: double.infinity, height: double.infinity),
    );
  }
}
