import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Colors.black;
  static const Color transparent = Colors.transparent;

  static const Color white = Colors.white;

  static const Color grey = Colors.grey;

  static final Color greyLight = Colors.grey.shade400;

  static const Color goldAccent = Color(0xFFDFAC5C);
  static const Color successGreen = Color(0xFF3B8C1D);
  static const Color cardBg = Color(0xFF1B1B1E);

  static final Color cardBorder = Colors.white.withAlpha(12);

  static final Color highlightBorder = Colors.white.withAlpha(15);

  static final Color orangeHighlight = Colors.orange.withAlpha(30);

  static final Color glassButtonBg = Colors.white.withValues(alpha: 0.08);

  static final Color glassButtonBorder = Colors.white.withValues(alpha: 0.12);
}
