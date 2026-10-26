import 'package:flutter/material.dart';

enum CardSuit { spades, hearts, diamonds, clubs }

enum CardType { ingredient, cooking, service, skill }

class ChefCard {
  final String asset;
  final CardSuit suit;
  final String rank;
  final int value;
  final CardType type;
  final String name;
  final String description;
  final Color color;

  const ChefCard({
    required this.asset,
    required this.suit,
    required this.rank,
    required this.value,
    required this.type,
    required this.name,
    required this.description,
    required this.color,
  });

  static const List<String> allCardAssets = [
    'ace_of_spades.svg', 'king_of_spades.svg', 'queen_of_spades.svg', 'jack_of_spades.svg',
    '10_of_spades.svg', '9_of_spades.svg', '8_of_spades.svg', '7_of_spades.svg',
    '6_of_spades.svg', '5_of_spades.svg', '4_of_spades.svg', '3_of_spades.svg', '2_of_spades.svg',
    'ace_of_hearts.svg', 'king_of_hearts.svg', 'queen_of_hearts.svg', 'jack_of_hearts.svg',
    '10_of_hearts.svg', '9_of_hearts.svg', '8_of_hearts.svg', '7_of_hearts.svg',
    '6_of_hearts.svg', '5_of_hearts.svg', '4_of_hearts.svg', '3_of_hearts.svg', '2_of_hearts.svg',
    'ace_of_diamonds.svg', 'king_of_diamonds.svg', 'queen_of_diamonds.svg', 'jack_of_diamonds.svg',
    '10_of_diamonds.svg', '9_of_diamonds.svg', '8_of_diamonds.svg', '7_of_diamonds.svg',
    '6_of_diamonds.svg', '5_of_diamonds.svg', '4_of_diamonds.svg', '3_of_diamonds.svg', '2_of_diamonds.svg',
    'ace_of_clubs.svg', 'king_of_clubs.svg', 'queen_of_clubs.svg', 'jack_of_clubs.svg',
    '10_of_clubs.svg', '9_of_clubs.svg', '8_of_clubs.svg', '7_of_clubs.svg',
    '6_of_clubs.svg', '5_of_clubs.svg', '4_of_clubs.svg', '3_of_clubs.svg', '2_of_clubs.svg',
  ];
}

class Dish {
  final String name;
  final String emoji;
  final int cookTime;
  final int difficulty;
  final int reward;
  final List<String> ingredients;
  final DishCategory category;

  const Dish({
    required this.name,
    required this.emoji,
    required this.cookTime,
    required this.difficulty,
    required this.reward,
    required this.ingredients,
    required this.category,
  });
}

enum DishCategory { fastFood, asian, dessert, seafood, drinks }

class Customer {
  final String name;
  final String emoji;
  final CustomerType type;
  final int patience;
  final double tipMultiplier;

  const Customer({
    required this.name,
    required this.emoji,
    required this.type,
    required this.patience,
    required this.tipMultiplier,
  });
}

enum CustomerType { normal, family, vip, critic, celebrity }

class KitchenUpgrade {
  final String name;
  final String description;
  final String icon;
  final int cost;
  final UpgradeType type;

  const KitchenUpgrade({
    required this.name,
    required this.description,
    required this.icon,
    required this.cost,
    required this.type,
  });
}

enum UpgradeType { stove, counter, size, autoTool, decoration }
