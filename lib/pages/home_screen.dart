import 'package:divyesh_gami/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _lottieController;

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
      duration: const Duration(milliseconds: 4000),
    );

    _lottieController = AnimationController(vsync: this);

    _blinkitFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.15, 0.30, curve: Curves.easeOut),
      ),
    );
    _blinkitSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.15, 0.33, curve: Curves.easeOutCubic),
          ),
        );

    _moneyFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.25, 0.42, curve: Curves.easeOut),
      ),
    );
    _moneySlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.25, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    _card1FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 0.83, curve: Curves.easeOut),
      ),
    );
    _card1SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.75, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    _card2FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.85, 0.92, curve: Curves.easeOut),
      ),
    );
    _card2SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.85, 0.93, curve: Curves.easeOutCubic),
          ),
        );

    _card3FadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.93, 0.99, curve: Curves.easeOut),
      ),
    );
    _card3SlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.93, 1.0, curve: Curves.easeOutCubic),
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildCelebrationAnimation(context),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _fallingLogo(),
                    _blinkitMoneyText(),
                    _featuresCards(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCelebrationAnimation(BuildContext context) {
    return Positioned(
      top: 0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        child: Lottie.asset(
          AppAssets.celebrationLottieJson,
          repeat: false,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
          controller: _lottieController,
          onLoaded: (composition) {
            _lottieController.duration = composition.duration;

            Future.delayed(composition.duration ~/ 2, () {
              _animationController.forward(from: 0);
            });
          },
        ),
      ),
    );
  }

  Widget _fallingLogo() {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeOutBack,
      tween: Tween(begin: -50, end: 0),
      duration: const Duration(milliseconds: 700),
      onEnd: () async {
        _lottieController.forward();
      },
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(0, value), child: child);
      },
      child: const Icon(
        Icons.account_balance_wallet_rounded,
        size: 100,
        color: Colors.white,
      ),
    );
  }

  Widget _blinkitMoneyText() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        if (_animationController.status == AnimationStatus.dismissed) {
          return const SizedBox.shrink();
        }
        return SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.15, curve: Curves.easeInOut),
          ),
          axisAlignment: -1.0,
          child: child!,
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            FadeTransition(
              opacity: _moneyFadeAnimation,
              child: SlideTransition(
                position: _moneySlideAnimation,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _featuresCards() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        if (_animationController.value < 0.60) {
          return const SizedBox.shrink();
        }
        return SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.60, 0.70, curve: Curves.easeInOut),
          ),
          axisAlignment: -1.0,
          child: child!,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Feature Card 1: Single tap payments
          FadeTransition(
            opacity: _card1FadeAnimation,
            child: SlideTransition(
              position: _card1SlideAnimation,
              child: _buildFeatureCard(
                topMargin: 0,
                title: AppText.singleTapPayments,
                subtitle: AppText.enjoySeamlessPaymentsWithoutTheWaitForOTPs,
                icon: Image.asset(
                  AppAssets.singleTapPayments,
                  height: 26,
                  width: 26,
                ),
              ),
            ),
          ),

          // Feature Card 2: Zero failures
          FadeTransition(
            opacity: _card2FadeAnimation,
            child: SlideTransition(
              position: _card2SlideAnimation,
              child: _buildFeatureCard(
                topMargin: 16,
                title: AppText.zeroFailures,
                subtitle: AppText.zeroPaymentFailuresEnsureYouNeverMissAnOrder,
                icon: Image.asset(
                  AppAssets.zeroFailures,
                  height: 26,
                  width: 26,
                ),
              ),
            ),
          ),

          // Feature Card 3: Instant refunds
          FadeTransition(
            opacity: _card3FadeAnimation,
            child: SlideTransition(
              position: _card3SlideAnimation,
              child: _buildFeatureCard(
                topMargin: 16,
                title: AppText.instantRefunds,
                subtitle:
                    AppText.getRefundsInstantlyIntoYourWalletForCancelledOrders,
                icon: Image.asset(
                  AppAssets.realTimeRefunds,
                  height: 26,
                  width: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required Widget icon,
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
            height: 65,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withAlpha(15), width: 1),
            ),
            child: icon,
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
