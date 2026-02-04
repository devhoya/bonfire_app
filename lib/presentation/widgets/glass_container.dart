import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final bool isCircular;
  final bool hasGlow;

  const GlassContainer({
    super.key,
    required this.child,
    this.isCircular = false,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.glassDark,
        borderRadius: isCircular ? null : BorderRadius.circular(16),
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
