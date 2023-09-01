import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xff06aa48);

  static const Color black = Color(0xFF000000);

  static const Color lightBlack = Colors.black54;

  static const Color white = Color(0xFFFFFFFF);

  static const MaterialColor yellow = Colors.yellow;

  static const MaterialColor red = Colors.red;

  static const Color background = Color(0xFFFFFFFF);

  static const Color onBackground = Color(0xFF1A1A1A);

  static const Color primaryContainer = Color(0xFFB1EBFF);

  static const MaterialColor secondary = MaterialColor(0xFF963F6E, <int, Color>{
    50: Color(0xFFFFECF3),
    100: Color(0xFFFFD8E9),
    200: Color(0xFFFFAFD6),
    300: Color(0xFFF28ABE),
    400: Color(0xFFD371A3),
    500: Color(0xFFB55788),
    600: Color(0xFF963F6E),
    700: Color(0xFF7A2756),
    800: Color(0xFF5F0F40),
    900: Color(0xFF3D0026),
  });

  static const Color disabledForeground = Color(0x611B1B1B);

  static const Color disabledButton = Color(0x1F000000);

  static const Color disabledSurface = Color(0xFFE0E0E0);

  static const Color transparent = Color(0x00000000);
}
