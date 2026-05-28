import 'package:divyesh_gami/ui/blast_animation.dart';
import 'package:divyesh_gami/ui/logo_animation.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late AnimationController blastAnimationController;
  Tween<double> logoAnimationTween = Tween(begin: -50, end: 0);
  late AnimationController logoAnimationTweenController;

  @override
  void initState() {
    logoAnimationTweenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    blastAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    logoAnimationTween.animate(
      CurvedAnimation(
        parent: logoAnimationTweenController,
        curve: Curves.bounceInOut,
      ),
    );
    logoAnimationTweenController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        blastAnimationController.forward(from: 0);
      }
    });

    logoAnimationTweenController.forward(from: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          BlastAnimation(controller: blastAnimationController),

          Align(
            alignment: Alignment.center,
            child: LogoAnimation(logoAnimationTween: logoAnimationTween),
          ),
        ],
      ),
    );
  }
}
