import '../game/game_theme.dart';

class DishData {
  static const List<Dish> allDishes = [
    // Fast Food
    Dish(
      name: 'Burger',
      emoji: '🍔',
      cookTime: 30,
      difficulty: 1,
      reward: 50,
      ingredients: ['bun', 'patty', 'lettuce'],
      category: DishCategory.fastFood,
    ),
    Dish(
      name: 'Pizza',
      emoji: '🍕',
      cookTime: 45,
      difficulty: 2,
      reward: 80,
      ingredients: ['dough', 'sauce', 'cheese'],
      category: DishCategory.fastFood,
    ),
    Dish(
      name: 'Hot Dog',
      emoji: '🌭',
      cookTime: 20,
      difficulty: 1,
      reward: 40,
      ingredients: ['bun', 'sausage', 'mustard'],
      category: DishCategory.fastFood,
    ),
    Dish(
      name: 'Fries',
      emoji: '🍟',
      cookTime: 15,
      difficulty: 1,
      reward: 30,
      ingredients: ['potato', 'oil', 'salt'],
      category: DishCategory.fastFood,
    ),

    // Asian
    Dish(
      name: 'Ramen',
      emoji: '🍜',
      cookTime: 40,
      difficulty: 3,
      reward: 100,
      ingredients: ['noodles', 'broth', 'egg'],
      category: DishCategory.asian,
    ),
    Dish(
      name: 'Sushi',
      emoji: '🍣',
      cookTime: 50,
      difficulty: 4,
      reward: 120,
      ingredients: ['rice', 'fish', 'nori'],
      category: DishCategory.asian,
    ),
    Dish(
      name: 'Fried Rice',
      emoji: '🍚',
      cookTime: 25,
      difficulty: 2,
      reward: 60,
      ingredients: ['rice', 'egg', 'vegetables'],
      category: DishCategory.asian,
    ),
    Dish(
      name: 'Dumplings',
      emoji: '🥟',
      cookTime: 35,
      difficulty: 3,
      reward: 90,
      ingredients: ['wrapper', 'meat', 'vegetables'],
      category: DishCategory.asian,
    ),

    // Desserts
    Dish(
      name: 'Ice Cream',
      emoji: '🍨',
      cookTime: 10,
      difficulty: 1,
      reward: 35,
      ingredients: ['cream', 'sugar', 'flavor'],
      category: DishCategory.dessert,
    ),
    Dish(
      name: 'Cake',
      emoji: '🍰',
      cookTime: 60,
      difficulty: 4,
      reward: 150,
      ingredients: ['flour', 'eggs', 'sugar'],
      category: DishCategory.dessert,
    ),
    Dish(
      name: 'Donut',
      emoji: '🍩',
      cookTime: 25,
      difficulty: 2,
      reward: 55,
      ingredients: ['dough', 'sugar', 'glaze'],
      category: DishCategory.dessert,
    ),
    Dish(
      name: 'Cookie',
      emoji: '🍪',
      cookTime: 20,
      difficulty: 1,
      reward: 45,
      ingredients: ['flour', 'butter', 'chocolate'],
      category: DishCategory.dessert,
    ),

    // Seafood
    Dish(
      name: 'Grilled Fish',
      emoji: '🐟',
      cookTime: 35,
      difficulty: 3,
      reward: 95,
      ingredients: ['fish', 'lemon', 'herbs'],
      category: DishCategory.seafood,
    ),
    Dish(
      name: 'Shrimp',
      emoji: '🦐',
      cookTime: 20,
      difficulty: 2,
      reward: 70,
      ingredients: ['shrimp', 'garlic', 'butter'],
      category: DishCategory.seafood,
    ),
    Dish(
      name: 'Crab',
      emoji: '🦀',
      cookTime: 40,
      difficulty: 3,
      reward: 110,
      ingredients: ['crab', 'butter', 'spices'],
      category: DishCategory.seafood,
    ),

    // Drinks
    Dish(
      name: 'Coffee',
      emoji: '☕',
      cookTime: 10,
      difficulty: 1,
      reward: 25,
      ingredients: ['beans', 'water', 'milk'],
      category: DishCategory.drinks,
    ),
    Dish(
      name: 'Smoothie',
      emoji: '🥤',
      cookTime: 15,
      difficulty: 1,
      reward: 35,
      ingredients: ['fruit', 'yogurt', 'ice'],
      category: DishCategory.drinks,
    ),
    Dish(
      name: 'Juice',
      emoji: '🧃',
      cookTime: 10,
      difficulty: 1,
      reward: 30,
      ingredients: ['fruit', 'water', 'sugar'],
      category: DishCategory.drinks,
    ),
  ];

  static Dish getRandomDish() {
    final dishes = List<Dish>.from(allDishes);
    dishes.shuffle();
    return dishes.first;
  }

  static List<Dish> getDishesByCategory(DishCategory category) {
    return allDishes.where((d) => d.category == category).toList();
  }
}
