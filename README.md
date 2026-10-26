# Tiny Chef 👨‍🍳

**Cook • Combo • Serve • Upgrade**

A fast-paced cooking and time management game built with Flutter and Flame engine.

## 🎮 Game Overview

Tiny Chef is a casual cooking game where you manage a kitchen, serve customers, and use a unique 52-card system to enhance your cooking abilities. Each game session is designed to be quick and engaging, lasting 1-5 minutes.

### Categories
- 🍳 **Cooking**
- ⏱️ **Time Management**
- 🎯 **Casual Game**

### Platform
- 📱 **iPhone**
- 📱 **iPad**

### Tech Stack
- **Framework:** Flutter
- **Game Engine:** Flame
- **Mode:** Offline First

## 🃏 52-Card System

The game uses a standard 52-card deck where each card has a unique effect:

### ♠ Spades - Ingredient Cards
Add quality ingredients to boost cooking progress
- **2-4♠:** Quick ingredients (+5-10%)
- **5-8♠:** Quality ingredients (+12-20%)
- **9-10♠:** Premium ingredients (+22-25%)
- **J-K♠:** Special ingredients (+30-40%)
- **A♠:** Perfect ingredient (+50%)

### ♥ Hearts - Cooking Cards
Master your cooking techniques
- **2-3♥:** Heat control
- **4-7♥:** Speed boosts (+8-15%)
- **8-10♥:** Master cooking (+18-25%)
- **J-Q♥:** Recovery from mistakes
- **K♥:** Time Warp (+30%)
- **A♥:** Perfect Timing (+50%)

### ♦ Diamonds - Service Cards
Improve customer satisfaction
- **2-5♦:** Tip bonuses (+10-25%)
- **6-7♦:** Patience boost
- **8-10♦:** Order multipliers (2-3x)
- **J-K♦:** VIP treatment
- **A♦:** Rush Hour (5x rewards)

### ♣ Clubs - Skill Cards
Unlock special abilities
- **2-7♣:** Speed bonuses
- **8-10♣:** Time manipulation
- **J-K♣:** Combo system
- **A♣:** Chef Mode (auto-complete)

## 🎯 Core Gameplay Loop

1. **Receive Order** - Customer arrives with dish request
2. **Cook** - Tap cards to progress cooking
3. **Use Cards** - Play cards for bonuses and effects
4. **Complete** - Reach 100% cooking progress
5. **Serve** - Deliver based on quality
6. **Earn** - Receive coins and tips
7. **Upgrade** - Improve your kitchen

## 🍽️ Dish Categories

### Fast Food
🍔 Burger • 🍕 Pizza • 🌭 Hot Dog • 🍟 Fries

### Asian Cuisine
🍜 Ramen • 🍣 Sushi • 🍚 Fried Rice • 🥟 Dumplings

### Desserts
🍰 Cake • 🍨 Ice Cream • 🍩 Donut • 🍪 Cookie

### Seafood
🐟 Grilled Fish • 🦐 Shrimp • 🦀 Crab

### Drinks
☕ Coffee • 🥤 Smoothie • 🧃 Juice

## 👥 Customer Types

- **Normal** - Standard patience (60s), 1x tip
- **Family** - High patience (70s), 1.5x tip
- **VIP** - Low patience (40s), 2x tip
- **Food Critic** - Critical (45s), 3-4x tip
- **Celebrity** - Medium (50s), 5x tip

## 🏠 App Screens

### Home Screen
Navigate to different areas of the game

### Kitchen
Main gameplay screen with:
- Order display
- Cooking area with heat levels
- Progress indicators (cooking & patience)
- Card deck (5 cards available)

### Orders
Daily orders and challenges for bonus rewards

### Collection
View your:
- Collected cards (52 total)
- Unlocked dishes
- Achievements

### Upgrades
Improve your kitchen:
- 🔥 **Stove** - Faster cooking
- 🍽️ **Counter** - More workspace
- 📏 **Kitchen Size** - Better capacity
- 🤖 **Auto Tools** - Automation
- 🎨 **Decoration** - Customer patience

### Profile
Track your progress:
- Chef Level
- Total Coins
- Orders Completed
- Best Combos

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.32.0 or higher
- Dart SDK 3.4.0 or higher
- FVM (Flutter Version Management) - optional but recommended

### Installation

1. Install dependencies:
```bash
cd example
fvm flutter pub get
```

2. Run the app:
```bash
fvm flutter run
```

Or if not using FVM:
```bash
flutter run
```

### Building for iOS
```bash
cd example
fvm flutter build ios --release
```

### Building for Android
```bash
cd example
fvm flutter build apk --release
```

## 📁 Project Structure

```
lib/
├── src/
│   ├── game/
│   │   ├── card_component.dart      # Card UI component
│   │   ├── game_theme.dart          # Game data models
│   │   └── memory_game.dart         # Main game logic (CookingGame)
│   ├── screens/
│   │   ├── user_screen.dart         # Main app screens
│   │   ├── theme_selection_screen.dart  # Home menu
│   │   └── splash_screen.dart       # App splash screen
│   ├── widgets/
│   │   └── cooking_area.dart        # Cooking UI components
│   └── data/
│       ├── dishes.dart              # Dish database (18 dishes)
│       ├── customers.dart           # Customer database (12 types)
│       └── card_effects.dart        # Card effect system
├── user_screen.dart                 # Public export
└── main.dart                        # App entry point

assets/
└── cards/                           # 52 SVG card assets
    ├── ace_of_hearts.svg
    ├── king_of_spades.svg
    └── ... (50 more cards)
```

## 🎨 Design Philosophy

### Complete Transformation
This is a complete transformation from the previous memory card game:
- **No memory mechanics** - Entirely new cooking gameplay
- **Real-time action** - Active cooking simulation
- **Economic system** - Coins, upgrades, progression
- **Time management** - Customer patience and service
- **Strategic card usage** - Cards enhance gameplay

### Color Scheme
- **Background:** Dark Brown (#2C1810) - Kitchen theme
- **Primary:** Tomato Red (#FF6347) - Cooking energy
- **Accent:** Gold (#FFD700) - Rewards & achievement
- **Secondary:** Wood Brown (#8B4513) - Kitchen materials
- **Success:** Green (#4CAF50) - Completion

### UI Changes
All UI elements have been redesigned to avoid similarity with the previous app:
- New color scheme (kitchen/cooking theme)
- Different layout and navigation
- Cooking-focused interfaces
- Timer and progress systems
- Different interaction patterns

## 📊 Content Scale (MVP)

- ✅ **52 Cards** - Complete deck with unique effects
- ✅ **18 Dishes** - Across 5 categories
- ✅ **12 Customers** - 5 different types
- ✅ **5 Screens** - Home, Kitchen, Orders, Collection, Upgrades, Profile
- ✅ **Splash Screen** - Animated intro
- ✅ **Cooking System** - Heat levels, progress tracking
- ✅ **Upgrade System** - Kitchen improvements

## 🔄 Game Progression

### Earning System
- Complete dishes to earn coins
- Better quality = higher rewards (Perfect cooking: 100 coins)
- Customer type affects tip multiplier (up to 5x)
- Use cards strategically for bonuses

### Heat Levels
- **Cold** ❄️ - Below 30% (50 coins)
- **Good** 🔥 - 30-70% range (100 coins - PERFECT!)
- **Burn** 💥 - Above 70% (20 coins)

### Customer Patience
- Decreases over time
- Can be boosted with Diamond cards
- If patience runs out, customer leaves

## 🎯 Development Status

### Implemented ✅
- Core cooking gameplay
- 52-card system with effects
- 18 different dishes
- 12 customer types
- Complete UI navigation
- Splash screen
- Profile tracking
- Cooking visualization
- Heat level system
- Progress bars

### Future Enhancements
- [ ] More dishes (target: 120)
- [ ] More customers (target: 40)
- [ ] Daily challenges implementation
- [ ] Achievement system
- [ ] Sound effects
- [ ] Background music
- [ ] Combo system logic
- [ ] Local data persistence
- [ ] Statistics tracking

## 📝 App Metadata

- **Name:** Tiny Chef
- **Subtitle:** Cook • Combo • Serve • Upgrade
- **Bundle ID:** Update in project settings
- **Version:** 1.0.0+1
- **iOS Display Name:** Tiny Chef
- **Android Label:** Tiny Chef

## 🐛 Known Issues

- SVG warnings in console (non-critical)
- Some card effects need full implementation

## 📄 License

This project is private and proprietary.

---

**Cook your way to success! 👨‍🍳🔥**

For more details, see [GAME_DESIGN.md](GAME_DESIGN.md)
