import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final void Function() onPlayKitchen;
  final void Function() onViewOrders;
  final void Function() onViewCollection;
  final void Function() onViewUpgrades;
  final void Function() onViewProfile;

  const HomeScreen({
    super.key,
    required this.onPlayKitchen,
    required this.onViewOrders,
    required this.onViewCollection,
    required this.onViewUpgrades,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C1810),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Pantry Rush',
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Cook • Combo • Serve • Upgrade',
                      style: TextStyle(
                        color: Color(0xFFFF6347),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _MenuCard(
                      title: 'Kitchen',
                      icon: '🍳',
                      color: const Color(0xFFFF6347),
                      onTap: onPlayKitchen,
                    ),
                    _MenuCard(
                      title: 'Orders',
                      icon: '📋',
                      color: const Color(0xFF4CAF50),
                      onTap: onViewOrders,
                    ),
                    _MenuCard(
                      title: 'Collection',
                      icon: '🃏',
                      color: const Color(0xFF2196F3),
                      onTap: onViewCollection,
                    ),
                    _MenuCard(
                      title: 'Upgrade',
                      icon: '⚡',
                      color: const Color(0xFFFFC107),
                      onTap: onViewUpgrades,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onViewProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B4513),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '👤',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 64),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
