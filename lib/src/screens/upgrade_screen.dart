import 'package:flutter/material.dart';
import '../data/game_data_manager.dart';

class UpgradeScreen extends StatefulWidget {
  final VoidCallback onBack;
  final int currentCoins;
  final Function(int) onCoinsChanged;

  const UpgradeScreen({
    super.key,
    required this.onBack,
    required this.onCoinsChanged,
    this.currentCoins = 0,
  });

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  Map<String, int> _upgradeLevels = {
    'stove': 1,
    'counter': 1,
    'size': 1,
    'autoTool': 0,
    'decoration': 1,
  };
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUpgradeLevels();
  }

  Future<void> _loadUpgradeLevels() async {
    final levels = await gameDataManager.getAllUpgradeLevels();
    setState(() {
      _upgradeLevels = levels;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF2C1810),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFFFF6347)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF2C1810),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                  const Expanded(
                    child: Text(
                      '⚡ Upgrades',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFD700)),
                    ),
                    child: Row(
                      children: [
                        const Text('💰', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.currentCoins}',
                          style: const TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildUpgradeCard(
                    'stove',
                    '🔥 Stove',
                    'Faster cooking speed',
                    const Color(0xFFFF6347),
                    [100, 200, 400, 800, 1600],
                    '+10% cooking speed per level',
                  ),
                  const SizedBox(height: 12),
                  _buildUpgradeCard(
                    'counter',
                    '🍽️ Counter',
                    'More workspace for cards',
                    const Color(0xFF8B4513),
                    [150, 300, 600, 1200],
                    '+1 card slot per level',
                  ),
                  const SizedBox(height: 12),
                  _buildUpgradeCard(
                    'size',
                    '📏 Kitchen Size',
                    'Bigger kitchen capacity',
                    const Color(0xFF4CAF50),
                    [200, 400, 800, 1600, 3200],
                    '+20% capacity per level',
                  ),
                  const SizedBox(height: 12),
                  _buildUpgradeCard(
                    'autoTool',
                    '🤖 Auto Tools',
                    'Automation features',
                    const Color(0xFF2196F3),
                    [500, 1000, 2000, 4000],
                    'Auto-prep ingredients',
                  ),
                  const SizedBox(height: 12),
                  _buildUpgradeCard(
                    'decoration',
                    '🎨 Decoration',
                    'Customer patience boost',
                    const Color(0xFFFFC107),
                    [100, 250, 500, 1000, 2000],
                    '+5s patience per level',
                  ),
                  const SizedBox(height: 24),
                  _buildBundleOffer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeCard(
    String id,
    String title,
    String description,
    Color color,
    List<int> costs,
    String benefit,
  ) {
    final currentLevel = _upgradeLevels[id] ?? 0;
    final maxLevel = costs.length;
    final isMaxed = currentLevel >= maxLevel;
    final nextCost = isMaxed ? 0 : costs[currentLevel];
    final canAfford = widget.currentCoins >= nextCost;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF4A2C1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color),
                ),
                child: Text(
                  'Lv $currentLevel',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              maxLevel,
              (index) => Expanded(
                child: Container(
                  height: 8,
                  margin: EdgeInsets.only(right: index < maxLevel - 1 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: index < currentLevel ? color : Colors.black26,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      benefit,
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (!isMaxed) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('💰', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          Text(
                            '$nextCost coins',
                            style: TextStyle(
                              color: canAfford ? const Color(0xFFFFD700) : Colors.white54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: isMaxed
                    ? null
                    : canAfford
                        ? () => _upgradeItem(id, nextCost)
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isMaxed ? Colors.grey : color,
                  disabledBackgroundColor: Colors.black26,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isMaxed ? 'MAXED' : 'UPGRADE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBundleOffer() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF9C27B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCE93D8), width: 3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('✨', style: TextStyle(fontSize: 32)),
              SizedBox(width: 8),
              Text(
                'SPECIAL BUNDLE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text('✨', style: TextStyle(fontSize: 32)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  '🔥 All Upgrades +1 Level',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '+ 5000 Bonus Coins',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1999',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Text('💰', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 6),
                    Text(
                      '999',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _buyBundle(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'BUY NOW - 50% OFF!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _upgradeItem(String id, int cost) async {
    // Check if enough coins
    if (widget.currentCoins < cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Deduct coins
    final newCoins = widget.currentCoins - cost;
    widget.onCoinsChanged(newCoins);

    // Upgrade level
    final newLevel = (_upgradeLevels[id] ?? 0) + 1;
    await gameDataManager.setUpgradeLevel(id, newLevel);

    setState(() {
      _upgradeLevels[id] = newLevel;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Upgraded! -$cost coins'),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _buyBundle() async {
    const bundleCost = 999;

    // Check if enough coins
    if (widget.currentCoins < bundleCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough coins!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Deduct coins and add bonus
    final newCoins = widget.currentCoins - bundleCost + 5000;
    widget.onCoinsChanged(newCoins);

    // Upgrade all levels
    for (var key in _upgradeLevels.keys) {
      final newLevel = (_upgradeLevels[key] ?? 0) + 1;
      await gameDataManager.setUpgradeLevel(key, newLevel);
      setState(() {
        _upgradeLevels[key] = newLevel;
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bundle purchased! All upgrades +1 level + 5000 coins'),
        backgroundColor: Color(0xFF7C4DFF),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
