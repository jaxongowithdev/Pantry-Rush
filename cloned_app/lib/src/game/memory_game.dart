import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'card_component.dart';
import 'game_theme.dart';
import '../data/dishes.dart';
import '../data/card_effects.dart';

enum CookingState { idle, preparing, cooking, serving }
enum HeatLevel { cold, good, burn }

class CookingGame extends FlameGame with TapCallbacks {
  final void Function(int coins) onCoinsEarned;
  final void Function() onOrderCompleted;
  final void Function(String message) onNotification;

  CookingGame({
    required this.onCoinsEarned,
    required this.onOrderCompleted,
    required this.onNotification,
  });

  CookingState _state = CookingState.idle;
  HeatLevel _heatLevel = HeatLevel.cold;
  double _cookProgress = 0.0;
  int _totalCoins = 0;
  int _ordersCompleted = 0;
  double _customerPatience = 100.0;
  Dish? _currentDish;

  final List<ChefCardComponent> _availableCards = [];
  ChefCardComponent? _selectedCard;

  final Map<String, ui.Image> _cardImages = {};
  final Random _random = Random();

  @override
  Color backgroundColor() => const Color(0xFF2C1810);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _loadCardImages();
    _startNewOrder();
  }

  Future<void> _loadCardImages() async {
    const imgSize = 200.0;
    // Load all 52 cards
    final cardsToLoad = ChefCard.allCardAssets;

    for (int i = 0; i < cardsToLoad.length; i++) {
      final assetName = cardsToLoad[i];
      try {
        final svgString = await rootBundle.loadString('packages/tiny_chef/assets/cards/$assetName');
        final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        final scaleX = imgSize / pictureInfo.size.width;
        final scaleY = imgSize / pictureInfo.size.height;
        canvas.scale(scaleX, scaleY);
        canvas.drawPicture(pictureInfo.picture);
        final image = await recorder.endRecording().toImage(
          imgSize.toInt(),
          imgSize.toInt(),
        );
        _cardImages[assetName] = image;
        pictureInfo.picture.dispose();
      } catch (e) {
        debugPrint('Failed to load $assetName: $e');
      }
    }
  }

  void _startNewOrder() {
    _state = CookingState.preparing;
    _cookProgress = 0.0;
    _customerPatience = 100.0;
    _heatLevel = HeatLevel.cold;
    _availableCards.clear();

    // Select random dish
    _currentDish = DishData.getRandomDish();

    final cardAssets = ChefCard.allCardAssets.toList()..shuffle(_random);
    final selectedAssets = cardAssets.take(5).toList();

    const double cardWidth = 80.0;
    const double cardHeight = 110.0;
    const double spacing = 10.0;
    final double totalWidth = selectedAssets.length * cardWidth + (selectedAssets.length - 1) * spacing;
    final double startX = (size.x - totalWidth) / 2;
    final double cardY = size.y - cardHeight - 20;

    for (int i = 0; i < selectedAssets.length; i++) {
      final asset = selectedAssets[i];
      final cardEffect = CardEffects.getCardEffect(asset);
      final card = ChefCardComponent(
        asset: asset,
        cardName: cardEffect['name']!,
        position: Vector2(startX + i * (cardWidth + spacing), cardY),
        size: Vector2(cardWidth, cardHeight),
        onTap: _onCardTapped,
        svgImage: _cardImages[asset],
      );
      _availableCards.add(card);
      add(card);
    }
  }

  void _onCardTapped(ChefCardComponent card) {
    if (_state != CookingState.preparing && _state != CookingState.cooking) return;

    _selectedCard = card;

    if (_state == CookingState.preparing) {
      _state = CookingState.cooking;
      _heatLevel = HeatLevel.good;
      onNotification('Cooking started!');
    } else {
      final bonus = _random.nextInt(20) + 10;
      _cookProgress += bonus;
      onNotification('+$bonus% progress');
    }

    card.removeFromParent();
    _availableCards.remove(card);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_state == CookingState.cooking) {
      _cookProgress += dt * 5;
      _customerPatience -= dt * 3;

      if (_cookProgress >= 30 && _cookProgress <= 70) {
        _heatLevel = HeatLevel.good;
      } else if (_cookProgress > 70) {
        _heatLevel = HeatLevel.burn;
      }

      if (_cookProgress >= 100) {
        _serveDish();
      }

      if (_customerPatience <= 0) {
        _customerLeft();
      }
    }
  }

  void _serveDish() {
    _state = CookingState.serving;

    // Calculate coins based on dish reward and quality
    int baseReward = _currentDish?.reward ?? 50;
    int coins;
    String quality;

    if (_heatLevel == HeatLevel.good) {
      // Perfect cooking: 100% reward
      coins = baseReward;
      quality = 'Perfect';
      onNotification('${_currentDish?.emoji ?? '🍽️'} Perfect! +$coins coins');
    } else if (_heatLevel == HeatLevel.burn) {
      // Burnt: 30% reward
      coins = (baseReward * 0.3).round();
      quality = 'Burnt';
      onNotification('${_currentDish?.emoji ?? '🍽️'} Burnt... +$coins coins');
    } else {
      // Cold: 60% reward
      coins = (baseReward * 0.6).round();
      quality = 'Cold';
      onNotification('${_currentDish?.emoji ?? '🍽️'} Cold... +$coins coins');
    }

    _totalCoins += coins;
    _ordersCompleted++;
    onCoinsEarned(_totalCoins);
    onOrderCompleted();

    Future.delayed(const Duration(seconds: 2), () {
      _startNewOrder();
    });
  }

  void _customerLeft() {
    _state = CookingState.idle;
    onNotification('Customer left...');

    Future.delayed(const Duration(seconds: 2), () {
      _startNewOrder();
    });
  }

  double get cookProgress => _cookProgress.clamp(0, 100);
  double get patience => _customerPatience.clamp(0, 100);
  HeatLevel get heat => _heatLevel;
  CookingState get state => _state;
  Dish? get currentDish => _currentDish;
}
