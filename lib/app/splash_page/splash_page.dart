import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkshop_driver/app/login_page/login_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(()=>LoginPage());
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
