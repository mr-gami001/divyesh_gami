import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackTap;
  final VoidCallback onSettingsTap;
  final AnimationController animationController;

  const CustomAppBar({
    super.key,
    required this.onBackTap,
    required this.onSettingsTap,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          _AppBarButton(
            icon: Icons.chevron_left_rounded,
            onTap: onBackTap,
          ),
          
          // Settings Button (visible after animation completes)
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              final isCompleted = animationController.isCompleted;
              return AnimatedOpacity(
                opacity: isCompleted ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                child: IgnorePointer(
                  ignoring: !isCompleted,
                  child: child,
                ),
              );
            },
            child: _AppBarButton(
              icon: Icons.settings_rounded,
              onTap: onSettingsTap,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.08),
          border: Border.all(
            color: Colors.white.withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
