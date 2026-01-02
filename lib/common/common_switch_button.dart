import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CommonSwitchButton extends StatelessWidget {
  final RxBool value;
  final String title;
  final ValueChanged<bool> onChanged;

  const CommonSwitchButton({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SwitchListTile(
        value: value.value,
        activeColor: AppColor.primaryColor,
        visualDensity: VisualDensity.compact,
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(title, style: AppTextStyle.regular14(AppColor.blackColor)),
        onChanged: onChanged,
      ),
    );
  }
}
