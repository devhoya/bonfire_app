import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'memory_burning_ritual_view_screen.dart';

class FirewoodMemoryBurnerScreen extends StatefulWidget {
  const FirewoodMemoryBurnerScreen({super.key});

  @override
  State<FirewoodMemoryBurnerScreen> createState() =>
      _FirewoodMemoryBurnerScreenState();
}

class _FirewoodMemoryBurnerScreenState extends State<FirewoodMemoryBurnerScreen> {
  final List<_Wood> _woods = [
    const _Wood('Oak', 'Sturdy, slow-burning premium hardwood.'),
    const _Wood('Birch', 'Bright, lively flames with sweet aroma.'),
    const _Wood('Pine', 'High crackle and intense heat spikes.'),
  ];

  int _selectedWood = 0;
  final TextEditingController _memoryController = TextEditingController();

  @override
  void dispose() {
    _memoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _woods[_selectedWood];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fireplace Setup'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Fire',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 168,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _woods.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final item = _woods[index];
                  final selectedCard = index == _selectedWood;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedWood = index),
                    child: Container(
                      width: 240,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selectedCard
                              ? AppTheme.primaryColor
                              : Colors.white.withOpacity(0.12),
                          width: selectedCard ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 8),
                          Text(item.desc,
                              style:
                                  TextStyle(color: Colors.white.withOpacity(0.7))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${selected.name} Characteristics',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const _StatTile('Burn Time', 0.95, Icons.schedule),
            const _StatTile('Crackle Intensity', 0.70, Icons.volume_up),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.palette, color: AppTheme.primaryColor),
              title: Text('Flame Color'),
              subtitle: Text('Deep Amber'),
              trailing: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Burn a Memory',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF4ECD8),
              ),
              child: TextField(
                controller: _memoryController,
                maxLines: 6,
                style: const TextStyle(color: Color(0xFF4A3728)),
                decoration: const InputDecoration(
                  hintText: 'Write your thought, regret, or secret here...',
                  hintStyle: TextStyle(color: Color(0x994A3728)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MemoryBurningRitualViewScreen(
                        memoryText: _memoryController.text,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.local_fire_department),
                label: const Text('Toss Into Fire'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Wood {
  const _Wood(this.name, this.desc);

  final String name;
  final String desc;
}

class _StatTile extends StatelessWidget {
  const _StatTile(this.label, this.value, this.icon);

  final String label;
  final double value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(label),
      trailing: SizedBox(
        width: 100,
        child: LinearProgressIndicator(value: value),
      ),
    );
  }
}
