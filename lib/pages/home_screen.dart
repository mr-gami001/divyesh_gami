import 'package:divyesh_gami/ui/logo_animation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _blinkitFadeAnimation;
  late final Animation<Offset> _blinkitSlideAnimation;

  late final Animation<double> _moneyFadeAnimation;
  late final Animation<Offset> _moneySlideAnimation;

  late final Animation<double> _card1FadeAnimation;
  late final Animation<Offset> _card1SlideAnimation;

  late final Animation<double> _card2FadeAnimation;
  late final Animation<Offset> _card2SlideAnimation;

  late final Animation<double> _card3FadeAnimation;
  late final Animation<Offset> _card3SlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _blinkitFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );
    _blinkitSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
          ),
        );

    _moneyFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.15, 0.5, curve: Curves.easeOut),
      ),
    );
    _moneySlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.15, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    _card1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );
    _card1SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.35, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    _card2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );
    _card2SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    _card3FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.65, 0.95, curve: Curves.easeOut),
      ),
    );
    _card3SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    // Play the entrance animation after the page/Hero transition completes for a super-smooth experience
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      if (route != null && route.animation != null) {
        if (route.animation!.isCompleted) {
          _animationController.forward();
        } else {
          route.animation!.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.forward();
            }
          });
        }
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacing to position the logo upside (upper part of screen)
                SizedBox(height: screenHeight * 0.08),

                // Hero Wallet Logo - flies smoothly upside from logo_animation.dart
                Hero(
                  tag: "logo",
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) =>
                      CurveRectTween(begin: begin, end: end),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 24),

                // Staggered contents below the logo (no setState rebuilds)
                FadeTransition(
                  opacity: _blinkitFadeAnimation,
                  child: SlideTransition(
                    position: _blinkitSlideAnimation,
                    child: const Text(
                      "blinkit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),

                // "MONEY" typography title
                FadeTransition(
                  opacity: _moneyFadeAnimation,
                  child: SlideTransition(
                    position: _moneySlideAnimation,
                    child: const Text(
                      "MONEY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 6.0,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Feature Card 1: Single tap payments
                FadeTransition(
                  opacity: _card1FadeAnimation,
                  child: SlideTransition(
                    position: _card1SlideAnimation,
                    child: _buildFeatureCard(
                      title: "Single tap payments",
                      subtitle:
                          "Enjoy seamless payments without the wait for OTPs",
                      iconStack: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Positioned(
                            top: 4,
                            child: Icon(
                              Icons.phone_iphone_rounded,
                              color: Color(0xFFF4D03F), // Gold Phone outline
                              size: 26,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(1),
                              child: const Icon(
                                Icons.touch_app_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Feature Card 2: Zero failures
                FadeTransition(
                  opacity: _card2FadeAnimation,
                  child: SlideTransition(
                    position: _card2SlideAnimation,
                    child: _buildFeatureCard(
                      title: "Zero failures",
                      subtitle:
                          "Zero payment failures ensure you never miss an order",
                      iconStack: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Positioned(
                            top: 4,
                            child: Icon(
                              Icons.phone_iphone_rounded,
                              color: Color(0xFFF4D03F), // Gold Phone outline
                              size: 26,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(1),
                              child: const Icon(
                                Icons.wifi_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Feature Card 3: Instant refunds
                FadeTransition(
                  opacity: _card3FadeAnimation,
                  child: SlideTransition(
                    position: _card3SlideAnimation,
                    child: _buildFeatureCard(
                      title: "Instant refunds",
                      subtitle:
                          "Get refunds instantly into your wallet for cancelled orders",
                      iconStack: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Positioned(
                            top: 4,
                            child: Icon(
                              Icons.phone_iphone_rounded,
                              color: Color(0xFFF4D03F), // Gold Phone outline
                              size: 26,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(1),
                              child: const Icon(
                                Icons.bolt_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required Widget iconStack,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1E), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(12), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Black rounded icon container
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withAlpha(15), width: 1),
            ),
            child: iconStack,
          ),
          const SizedBox(width: 16),

          // Title & Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDFAC5C)
          .withAlpha(15) // Soft translucent Gold dots
      ..style = PaintingStyle.fill;

    const double spacing = 16.0;
    const double radius = 1.2;

    // Paint dotted mesh in the top 35% of the screen
    for (double y = 0; y < size.height * 0.35; y += spacing) {
      // Calculate opacity fade as y increases
      final double progress = y / (size.height * 0.35);
      paint.color = const Color(
        0xFFDFAC5C,
      ).withAlpha(((1.0 - progress) * 20).round());

      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BlinkitWalletLogo extends StatelessWidget {
  final double size;
  const BlinkitWalletLogo({super.key, this.size = 110});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle:
          -0.12, // Subtle premium rotation angle matching the Blinkit wallet image
      child: SizedBox(
        width: size,
        height: size * 0.85,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Inside fold (Green part of the wallet)
            Positioned(
              top: 0,
              left: size * 0.12,
              right: size * 0.12,
              height: size * 0.42,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF388E3C), // Olive/Dark green
                      Color(0xFF1B5E20), // Forest green
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size * 0.15),
                    topRight: Radius.circular(size * 0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 6,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
            // Front fold (Gold/Yellow gradient part of the wallet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: size * 0.68,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFD54F), // Bright Gold
                      Color(0xFFF5B041), // Vibrant Orange-Gold
                      Color(0xFFB7950B), // Deep shadow Gold
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(size * 0.14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7D6608).withAlpha(120),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '₹',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.36,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 4,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
