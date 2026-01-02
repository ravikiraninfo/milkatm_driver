import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class CommonRadioButton<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String label;
  final Color activeColor;

  const CommonRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label = '',
    this.activeColor = AppColor.primaryColor,
  });

  @override
  _CommonRadioButtonState<T> createState() => _CommonRadioButtonState<T>();
}

class _CommonRadioButtonState<T> extends State<CommonRadioButton<T>> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio<T>(
            value: widget.value,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            groupValue: widget.groupValue,
            onChanged: (T? newValue) {
              widget.onChanged(newValue as T);
            },
            activeColor: widget.activeColor,
          ),
          if (widget.label.isNotEmpty)
            Flexible(
              child: Text(
                widget.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.regular14(AppColor.blackColor),
              ),
            ),
        ],
      ),
    );
  }
}
