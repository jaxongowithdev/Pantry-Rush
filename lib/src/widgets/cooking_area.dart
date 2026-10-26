import 'package:flutter/material.dart';
import '../game/memory_game.dart';
import '../game/game_theme.dart';

class CookingArea extends StatelessWidget {
  final double cookProgress;
  final double patience;
  final HeatLevel heatLevel;
  final CookingState state;
  final Dish? currentDish;

  const CookingArea({
    super.key,
    required this.cookProgress,
    required this.patience,
    required this.heatLevel,
    required this.state,
    this.currentDish,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCustomerArea(),
        const SizedBox(height: 16),
        _buildStoveArea(),
        const SizedBox(height: 16),
        _buildProgressBars(),
      ],
    );
  }

  Widget _buildCustomerArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF4A2C1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD2691E), width: 2),
      ),
      child: Row(
        children: [
          const Text('👨‍🍳', style: TextStyle(fontSize: 48)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Order',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getOrderText(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _getStateEmoji(),
            style: const TextStyle(fontSize: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildStoveArea() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1810),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getHeatColor(),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: _getHeatColor().withValues(alpha: 0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getStoveEmoji(),
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 8),
            Text(
              _getHeatText(),
              style: TextStyle(
                color: _getHeatColor(),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBars() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildBar(
            label: 'Cooking',
            value: cookProgress / 100,
            color: _getCookProgressColor(),
            icon: '🍳',
          ),
          const SizedBox(height: 12),
          _buildBar(
            label: 'Patience',
            value: patience / 100,
            color: _getPatienceColor(),
            icon: '⏱️',
          ),
        ],
      ),
    );
  }

  Widget _buildBar({
    required String label,
    required double value,
    required Color color,
    required String icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: 16,
            backgroundColor: Colors.black38,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }

  String _getOrderText() {
    if (currentDish != null) {
      switch (state) {
        case CookingState.idle:
          return 'Waiting...';
        case CookingState.preparing:
          return '${currentDish!.emoji} ${currentDish!.name}';
        case CookingState.cooking:
          return 'Cooking ${currentDish!.name}...';
        case CookingState.serving:
          return '${currentDish!.emoji} ${currentDish!.name} Ready!';
      }
    }

    switch (state) {
      case CookingState.idle:
        return 'Waiting...';
      case CookingState.preparing:
        return 'Tap a card to start!';
      case CookingState.cooking:
        return 'Cooking in progress!';
      case CookingState.serving:
        return 'Serving dish!';
    }
  }

  String _getStateEmoji() {
    switch (state) {
      case CookingState.idle:
        return '😴';
      case CookingState.preparing:
        return '🤔';
      case CookingState.cooking:
        return '👨‍🍳';
      case CookingState.serving:
        return '🎉';
    }
  }

  String _getStoveEmoji() {
    // Show dish emoji when serving or cooking
    if (state == CookingState.serving && currentDish != null) {
      return currentDish!.emoji;
    }

    if (state == CookingState.cooking && currentDish != null) {
      return currentDish!.emoji;
    }

    if (state == CookingState.preparing && currentDish != null) {
      return currentDish!.emoji;
    }

    if (state == CookingState.idle) return '🍽️';

    switch (heatLevel) {
      case HeatLevel.cold:
        return '❄️';
      case HeatLevel.good:
        return '🔥';
      case HeatLevel.burn:
        return '💥';
    }
  }

  String _getHeatText() {
    switch (heatLevel) {
      case HeatLevel.cold:
        return 'COLD';
      case HeatLevel.good:
        return 'PERFECT!';
      case HeatLevel.burn:
        return 'BURNING!';
    }
  }

  Color _getHeatColor() {
    switch (heatLevel) {
      case HeatLevel.cold:
        return Colors.blue;
      case HeatLevel.good:
        return Colors.green;
      case HeatLevel.burn:
        return Colors.red;
    }
  }

  Color _getCookProgressColor() {
    if (cookProgress < 30) return Colors.blue;
    if (cookProgress <= 70) return Colors.green;
    return Colors.orange;
  }

  Color _getPatienceColor() {
    if (patience > 60) return Colors.green;
    if (patience > 30) return Colors.orange;
    return Colors.red;
  }
}
