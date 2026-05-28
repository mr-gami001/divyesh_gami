import 'package:flutter/material.dart';

class LogoAnimation extends StatelessWidget {
  final Tween<double> logoAnimationTween;
  const LogoAnimation({super.key,required this.logoAnimationTween});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(0, value), child: child);
      },
      tween: logoAnimationTween,

      duration: Duration(milliseconds: 700),
      child: Icon(Icons.account_balance_wallet_rounded, size: 100),
    );
  }
}
