import 'package:flutter/material.dart';

class EmotionalFlameTransformationScreen extends StatelessWidget {
  const EmotionalFlameTransformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF13EC80);

    return Scaffold(
      backgroundColor: const Color(0xFF102219),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Healing Hearth'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    height: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1497800839469-bdbe4fd9de1e?q=80&w=1200',
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: emerald.withOpacity(0.35),
                          blurRadius: 50,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Your memory has turned into light',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The transformation is complete. Feel the peace of the emerald flame.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: emerald, fontSize: 15),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'EMOTIONAL FLAME COLORS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      letterSpacing: 2.8,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _FlameColor('Sadness', Colors.blue, true),
                      _FlameColor('Anger', Colors.red, true),
                      _FlameColor('Healing', emerald, false, isActive: true),
                      _FlameColor('Joy', Colors.amber, true),
                      _FlameColor('Peace', Colors.white54, true),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: emerald.withOpacity(0.4)),
                foregroundColor: emerald,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              ),
              child: const Text('REST IN PRESENCE'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlameColor extends StatelessWidget {
  const _FlameColor(this.label, this.color, this.locked, {this.isActive = false});

  final String label;
  final Color color;
  final bool locked;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: isActive ? 56 : 48,
          height: isActive ? 56 : 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.16),
            border: Border.all(color: color.withOpacity(isActive ? 1 : 0.35), width: 2),
          ),
          child: Icon(
            locked ? Icons.lock : Icons.auto_awesome,
            color: color,
            size: isActive ? 26 : 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: isActive ? color : Colors.white54,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
