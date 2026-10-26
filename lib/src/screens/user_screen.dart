import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../data/game_data_manager.dart';
import '../game/memory_game.dart';
import '../widgets/coin_popup.dart';
import '../widgets/cooking_area.dart';
import 'collection_screen.dart';
import 'orders_screen.dart';
import 'splash_screen.dart';
import 'theme_selection_screen.dart';
import 'upgrade_screen.dart';

enum AppScreen { home, kitchen, orders, collection, upgrade, profile }

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantry Rush',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF6347)),
        useMaterial3: true,
      ),
      home: const _AppHome(),
    );
  }
}

class _AppHome extends StatefulWidget {
  const _AppHome();

  @override
  State<_AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<_AppHome> {
  AppScreen _currentScreen = AppScreen.home;
  int _totalCoins = 0;
  int _chefLevel = 1;
  int _ordersCompleted = 0;
  bool _showSplash = true;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadGameData();
  }

  Future<void> _loadGameData() async {
    final coins = await gameDataManager.getCoins();
    final orders = await gameDataManager.getOrdersCompleted();
    final level = await gameDataManager.getChefLevel();

    setState(() {
      _totalCoins = coins;
      _ordersCompleted = orders;
      _chefLevel = level;
      _dataLoaded = true;
    });
  }

  Future<void> _saveCoins(int coins) async {
    await gameDataManager.saveCoins(coins);
    setState(() => _totalCoins = coins);
  }

  Future<void> _addOrder() async {
    await gameDataManager.incrementOrders();
    final newCount = await gameDataManager.getOrdersCompleted();
    setState(() => _ordersCompleted = newCount);
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(
        onComplete: () {
          setState(() => _showSplash = false);
        },
      );
    }

    if (!_dataLoaded) {
      return const Scaffold(
        backgroundColor: Color(0xFF2C1810),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFFFF6347)),
          ),
        ),
      );
    }

    switch (_currentScreen) {
      case AppScreen.home:
        return HomeScreen(
          onPlayKitchen: () => setState(() => _currentScreen = AppScreen.kitchen),
          onViewOrders: () => setState(() => _currentScreen = AppScreen.orders),
          onViewCollection: () => setState(() => _currentScreen = AppScreen.collection),
          onViewUpgrades: () => setState(() => _currentScreen = AppScreen.upgrade),
          onViewProfile: () => setState(() => _currentScreen = AppScreen.profile),
        );
      case AppScreen.kitchen:
        return KitchenScreen(
          onBack: () => setState(() => _currentScreen = AppScreen.home),
          onCoinsEarned: (coins) => _saveCoins(coins),
          onOrderCompleted: () => _addOrder(),
        );
      case AppScreen.orders:
        return OrdersScreen(
          onBack: () => setState(() => _currentScreen = AppScreen.home),
        );
      case AppScreen.collection:
        return CollectionScreen(
          onBack: () => setState(() => _currentScreen = AppScreen.home),
        );
      case AppScreen.upgrade:
        return UpgradeScreen(
          onBack: () => setState(() => _currentScreen = AppScreen.home),
          currentCoins: _totalCoins,
          onCoinsChanged: (newCoins) => _saveCoins(newCoins),
        );
      case AppScreen.profile:
        return _ProfileScreen(
          level: _chefLevel,
          coins: _totalCoins,
          ordersCompleted: _ordersCompleted,
          onBack: () => setState(() => _currentScreen = AppScreen.home),
        );
    }
  }
}

class KitchenScreen extends StatefulWidget {
  final VoidCallback onBack;
  final void Function(int) onCoinsEarned;
  final VoidCallback onOrderCompleted;

  const KitchenScreen({
    super.key,
    required this.onBack,
    required this.onCoinsEarned,
    required this.onOrderCompleted,
  });

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  late CookingGame _game;
  String _notification = 'Tap cards to cook!';
  int _currentCoins = 0;
  int _ordersCount = 0;
  bool _showCoinPopup = false;
  int _coinBonus = 0;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    _game = CookingGame(
      onCoinsEarned: (coins) {
        // Calculate the bonus = new total - current total
        final bonus = coins - _currentCoins;
        setState(() {
          _currentCoins = coins;
          _coinBonus = bonus;
          _showCoinPopup = bonus > 0;
        });
        widget.onCoinsEarned(coins);
      },
      onOrderCompleted: () {
        setState(() => _ordersCount++);
        widget.onOrderCompleted();
      },
      onNotification: (msg) {
        setState(() => _notification = msg);
      },
    );
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
                      '🍳 Kitchen',
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
                      border: Border.all(color: const Color(0xFFFFD700), width: 2),
                    ),
                    child: Row(
                      children: [
                        const Text('💰', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 6),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            '$_currentCoins',
                            key: ValueKey<int>(_currentCoins),
                            style: const TextStyle(
                              color: Color(0xFFFFD700),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _startNewGame,
                    icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      _notification,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (_ordersCount > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Text('✅', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            '$_ordersCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            StreamBuilder<int>(
              stream: Stream.periodic(const Duration(milliseconds: 100), (count) => count),
              builder: (context, _) {
                return CookingArea(
                  cookProgress: _game.cookProgress,
                  patience: _game.patience,
                  heatLevel: _game.heat,
                  state: _game.state,
                  currentDish: _game.currentDish,
                );
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  GameWidget(game: _game),
                  if (_showCoinPopup)
                    Positioned.fill(
                      child: CoinPopup(
                        coins: _coinBonus,
                        onComplete: () {
                          setState(() => _showCoinPopup = false);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleScreen extends StatelessWidget {
  final String title;
  final String icon;
  final String content;
  final VoidCallback onBack;

  const _SimpleScreen({
    required this.title,
    required this.icon,
    required this.content,
    required this.onBack,
  });

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
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                  Expanded(
                    child: Text(
                      '$icon $title',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    content,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  final int level;
  final int coins;
  final int ordersCompleted;
  final VoidCallback onBack;

  const _ProfileScreen({
    required this.level,
    required this.coins,
    required this.ordersCompleted,
    required this.onBack,
  });

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
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                  const Expanded(
                    child: Text(
                      '👤 Profile',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '👨‍🍳',
                      style: TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Chef Level $level',
                      style: const TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _StatCard(label: 'Total Coins', value: coins.toString(), icon: '💰'),
                    const SizedBox(height: 16),
                    _StatCard(label: 'Orders Completed', value: ordersCompleted.toString(), icon: '✅'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF8B4513),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
