import 'package:flutter/material.dart';

import 'emotional_flame_transformation_screen.dart';

class MemoryBurningRitualViewScreen extends StatelessWidget {
  const MemoryBurningRitualViewScreen({
    super.key,
    required this.memoryText,
  });

  final String memoryText;

  @override
  Widget build(BuildContext context) {
    const ritual = Color(0xFF7F13EC);

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1533895225690-9fdd998c7b80?q=80&w=1200',
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: ritual.withOpacity(0.25),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Spacer(),
                Transform.rotate(
                  angle: -0.04,
                  child: Container(
                    width: 280,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDFCF0).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      memoryText.isEmpty
                          ? 'Letting go of the fear that held me back...'
                          : memoryText,
                      style: const TextStyle(
                        color: Color(0xB3000000),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [ritual, Colors.blueAccent, Colors.transparent],
                    ),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: ritual.withOpacity(0.5),
                        blurRadius: 46,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'GENTLY FADING',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    letterSpacing: 6,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.white24,
                    color: ritual.withOpacity(0.7),
                    minHeight: 2,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmotionalFlameTransformationScreen(),
                      ),
                    );
                  },
                  child: const Text('Complete Ritual'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
