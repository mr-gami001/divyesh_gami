import 'package:flutter/material.dart';

class CurveRectTween extends RectTween {
  final Curve curve;

  CurveRectTween({super.begin, super.end, this.curve = Curves.easeInOutCubic});

  @override
  Rect? lerp(double t) {
    return super.lerp(curve.transform(t));
  }
}

class LogoAnimation extends StatelessWidget {
  final Tween<double> logoAnimationTween;
  const LogoAnimation({super.key, required this.logoAnimationTween});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(0, value), child: child);
      },
      tween: logoAnimationTween,

      duration: const Duration(milliseconds: 700),
      child: Hero(
        tag: "logo",
        transitionOnUserGestures: true,
        createRectTween: (begin, end) => CurveRectTween(begin: begin, end: end),
        child: const Icon(
          Icons.account_balance_wallet_rounded,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
