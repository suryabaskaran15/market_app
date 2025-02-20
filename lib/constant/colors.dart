import 'package:flutter/material.dart';

class ColorConstants {
  static Color shadowColor = hexToColor('#505588');
  static Color dividerGray = hexToColor('#20222C');
  static Color bgColor = hexToColor('#0BDC4E1F');

  // Additional colors from SplashScreen
  static Color appLinearStart = hexToColor('#55185D');
  static Color appLinearEnd = hexToColor('#290849');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
