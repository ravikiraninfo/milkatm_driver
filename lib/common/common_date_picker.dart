import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

Future<DateTime?> datePicker({
  context,
  hintText,
  required DateTime currentDate,
}) {
  return showDatePicker(
    context: context,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(primary: AppColor.primaryColor),
          dialogTheme: DialogThemeData(backgroundColor: AppColor.primaryColor),
        ),
        child: child ?? Text(hintText,style: AppTextStyle.medium14(AppColor.whiteColor)),
      );
    },
    initialDate: currentDate,
    firstDate: DateTime(1900),
    lastDate: currentDate,
    helpText: hintText,
  );
}
Future<TimeOfDay?> timePicker(
  {required BuildContext context, required TimeOfDay initialTime}
    ){
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(primary: AppColor.primaryColor),
          dialogTheme: DialogThemeData(backgroundColor: AppColor.primaryColor),
        ),
        child: child ?? Text("Select Time",
          style: AppTextStyle.medium14(AppColor.whiteColor),
        ),
      );
    },
  );
}