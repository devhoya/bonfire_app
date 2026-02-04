import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';

class TimerDisplay extends StatelessWidget {
  final int minutes;
  final int seconds;

  const TimerDisplay({
    super.key,
    required this.minutes,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Minutes
        Column(
          children: [
            GlassContainer(
              hasGlow: true,
              child: Container(
                width: 80,
                height: 56,
                alignment: Alignment.center,
                child: Text(
                  minutes.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'MINS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
                letterSpacing: 2,
              ),
            ),
          ],
        ),

        // Colon separator
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            ':',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),

        // Seconds
        Column(
          children: [
            GlassContainer(
              hasGlow: true,
              child: Container(
                width: 80,
                height: 56,
                alignment: Alignment.center,
                child: Text(
                  seconds.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'SECS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
