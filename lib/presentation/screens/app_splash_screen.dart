import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({
    super.key,
    required this.onFinished,
  });

  final VoidCallback onFinished;

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  static const _duration = Duration(milliseconds: 2200);

  @override
  void initState() {
    super.initState();
    Timer(_duration, widget.onFinished);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.95,
            colors: [Color(0xFF221910), AppTheme.backgroundDark],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.45),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_fire_department,
                    size: 96,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'IGNITE',
                  style: TextStyle(
                    fontSize: 34,
                    letterSpacing: 8,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'EMBER & MEMORY',
                  style: TextStyle(
                    color: AppTheme.primaryColor.withOpacity(0.85),
                    letterSpacing: 4,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  'Burning away the day...',
                  style: TextStyle(
                    color: const Color(0xFFCBAD90).withOpacity(0.65),
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    value: 0.42,
                    backgroundColor: const Color(0xFF684D31).withOpacity(0.3),
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _Label('System Warmup'),
                    _Label('42%'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF684D31),
        fontSize: 10,
        letterSpacing: 1.6,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
