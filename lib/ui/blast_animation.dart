import 'dart:math';
import 'package:flutter/material.dart';

class BlastAnimation extends StatefulWidget {
  final AnimationController controller;
  const BlastAnimation({super.key, required this.controller});

  @override
  State<BlastAnimation> createState() => _BlastAnimationState();
}

class _BlastAnimationState extends State<BlastAnimation>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<List<ParticleModel>> particles =
      ValueNotifier<List<ParticleModel>>([]);
  final int particalItems = 10;
  final double gravity = 0.7;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(() {
      updateParticles();
    });

    _controller.addStatusListener((status){
      if(status == AnimationStatus.forward){
        createBlast();
      }
    });

    
  }

  void createBlast() {
    particles.value.clear();

    final random = Random();

    /// left and right start offsets
    Offset leftStart = Offset(10, 250);
    Offset rightStart = Offset(390, 250);

    /// LEFT SIDE BLAST
    for (int i = 0; i < particalItems; i++) {
      /// velocity changes for evry for loop item
      double dx = (random.nextDouble() * 10 + 2);
      double dy = (random.nextDouble() * 17 + 8);

      particles.value.add(
        ParticleModel(
          position: leftStart,
          velocity: Offset(dx, -dy),
          color: Colors.primaries[random.nextInt(Colors.primaries.length)],
          radius: random.nextDouble() * 8 + 3,
        ),
      );
    }

    /// RIGHT SIDE BLAST
    for (int i = 0; i < particalItems; i++) {
      /// velocity changes for evry for loop item
      double dx = (random.nextDouble() * 10 + 2);
      double dy = (random.nextDouble() * 17 + 8);

      particles.value.add(
        ParticleModel(
          position: rightStart,
          velocity: Offset(-dx, -dy),
          color: Colors.primaries[random.nextInt(Colors.primaries.length)],
          radius: random.nextDouble() * 5 + 3,
        ),
      );
    }
  }

  void updateParticles() {
    for (final particle in particles.value) {
      particle.velocity = Offset(
        particle.velocity.dx,
        particle.velocity.dy + gravity,
      );

      /// NEW POSITION
      Offset newPosition = particle.position + particle.velocity;

      /// CLAMP ONLY DX (horizontal)
      final clampedDx = newPosition.dx.clamp(
        particle.radius,
        (MediaQuery.of(context).size.width) - particle.radius - 10, // screen width
      );

      particle.position = Offset(clampedDx.toDouble(), newPosition.dy);
    }

    particles.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
        valueListenable: particles,
        builder: (context, value, child) {
          return CustomPaint(
            painter: BlastPainter(value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class ParticleModel {
  Offset position;
  Offset velocity;
  Color color;
  double radius;

  ParticleModel({
    required this.position,
    required this.velocity,
    required this.color,
    required this.radius,
  });
}

class BlastPainter extends CustomPainter {
  final List<ParticleModel> particles;

  BlastPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromCenter(
          center: particle.position,
          width: particle.radius * 3,
          height: particle.radius * 2,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
