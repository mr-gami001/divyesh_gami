import 'package:divyesh_gami/ui/logo_animation.dart';
import 'package:flutter/material.dart';

import '../constants/app_text.dart';

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
      duration: const Duration(milliseconds: 2400),
    );

    _blinkitFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );
    _blinkitSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.2917, curve: Curves.easeOutCubic),
          ),
        );

    _moneyFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.125, 0.375, curve: Curves.easeOut),
      ),
    );
    _moneySlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.125, 0.4167, curve: Curves.easeOutCubic),
          ),
        );

    _card1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.7083, curve: Curves.easeOut),
      ),
    );
    _card1SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.5, 0.75, curve: Curves.easeOutCubic),
          ),
        );

    _card2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6042, 0.8125, curve: Curves.easeOut),
      ),
    );
    _card2SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.6042, 0.8542, curve: Curves.easeOutCubic),
          ),
        );

    _card3FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7083, 0.9167, curve: Curves.easeOut),
      ),
    );
    _card3SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.7083, 1.0, curve: Curves.easeOutCubic),
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
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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

              // Staggered contents below the logo (no setState rebuilds)
              FadeTransition(
                opacity: _blinkitFadeAnimation,
                child: SlideTransition(
                  position: _blinkitSlideAnimation,
                  child: const Text(
                    AppText.blinkit,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              // "MONEY" typography title
              FadeTransition(
                opacity: _moneyFadeAnimation,
                child: SlideTransition(
                  position: _moneySlideAnimation,
                  child: const Text(
                    AppText.MONEY,
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

              // // Feature Cards wrapper
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  if (_animationController.value < 0.5) {
                    return const SizedBox.shrink();
                  }
                  return SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
                    ),
                    axisAlignment: -1.0,
                    child: child!,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // // Feature Card 1: Single tap payments
                    FadeTransition(
                      opacity: _card1FadeAnimation,
                      child: SlideTransition(
                        position: _card1SlideAnimation,
                        child: _buildFeatureCard(
                          topMargin: 40,
                          title: AppText.singleTapPayments,
                          subtitle: AppText
                              .enjoySeamlessPaymentsWithoutTheWaitForOTPs,
                          iconStack: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                top: 4,
                                child: Icon(
                                  Icons.phone_iphone_rounded,
                                  color: Color(
                                    0xFFF4D03F,
                                  ), // Gold Phone outline
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

                    // // Feature Card 2: Zero failures
                    FadeTransition(
                      opacity: _card2FadeAnimation,
                      child: SlideTransition(
                        position: _card2SlideAnimation,
                        child: _buildFeatureCard(
                          topMargin: 16,
                          title: AppText.zeroFailures,
                          subtitle: AppText
                              .zeroPaymentFailuresEnsureYouNeverMissAnOrder,
                          iconStack: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                top: 4,
                                child: Icon(
                                  Icons.phone_iphone_rounded,
                                  color: Color(
                                    0xFFF4D03F,
                                  ), // Gold Phone outline
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

                    // // Feature Card 3: Instant refunds
                    FadeTransition(
                      opacity: _card3FadeAnimation,
                      child: SlideTransition(
                        position: _card3SlideAnimation,
                        child: _buildFeatureCard(
                          topMargin: 16,
                          title: AppText.instantRefunds,
                          subtitle: AppText
                              .getRefundsInstantlyIntoYourWalletForCancelledOrders,
                          iconStack: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                top: 4,
                                child: Icon(
                                  Icons.phone_iphone_rounded,
                                  color: Color(
                                    0xFFF4D03F,
                                  ), // Gold Phone outline
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required Widget iconStack,
    required double topMargin,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: topMargin),
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