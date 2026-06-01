import 'package:divyesh_gami/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle buttonTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static const TextStyle bold16White = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle claimGiftCardSubtitle = TextStyle(
    color: AppColors.greyLight.withValues(alpha:0.45),
    fontSize: 13,
  );

  static final TextStyle watermarkTextStyle = TextStyle(
    color: AppColors.white.withValues(alpha: 0.15),
    fontSize: 32,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.5,
  );

  static const TextStyle blinkitTitleStyle = TextStyle(
    color: AppColors.white,
    fontSize: 26,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.5,
  );

  static const TextStyle moneyTitleStyle = TextStyle(
    color: AppColors.white,
    fontSize: 48,
    fontWeight: FontWeight.w900,
    letterSpacing: 6.0,
    height: 1.0,
  );

  static const TextStyle featureSubtitleStyle = TextStyle(
    color: AppColors.grey,
    fontSize: 13,
    height: 1.3,
  );
}
