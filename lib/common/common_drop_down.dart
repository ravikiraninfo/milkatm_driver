import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';
import 'common_flex.dart';

class CommonDropdownButton<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final Color dropdownColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? underline;
  final int elevation;
  final bool? isExpanded;

  const CommonDropdownButton({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.hintText = '',
    this.hintTextColor,
    this.prefixIcon,
    this.elevation = 8,
    this.underline,
    this.style,
    this.hintStyle,
    this.isExpanded,
    this.dropdownColor = Colors.white,
  });

  @override
  _CommonDropdownButtonState<T> createState() => _CommonDropdownButtonState<T>();
}

class _CommonDropdownButtonState<T> extends State<CommonDropdownButton<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CommonDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        selectedValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: selectedValue,
      icon: widget.prefixIcon,
      elevation: widget.elevation,
      hint: Text(
        widget.hintText,
        style: widget.hintStyle??AppTextStyle.medium14(widget.hintTextColor ??AppColor.greyColor),
      ),
      isExpanded:widget.isExpanded?? false,
      style: widget.style??AppTextStyle.medium14(AppColor.blackColor),
      underline: widget.underline ??sizedBox(),
      onChanged: (T? newValue) {
        setState(() {
          selectedValue = newValue;
        });
        widget.onChanged(newValue);
      },
      items: widget.items,
    );
  }
}