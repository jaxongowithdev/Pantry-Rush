import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../game/game_theme.dart';
import '../data/dishes.dart';
import '../data/card_effects.dart';

class CollectionScreen extends StatefulWidget {
  final VoidCallback onBack;

  const CollectionScreen({super.key, required this.onBack});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      '🃏 Collection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFFF6347),
              labelColor: const Color(0xFFFF6347),
              unselectedLabelColor: Colors.white60,
              tabs: const [
                Tab(text: 'Cards (52)'),
                Tab(text: 'Dishes'),
                Tab(text: 'Achievements'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCardsTab(),
                  _buildDishesTab(),
                  _buildAchievementsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsTab() {
    final cards = ChefCard.allCardAssets;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        final effect = CardEffects.getCardEffect(card);

        return GestureDetector(
          onTap: () => _showCardDetail(card, effect),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD84315), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  'packages/tiny_chef/assets/cards/$card',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDishesTab() {
    final dishes = DishData.allDishes;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF4A2C1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD2691E), width: 2),
          ),
          child: Row(
            children: [
              Text(dish.emoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_getCategoryName(dish.category)} • ${dish.cookTime}s',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('💰', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          '${dish.reward} coins',
                          style: const TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ...List.generate(
                          dish.difficulty,
                          (i) => const Icon(
                            Icons.star,
                            color: Color(0xFFFF6347),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementsTab() {
    final achievements = [
      {'icon': '🏆', 'name': 'First Order', 'desc': 'Complete your first order', 'progress': 1.0},
      {'icon': '🔥', 'name': 'Hot Streak', 'desc': 'Complete 10 orders in a row', 'progress': 0.3},
      {'icon': '👨‍🍳', 'name': 'Master Chef', 'desc': 'Reach level 10', 'progress': 0.1},
      {'icon': '💎', 'name': 'Card Collector', 'desc': 'Use all 52 cards', 'progress': 0.15},
      {'icon': '⭐', 'name': 'Perfect Service', 'desc': 'Get 100% satisfaction 5 times', 'progress': 0.0},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        final isCompleted = (achievement['progress'] as double) >= 1.0;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCompleted ? const Color(0xFF1B5E20) : const Color(0xFF4A2C1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCompleted ? const Color(0xFF66BB6A) : const Color(0xFFD2691E),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Text(
                achievement['icon'] as String,
                style: TextStyle(
                  fontSize: 48,
                  color: isCompleted ? null : Colors.white.withValues(alpha: 0.3),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement['name'] as String,
                      style: TextStyle(
                        color: isCompleted ? Colors.white : Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement['desc'] as String,
                      style: TextStyle(
                        color: isCompleted ? Colors.white70 : Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                    if (!isCompleted) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: achievement['progress'] as double,
                          minHeight: 6,
                          backgroundColor: Colors.black26,
                          valueColor: const AlwaysStoppedAnimation(Color(0xFFFF6347)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCardDetail(String card, Map<String, String> effect) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF2C1810),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 160,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD84315), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD84315).withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      'packages/tiny_chef/assets/cards/$card',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                effect['name']!,
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                effect['effect']!,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6347),
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCardRankDisplay(String card) {
    final parts = card.replaceAll('.svg', '').split('_of_');
    if (parts.isEmpty) return '?';
    final rank = parts[0];
    switch (rank) {
      case 'ace':
        return 'A';
      case 'king':
        return 'K';
      case 'queen':
        return 'Q';
      case 'jack':
        return 'J';
      default:
        return rank.toUpperCase();
    }
  }

  String _getSuitEmoji(String card) {
    if (card.contains('spades')) return '♠️';
    if (card.contains('hearts')) return '♥️';
    if (card.contains('diamonds')) return '♦️';
    if (card.contains('clubs')) return '♣️';
    return '?';
  }

  String _getCategoryName(DishCategory category) {
    switch (category) {
      case DishCategory.fastFood:
        return 'Fast Food';
      case DishCategory.asian:
        return 'Asian';
      case DishCategory.dessert:
        return 'Dessert';
      case DishCategory.seafood:
        return 'Seafood';
      case DishCategory.drinks:
        return 'Drinks';
    }
  }
}
