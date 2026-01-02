import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milkshop_driver/app/attendance_page/attendance_page.dart';
import 'package:milkshop_driver/app/home_page/homepage.dart';
import 'package:milkshop_driver/app/order_page/order_page.dart';
import 'package:milkshop_driver/utils/app_color.dart';
import 'package:milkshop_driver/utils/app_text_style.dart';

import '../walkin_order_page/walkin_order_page.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    WalkinOrderPage(),
    OrderPage(),
    AttendancePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(height: 70.h,
        decoration: BoxDecoration(
          // border: Border(
          //   top: BorderSide(
          //     color: AppColor.greyColor.withOpacity(0.3),
          //     width: 1,
          //   ),
          // ),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: AppColor.whiteColor,
          selectedLabelStyle: AppTextStyle.medium12(AppColor.transparentColor),
          unselectedLabelStyle: AppTextStyle.medium12(AppColor.transparentColor),
          unselectedItemColor: AppColor.blackColor,
          selectedItemColor: AppColor.primaryColor,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          items:  [
            BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/home.png",height: 18.h,width: 18.h,),
            ), label: 'Home',
            activeIcon: Container(
              decoration: BoxDecoration(
               shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/home.png",height: 18.h,width: 18.h,color: AppColor.whiteColor,),
            )
            ),
            BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/walk.png",height: 18.h,width: 18.h,),
            ),label: 'Walk In',activeIcon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/walk.png",height: 18.h,width: 18.h,color: AppColor.whiteColor,),
            ),),
            BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/order.png",height: 18.h,width: 18.h,),
            ),label: 'Orders',activeIcon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/order.png",height: 18.h,width: 18.h,color: AppColor.whiteColor,),
            ),),
            BottomNavigationBarItem(icon:Padding(
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/calender.png",height: 18.h,width: 18.h,),
            ), label: 'Attendance',activeIcon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
              padding: EdgeInsets.all(10.h),
              child: Image.asset("assets/images/calender.png",height: 18.h,width: 18.h,color: AppColor.whiteColor,),
            ),),
          ],
        ),
      ),

    );
  }
}
