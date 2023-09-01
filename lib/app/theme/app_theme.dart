import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class AppTheme {
  const AppTheme();

  ThemeData get themeData {
    return ThemeData(
      colorSchemeSeed: AppColors.primary,
    );
  }
}
