import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StoveUpgradeStoreScreen extends StatelessWidget {
  const StoveUpgradeStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const _StoreItem('Simple Pit', 'Equipped', true),
      const _StoreItem('Stone Hearth', '1,200 XP', false),
      const _StoreItem('Victorian Iron', 'Level 15', false, locked: true),
      const _StoreItem('Royal Hearth', 'Level 25', false, locked: true),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stove Gallery'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Row(
              children: [
                Icon(Icons.bolt, color: AppTheme.primaryColor, size: 16),
                SizedBox(width: 4),
                Text('2,450 XP'),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFF332219), Color(0xFF120D0B)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CURRENT HEARTH', style: TextStyle(color: AppTheme.primaryColor)),
                SizedBox(height: 4),
                Text('Modern Plasma', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('+25% XP Burn Rate', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Available Upgrades', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, i) => _StoreItemCard(item: items[i]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RECOMMENDED', style: TextStyle(color: AppTheme.primaryColor, fontSize: 11)),
                const SizedBox(height: 6),
                const Text('Iron Maiden 500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Upgrade for 5,000 XP'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreItem {
  const _StoreItem(this.name, this.meta, this.equipped, {this.locked = false});

  final String name;
  final String meta;
  final bool equipped;
  final bool locked;
}

class _StoreItemCard extends StatelessWidget {
  const _StoreItemCard({required this.item});

  final _StoreItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(
          color: item.equipped ? AppTheme.primaryColor : Colors.white.withOpacity(0.1),
          width: item.equipped ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            item.locked ? Icons.lock : (item.equipped ? Icons.check_circle : Icons.fireplace),
            color: item.locked ? Colors.white54 : AppTheme.primaryColor,
          ),
          const SizedBox(height: 8),
          Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(item.meta, style: TextStyle(color: item.equipped ? AppTheme.primaryColor : Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
