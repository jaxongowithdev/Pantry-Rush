import 'package:shared_preferences/shared_preferences.dart';

class GameDataManager {
  static const String _keyCoins = 'total_coins';
  static const String _keyOrders = 'orders_completed';
  static const String _keyLevel = 'chef_level';
  static const String _keyStoveLevel = 'upgrade_stove';
  static const String _keyCounterLevel = 'upgrade_counter';
  static const String _keySizeLevel = 'upgrade_size';
  static const String _keyAutoToolLevel = 'upgrade_auto_tool';
  static const String _keyDecorationLevel = 'upgrade_decoration';

  late SharedPreferences _prefs;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // Coins
  Future<int> getCoins() async {
    await init();
    return _prefs.getInt(_keyCoins) ?? 0;
  }

  Future<void> saveCoins(int coins) async {
    await init();
    await _prefs.setInt(_keyCoins, coins);
  }

  Future<void> addCoins(int amount) async {
    final current = await getCoins();
    await saveCoins(current + amount);
  }

  Future<bool> spendCoins(int amount) async {
    final current = await getCoins();
    if (current >= amount) {
      await saveCoins(current - amount);
      return true;
    }
    return false;
  }

  // Orders
  Future<int> getOrdersCompleted() async {
    await init();
    return _prefs.getInt(_keyOrders) ?? 0;
  }

  Future<void> incrementOrders() async {
    final current = await getOrdersCompleted();
    await init();
    await _prefs.setInt(_keyOrders, current + 1);
  }

  // Level
  Future<int> getChefLevel() async {
    await init();
    return _prefs.getInt(_keyLevel) ?? 1;
  }

  Future<void> setChefLevel(int level) async {
    await init();
    await _prefs.setInt(_keyLevel, level);
  }

  // Upgrades
  Future<int> getUpgradeLevel(String upgradeType) async {
    await init();
    String key;
    int defaultLevel;

    switch (upgradeType) {
      case 'stove':
        key = _keyStoveLevel;
        defaultLevel = 1;
        break;
      case 'counter':
        key = _keyCounterLevel;
        defaultLevel = 1;
        break;
      case 'size':
        key = _keySizeLevel;
        defaultLevel = 1;
        break;
      case 'autoTool':
        key = _keyAutoToolLevel;
        defaultLevel = 0;
        break;
      case 'decoration':
        key = _keyDecorationLevel;
        defaultLevel = 1;
        break;
      default:
        return 0;
    }

    return _prefs.getInt(key) ?? defaultLevel;
  }

  Future<void> setUpgradeLevel(String upgradeType, int level) async {
    await init();
    String key;

    switch (upgradeType) {
      case 'stove':
        key = _keyStoveLevel;
        break;
      case 'counter':
        key = _keyCounterLevel;
        break;
      case 'size':
        key = _keySizeLevel;
        break;
      case 'autoTool':
        key = _keyAutoToolLevel;
        break;
      case 'decoration':
        key = _keyDecorationLevel;
        break;
      default:
        return;
    }

    await _prefs.setInt(key, level);
  }

  Future<Map<String, int>> getAllUpgradeLevels() async {
    await init();
    return {
      'stove': await getUpgradeLevel('stove'),
      'counter': await getUpgradeLevel('counter'),
      'size': await getUpgradeLevel('size'),
      'autoTool': await getUpgradeLevel('autoTool'),
      'decoration': await getUpgradeLevel('decoration'),
    };
  }

  // Reset all data (for testing)
  Future<void> resetAllData() async {
    await init();
    await _prefs.clear();
  }
}

// Singleton instance
final gameDataManager = GameDataManager();
