import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CommonCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Widget? child;
  final Color activeColor;

  const CommonCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.child,
    this.activeColor = AppColor.primaryColor,
  });

  @override
  _CommonCheckboxState createState() => _CommonCheckboxState();
}

class _CommonCheckboxState extends State<CommonCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            value: widget.value,
            onChanged: widget.onChanged,
            activeColor: widget.activeColor,
          ),
          if (widget.child != null)
            widget.child!,
        ],
      ),
    );
  }
}