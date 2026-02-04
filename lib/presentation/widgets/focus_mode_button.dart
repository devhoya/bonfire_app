import 'package:flutter/material.dart';
import 'glass_container.dart';

class FocusModeButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;

  const FocusModeButton({
    super.key,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? Icons.visibility_off : Icons.visibility,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                isActive ? 'Focus Mode On' : 'Focus Mode',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
