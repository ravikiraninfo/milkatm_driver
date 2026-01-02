import 'package:flutter/material.dart';

enum FontFamily {outfit}

class AppTextStyle {


  static TextStyle _regular(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    switch(fontFamily) {
      case FontFamily.outfit:
        return TextStyle(
          fontFamily: "Outfit-Regular",
          fontSize: size,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle _medium(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    switch(fontFamily) {
      case FontFamily.outfit:
        return TextStyle(
          fontFamily: "Outfit-Medium",
          fontSize: size,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle _bold(double size, Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    switch(fontFamily) {
      case FontFamily.outfit:
        return TextStyle(
          fontFamily: "Outfit-Bold",
          fontSize: size,
          height: 1,
          color: color,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        );
    }
  }

  static TextStyle bold7(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(7, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }
  static TextStyle bold10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle bold32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }
  static TextStyle bold40(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(40, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }
  static TextStyle bold50(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(50, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

 static TextStyle bold48(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _bold(48, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle regular32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _regular(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium10(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(10, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium11(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(11, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium12(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(12, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium13(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(13, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium14(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(14, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium15(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(15, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium16(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(16, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium17(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(17, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium18(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(18, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium19(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(19, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium20(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(20, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium21(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(21, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium22(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(22, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium23(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(23, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium24(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(24, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium25(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(25, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium26(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(26, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium27(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(27, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium28(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(28, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium29(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(29, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium30(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(30, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium31(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(31, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }

  static TextStyle medium32(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(32, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }
  static TextStyle medium48(Color color, {bool isUnderline = false,FontFamily fontFamily = FontFamily.outfit}) {
    return _medium(48, color, isUnderline: isUnderline,fontFamily: fontFamily);
  }
}