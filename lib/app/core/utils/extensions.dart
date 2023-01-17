import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on double {
  double get tp => Get.width / 100 * (this / 3);
}

extension TextStyled on TextStyle {
  static TextStyle get h1 =>
      TextStyle(fontSize: 44.0.tp, fontWeight: FontWeight.bold);
  static TextStyle get h2 =>
      TextStyle(fontSize: 36.0.tp, fontWeight: FontWeight.bold);
  static TextStyle get h3 =>
      TextStyle(fontSize: 28.0.tp, fontWeight: FontWeight.bold);
  static TextStyle get h4 =>
      TextStyle(fontSize: 20.0.tp, fontWeight: FontWeight.bold);
  static TextStyle get h5 =>
      TextStyle(fontSize: 16.0.tp, fontWeight: FontWeight.bold);
  static TextStyle get h6 =>
      TextStyle(fontSize: 14.0.tp, fontWeight: FontWeight.bold);
  static TextStyle get bodyXLarge =>
      TextStyle(fontSize: 14.0.tp, letterSpacing: 0.2);
  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 12.0.tp, letterSpacing: 0.2);
  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 10.0.tp, letterSpacing: 0.2);
  static TextStyle get bodySmall =>
      TextStyle(fontSize: 8.0.tp, letterSpacing: 0.2);
  static TextStyle get bodyXSmall =>
      TextStyle(fontSize: 6.0.tp, letterSpacing: 0.2);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
