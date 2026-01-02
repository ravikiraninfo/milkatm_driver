import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/common_flex.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  final List<_NotificationOption> _options = const [
    _NotificationOption(title: 'Subscription plan reminder alert', value: true),
    _NotificationOption(title: 'Milk arrival alert message', value: true),
    _NotificationOption(title: 'Wallet balance alert', value: false),
    _NotificationOption(title: 'Lorem ipsum dolor sit amet, consectetur', value: true),
  ].toList();

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
                  Text('Notification Setting',style: AppTextStyle.medium20(AppColor.whiteColor),),
                  spacer(),
                  Image.asset('assets/images/notification.png',height: 20.h,width: 20 .h,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColor.whiteColor,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
                  itemCount: _options.length,
                  separatorBuilder: (_, __) => Divider(color: AppColor.greyColor, height: 1.h),
                  itemBuilder: (context, index) {
                    final item = _options[index];
                    return _NotificationTile(
                      title: item.title,
                      value: item.value,
                      onChanged: (val) {
                        setState(() => _options[index] = item.copyWith(value: val));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.regular16(AppColor.blackColor),
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColor.greenColor,
            inactiveTrackColor: const Color(0xFFE0E0E0),
          ),
        ],
      ),
    );
  }
}

class _NotificationOption {
  const _NotificationOption({required this.title, required this.value});

  final String title;
  final bool value;

  _NotificationOption copyWith({bool? value}) {
    return _NotificationOption(title: title, value: value ?? this.value);
  }
}

