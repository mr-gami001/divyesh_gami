import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class AppBackgound extends StatefulWidget {
  final Widget child;
  const AppBackgound({super.key, required this.child});

  @override
  State<AppBackgound> createState() => _AppBackgoundState();
}

class _AppBackgoundState extends State<AppBackgound> {
  late ConfettiController _controllerCenterLeft;
  double animationAngle = 5 * pi / 18;
  int numberOfParticles = 10;
  double gravity = 0.3;

  @override
  void initState() {
    _controllerCenterLeft = ConfettiController(
      duration: const Duration(milliseconds: 500),
    );

    _controllerCenterLeft.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// blast start height from the top of the screen
    double top = MediaQuery.of(context).size.height / 4;

    return Stack(
      children: [
        // LEFT Side animation blast
        Positioned(
          left: 0,
          top: top,
          child: ConfettiWidget(
            confettiController: _controllerCenterLeft,
            blastDirectionality: BlastDirectionality.directional,
            blastDirection: -animationAngle,
            shouldLoop: false,
            numberOfParticles: numberOfParticles,
            gravity: gravity,
            minBlastForce: 20,
            maxBlastForce: 70,
            minimumSize: const Size(5, 5),
            maximumSize: const Size(10, 10),
          ),
        ),

        Align(alignment: Alignment.center, child: widget.child),

        // RIGHT Side animation blast
        Positioned(
          right: 0,
          top: top,
          child: ConfettiWidget(
            confettiController: _controllerCenterLeft,
            blastDirectionality: BlastDirectionality.directional,
            blastDirection: (-pi) + animationAngle,
            shouldLoop: false,
            numberOfParticles: numberOfParticles,
            gravity: gravity,
            minBlastForce: 20,
            maxBlastForce: 70,
            minimumSize: const Size(5, 5),
            maximumSize: const Size(10, 10),
          ),
        ),
      ],
    );
  }
}
