import 'package:divyesh_gami/constants/app_assets.dart';
import 'package:divyesh_gami/constants/app_colors.dart';
import 'package:divyesh_gami/constants/app_text_style.dart';
import 'package:divyesh_gami/widgets/custom_app_bar.dart';
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
    return Container(
      color: AppColors.background,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCelebrationAnimation(context),
          Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: AppColors.transparent,
            appBar: CustomAppBar(
              onBackTap: () {
                // Navigator.of(context).pop();
              },
              onSettingsTap: () {
                // Settings button action
              },
              animationController: _animationController,
            ),
            body: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _fallingLogo(),
                      _blinkitMoneyText(),
                      _featuresCards(),
                      _bottomButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        if (_animationController.isCompleted) {
          return child!;
        }
        return SizedBox.shrink();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          InkWell(
            onTap: () {
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.052,
              decoration: BoxDecoration(
                color: AppColors.successGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                AppText.addMoney,
                style: AppTextStyle.buttonTextStyle,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.008),
          // Claim Gift Card Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height * 0.045,
                  height: MediaQuery.of(context).size.height * 0.045,
                  decoration: BoxDecoration(
                    color: AppColors.orangeHighlight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    AppAssets.giftCard,
                    height: MediaQuery.of(context).size.height * 0.024,
                    width: MediaQuery.of(context).size.height * 0.024,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppText.claimGiftCard,
                        style: AppTextStyle.bold16White,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppText.enterGiftCardDetailsToClaimYourGiftCard,
                        style: AppTextStyle.claimGiftCardSubtitle,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          // Watermark bottom text
          Column(
            children: [
              Text(
                AppText.enjoySeamless,
                style: AppTextStyle.watermarkTextStyle,
              ),
              SizedBox(height: 4),
              Text(
                AppText.oneTapPayments,
                style: AppTextStyle.watermarkTextStyle,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
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
      child: Icon(
        Icons.account_balance_wallet_rounded,
        size: MediaQuery.of(context).size.height * 0.09,
        color: AppColors.white,
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
                  style: AppTextStyle.blinkitTitleStyle,
                ),
              ),
            ),
            FadeTransition(
              opacity: _moneyFadeAnimation,
              child: SlideTransition(
                position: _moneySlideAnimation,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.025,
                  ),
                  child: const Text(
                    AppText.MONEY,
                    style: AppTextStyle.moneyTitleStyle,
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
                  height: MediaQuery.of(context).size.height * 0.024,
                  width: MediaQuery.of(context).size.height * 0.024,
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
                topMargin: MediaQuery.of(context).size.height * 0.012,
                title: AppText.zeroFailures,
                subtitle: AppText.zeroPaymentFailuresEnsureYouNeverMissAnOrder,
                icon: Image.asset(
                  AppAssets.zeroFailures,
                  height: MediaQuery.of(context).size.height * 0.024,
                  width: MediaQuery.of(context).size.height * 0.024,
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
                topMargin: MediaQuery.of(context).size.height * 0.012,
                title: AppText.instantRefunds,
                subtitle:
                    AppText.getRefundsInstantlyIntoYourWalletForCancelledOrders,
                icon: Image.asset(
                  AppAssets.realTimeRefunds,
                  height: MediaQuery.of(context).size.height * 0.024,
                  width: MediaQuery.of(context).size.height * 0.024,
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
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.016),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Black rounded icon container
          Container(
            width: MediaQuery.of(context).size.height * 0.05,
            height: MediaQuery.of(context).size.height * 0.065,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.highlightBorder, width: 1),
            ),
            child: icon,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),

          // Title & Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bold16White,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyle.featureSubtitleStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
