import 'package:divyesh_gami/pages/home_screen.dart';
import 'package:divyesh_gami/ui/blast_animation.dart';
import 'package:divyesh_gami/ui/logo_animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late AnimationController blastAnimationController;
  Tween<double> logoAnimationTween = Tween(begin: -50, end: 0);
  late AnimationController logoAnimationTweenController;
  bool _hasPushed = false;

  @override
  void initState() {
    logoAnimationTweenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    blastAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
    blastAnimationController.addListener(() {
      if (!_hasPushed && blastAnimationController.value > 0.1) {
        _hasPushed = true;
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(seconds: 2),
          ),
        ).then((_) {
          _hasPushed = false;
        });
      }
    });
    // blastAnimationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.push(
    //       context,
    //       PageRouteBuilder(
    //         pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
    //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //           return FadeTransition(
    //             opacity: animation,
    //             child: child,
    //           );
    //         },
    //         transitionDuration: const Duration(seconds: 2),
    //       ),
    //     );
    //   }
    // });

    logoAnimationTweenController.forward(from: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // BlastAnimation(controller: blastAnimationController),

          Align(
            alignment: Alignment.center,
            child: LogoAnimation(logoAnimationTween: logoAnimationTween),
          ),
        ],
      ),
    );
  }
}
