import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/common_dialog_box.dart';
import '../../common/common_divider.dart';
import '../../common/common_flex.dart';
import '../../common/common_snackbar.dart';
import '../../data/local/shared_preference/shared_preference.dart';
import '../../data/local/shared_preference/shared_preference_key.dart';
import '../../global/global.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../inventory_stock_page/inventory_stock_page.dart';
import '../login_page/login_page.dart';
import '../notification_setting_page/notification_setting_page.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 96.h,
                  width: 96.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE6E6E6), width: 4.w),
                  ),
                  padding: EdgeInsets.all(4.w),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/woman.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              h(18),
              Center(
                child: Column(
                  children: [
                    Text(
                      MySharedPref.getString(PreferenceKey.name) ?? '--',
                      style: AppTextStyle.medium20(AppColor.blackColor),
                    ),
                    h(6),
                    Text(
                      '+91 ${MySharedPref.getString(PreferenceKey.number) ?? '--'}',
                      style: AppTextStyle.regular14(AppColor.lightBlackColor1),
                    ),
                  ],
                ),
              ),
              h(32),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/profile_setting.png',
                title: 'Profile setting',
                onTap: () {},
              ),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/notification.png',
                title: 'Notifications',
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const NotificationSettingPage());
                },
              ),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/inventory.png',
                title: 'Inventory',
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const InventoryStockPage());
                },
              ),
              divider(),
              _DrawerItem(
                iconPath: 'assets/images/logout.png',
                title: 'Logout',
                onTap: () {
                  showCustomDialog(
                    context: Get.context!,
                    title: "Logout",
                    content: "Do you want to logout?",
                    cancelText: "No",
                    confirmText: "Yes",
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () async {
                      Get.back();
                      Global.currentIndex.value = 3;
                      Get.offAll(() => const LoginPage());
                      MySharedPref.clearPrefs();
                      CustomSnackBar.showToast(Get.context!, messages: 'Logged Out');
                    },
                  );

                },
              ),
              divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.trailingColor,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final Color? trailingColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 26.h,
              width: 26.h,
              color: AppColor.blackColor,
              fit: BoxFit.contain,
            ),
            w(16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.regular16(AppColor.blackColor),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: trailingColor ?? AppColor.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}