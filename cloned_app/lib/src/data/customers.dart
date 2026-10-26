import '../game/game_theme.dart';

class CustomerData {
  static const List<Customer> allCustomers = [
    // Normal customers
    Customer(
      name: 'Bob',
      emoji: '👨',
      type: CustomerType.normal,
      patience: 60,
      tipMultiplier: 1.0,
    ),
    Customer(
      name: 'Alice',
      emoji: '👩',
      type: CustomerType.normal,
      patience: 55,
      tipMultiplier: 1.0,
    ),
    Customer(
      name: 'Charlie',
      emoji: '🧑',
      type: CustomerType.normal,
      patience: 65,
      tipMultiplier: 1.0,
    ),
    Customer(
      name: 'Emma',
      emoji: '👧',
      type: CustomerType.normal,
      patience: 50,
      tipMultiplier: 1.0,
    ),

    // Family customers
    Customer(
      name: 'The Smiths',
      emoji: '👨‍👩‍👧‍👦',
      type: CustomerType.family,
      patience: 70,
      tipMultiplier: 1.5,
    ),
    Customer(
      name: 'The Johnsons',
      emoji: '👨‍👩‍👧',
      type: CustomerType.family,
      patience: 75,
      tipMultiplier: 1.5,
    ),

    // VIP customers
    Customer(
      name: 'Mr. Rich',
      emoji: '🤵',
      type: CustomerType.vip,
      patience: 40,
      tipMultiplier: 2.0,
    ),
    Customer(
      name: 'Ms. Luxury',
      emoji: '👰',
      type: CustomerType.vip,
      patience: 35,
      tipMultiplier: 2.5,
    ),

    // Food critics
    Customer(
      name: 'The Critic',
      emoji: '🧐',
      type: CustomerType.critic,
      patience: 45,
      tipMultiplier: 3.0,
    ),
    Customer(
      name: 'Chef Gordon',
      emoji: '👨‍🍳',
      type: CustomerType.critic,
      patience: 30,
      tipMultiplier: 4.0,
    ),

    // Celebrities
    Customer(
      name: 'Star Player',
      emoji: '⭐',
      type: CustomerType.celebrity,
      patience: 50,
      tipMultiplier: 5.0,
    ),
    Customer(
      name: 'Famous Singer',
      emoji: '🎤',
      type: CustomerType.celebrity,
      patience: 45,
      tipMultiplier: 5.5,
    ),
  ];

  static Customer getRandomCustomer() {
    final customers = List<Customer>.from(allCustomers);
    customers.shuffle();
    return customers.first;
  }

  static List<Customer> getCustomersByType(CustomerType type) {
    return allCustomers.where((c) => c.type == type).toList();
  }
}
