import 'package:flutter/material.dart';

import '../utils/app_color.dart';

Widget divider({Color? color, thickness, indent, endIndent}) {
  return Divider(
    color: color ?? AppColor.greyColor.withOpacity(0.5),
    thickness: thickness,
    indent: indent,
    endIndent: endIndent,
  );
}
