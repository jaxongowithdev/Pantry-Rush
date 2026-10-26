import '../game/game_theme.dart';

class CardEffects {
  static Map<String, String> getCardEffect(String assetName) {
    final parts = assetName.replaceAll('.svg', '').split('_of_');
    if (parts.length != 2) return {'name': 'Unknown', 'effect': 'No effect'};

    final rank = parts[0];
    final suit = parts[1];

    switch (suit) {
      case 'spades':
        return _getIngredientEffect(rank);
      case 'hearts':
        return _getCookingEffect(rank);
      case 'diamonds':
        return _getServiceEffect(rank);
      case 'clubs':
        return _getSkillEffect(rank);
      default:
        return {'name': 'Unknown', 'effect': 'No effect'};
    }
  }

  static Map<String, String> _getIngredientEffect(String rank) {
    switch (rank) {
      case '2':
        return {'name': 'Extra Tomato', 'effect': '+5% progress'};
      case '3':
        return {'name': 'Fresh Herbs', 'effect': '+7% progress'};
      case '4':
        return {'name': 'Quality Oil', 'effect': '+10% progress'};
      case '5':
        return {'name': 'Fresh Meat', 'effect': '+12% progress'};
      case '6':
        return {'name': 'Organic Veggies', 'effect': '+15% progress'};
      case '7':
        return {'name': 'Premium Fish', 'effect': '+17% progress'};
      case '8':
        return {'name': 'Exotic Spices', 'effect': '+20% progress'};
      case '9':
        return {'name': 'Rare Ingredient', 'effect': '+22% progress'};
      case '10':
        return {'name': 'Premium Ingredient', 'effect': '+25% progress'};
      case 'jack':
        return {'name': 'Chef\'s Special', 'effect': '+30% progress'};
      case 'queen':
        return {'name': 'Luxury Item', 'effect': '+35% progress'};
      case 'king':
        return {'name': 'Golden Ingredient', 'effect': '+40% progress'};
      case 'ace':
        return {'name': 'Perfect Ingredient', 'effect': '+50% progress'};
      default:
        return {'name': 'Ingredient', 'effect': '+5% progress'};
    }
  }

  static Map<String, String> _getCookingEffect(String rank) {
    switch (rank) {
      case '2':
        return {'name': 'Reduce Burn', 'effect': 'Burn prevention +5s'};
      case '3':
        return {'name': 'Steady Heat', 'effect': 'Better heat control'};
      case '4':
        return {'name': 'Quick Prep', 'effect': '+8% progress'};
      case '5':
        return {'name': 'Efficient Cook', 'effect': '+10% progress'};
      case '6':
        return {'name': 'Heat Master', 'effect': '+12% progress'};
      case '7':
        return {'name': 'Fast Cook', 'effect': '+15% progress'};
      case '8':
        return {'name': 'Speed Boost', 'effect': '+18% progress'};
      case '9':
        return {'name': 'Pro Technique', 'effect': '+20% progress'};
      case '10':
        return {'name': 'Master Cook', 'effect': '+25% progress'};
      case 'jack':
        return {'name': 'Quick Recovery', 'effect': 'Fix mistakes'};
      case 'queen':
        return {'name': 'Instant Recovery', 'effect': 'Perfect recovery'};
      case 'king':
        return {'name': 'Time Warp', 'effect': '+30% progress'};
      case 'ace':
        return {'name': 'Perfect Timing', 'effect': '+50% progress'};
      default:
        return {'name': 'Cooking Skill', 'effect': '+5% progress'};
    }
  }

  static Map<String, String> _getServiceEffect(String rank) {
    switch (rank) {
      case '2':
        return {'name': 'Smile', 'effect': '+10% tip'};
      case '3':
        return {'name': 'Extra Tip', 'effect': '+15% tip'};
      case '4':
        return {'name': 'Good Service', 'effect': '+20% tip'};
      case '5':
        return {'name': 'Great Service', 'effect': '+25% tip'};
      case '6':
        return {'name': 'Patience Boost', 'effect': '+10s patience'};
      case '7':
        return {'name': 'Calm Customer', 'effect': '+15s patience'};
      case '8':
        return {'name': 'Double Order', 'effect': '2x rewards'};
      case '9':
        return {'name': 'VIP Treatment', 'effect': '2.5x rewards'};
      case '10':
        return {'name': 'Premium Service', 'effect': '3x rewards'};
      case 'jack':
        return {'name': 'Happy Hour', 'effect': '+50% tip'};
      case 'queen':
        return {'name': 'Celebrity Service', 'effect': 'VIP upgrade'};
      case 'king':
        return {'name': 'VIP Customer', 'effect': '3x rewards'};
      case 'ace':
        return {'name': 'Rush Hour', 'effect': '5x rewards'};
      default:
        return {'name': 'Service', 'effect': '+10% tip'};
    }
  }

  static Map<String, String> _getSkillEffect(String rank) {
    switch (rank) {
      case '2':
        return {'name': 'Auto Chop', 'effect': '+5% progress'};
      case '3':
        return {'name': 'Quick Slice', 'effect': '+7% progress'};
      case '4':
        return {'name': 'Fast Hands', 'effect': '+10% progress'};
      case '5':
        return {'name': 'Multi-Task', 'effect': '+12% progress'};
      case '6':
        return {'name': 'Speed Prep', 'effect': '+15% progress'};
      case '7':
        return {'name': 'Power Boost', 'effect': '+17% progress'};
      case '8':
        return {'name': 'Freeze Timer', 'effect': '+20s patience'};
      case '9':
        return {'name': 'Time Stop', 'effect': '+25s patience'};
      case '10':
        return {'name': 'Extra Time', 'effect': '+30s patience'};
      case 'jack':
        return {'name': 'Combo Start', 'effect': 'Begin combo'};
      case 'queen':
        return {'name': 'Combo Dish', 'effect': '+2x combo'};
      case 'king':
        return {'name': 'Master Combo', 'effect': '+3x combo'};
      case 'ace':
        return {'name': 'Chef Mode', 'effect': 'Auto-complete'};
      default:
        return {'name': 'Skill', 'effect': '+5% progress'};
    }
  }
}
