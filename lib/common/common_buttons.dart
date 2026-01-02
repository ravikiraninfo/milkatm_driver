import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CustomFilledButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String title;
  final TextStyle? style;
  final double? height;
  final double? width;
  final int delayMillis;

  const CustomFilledButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    required this.title,
    this.style,
    this.height,
    this.width,
    this.delayMillis = 1500,
  });

  @override
  State<CustomFilledButton> createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton> {
  bool _enabled = true;

  void _handleClick() {
    if (_enabled) {
      widget.onPressed();
      setState(() => _enabled = false);

      Future.delayed(Duration(milliseconds: widget.delayMillis), () {
        if (mounted) {
          setState(() => _enabled = true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height??30.h,
      width: widget.width??double.infinity,
      child: FilledButton(
        onPressed: _enabled ? _handleClick : (){
        },
        style: FilledButton.styleFrom(
          backgroundColor: widget.backgroundColor??AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          minimumSize:  Size(double.infinity, 45.h),
        ),
        child: Text(widget.title, style: widget.style??AppTextStyle.medium16(AppColor.whiteColor)
      ),
    ),
    );
  }
}
