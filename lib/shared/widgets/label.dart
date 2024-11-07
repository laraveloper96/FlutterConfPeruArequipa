import 'package:flutter/material.dart';
import 'package:nimbuz_arm_robotic/shared/utils/utils.dart';

enum LabelType {
  min,
  normal,
  title,
  subTitle,
  max,
}

class Label extends StatelessWidget {
  const Label(
    this.text, {
    this.type,
    this.color,
    this.textAlign,
    super.key,
  });

  final String text;
  final LabelType? type;
  final TextAlign? textAlign;
  final Color? color;

  TextStyle _getStyle() {
    switch (type ?? LabelType.normal) {
      case LabelType.min:
        return TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 9,
          color: color ?? CColors.text,
          height: 0,
          letterSpacing: 0,
        );
      case LabelType.normal:
        return TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: color ?? CColors.text,
          height: 0,
          letterSpacing: 0,
        );
      case LabelType.title:
        return TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: color ?? CColors.text,
          height: 0,
          letterSpacing: 0,
        );
      case LabelType.subTitle:
        return TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: color ?? CColors.text,
          height: 0,
          letterSpacing: 0,
        );
      case LabelType.max:
        return TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color: color ?? CColors.text,
          height: 0,
          letterSpacing: 0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: _getStyle(),
    );
  }
}
