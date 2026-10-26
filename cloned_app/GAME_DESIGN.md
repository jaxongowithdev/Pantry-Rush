# Tiny Chef - Game Design Document

**Subtitle:** Cook • Combo • Serve • Upgrade

## Overview
Tiny Chef is a fast-paced cooking and time management game where players run a kitchen, serve customers, and use a 52-card deck system for gameplay mechanics.

## Core Categories
- **Category:** Cooking, Time Management, Casual Game
- **Platform:** iPhone, iPad
- **Framework:** Flutter + Flame
- **Mode:** Offline First
- **Target Session:** 1-5 minutes

## Card System (52 SVG Cards)
The 52 playing cards represent different actions and bonuses:

### ♠ Spades - Ingredient Cards
Improve dish quality with better ingredients
- **2♠ - 4♠:** Quick ingredients (+5-10% progress)
- **5♠ - 8♠:** Quality ingredients (+12-20% progress)
- **9♠ - 10♠:** Premium ingredients (+22-25% progress)
- **J♠:** Chef's Special (+30% progress)
- **Q♠:** Luxury Item (+35% progress)
- **K♠:** Golden Ingredient (+40% progress)
- **A♠:** Perfect Ingredient (+50% progress)

### ♥ Hearts - Cooking Cards
Affect cooking process and speed
- **2♥ - 3♥:** Burn prevention, heat control
- **4♥ - 7♥:** Speed boosts (+8-15% progress)
- **8♥ - 10♥:** Master cooking (+18-25% progress)
- **J♥ - Q♥:** Quick/Instant recovery from mistakes
- **K♥:** Time Warp (+30% progress)
- **A♥:** Perfect Timing (+50% progress)

### ♦ Diamonds - Service Cards
Affect customer satisfaction and rewards
- **2♦ - 5♦:** Tip bonuses (+10-25%)
- **6♦ - 7♦:** Patience boost (+10-15 seconds)
- **8♦ - 10♦:** Order multipliers (2x-3x rewards)
- **J♦:** Happy Hour (+50% tip)
- **Q♦:** Celebrity Service (VIP upgrade)
- **K♦:** VIP Customer (3x rewards)
- **A♦:** Rush Hour (5x rewards)

### ♣ Clubs - Skill Cards
Special abilities and power-ups
- **2♣ - 7♣:** Speed and multi-task bonuses (+5-17% progress)
- **8♣ - 10♣:** Time manipulation (+20-30s patience)
- **J♣ - K♣:** Combo system (1x-3x combo multiplier)
- **A♣:** Chef Mode (auto-complete dish)

## Core Game Loop
1. **Receive Order:** Customer arrives with a dish request
2. **Cook:** Tap/use cards to progress cooking
3. **Play Cards:** Use cards during cooking for bonuses
4. **Complete Dish:** Reach 100% cooking progress
5. **Serve:** Deliver to customer based on quality
6. **Earn Coins:** Receive payment + tips
7. **Upgrade Kitchen:** Improve equipment and skills

## Cooking System
- **Heat Levels:** Cold → Good → Burn
- **Cook Progress:** 0-100%
- **Perfect Window:** 30-70% for best results
- **Timing:** Critical for maximum rewards

## Customer Types
1. **Normal** - Standard patience (60s), 1x tip
2. **Family** - Higher patience (70s), 1.5x tip
3. **VIP** - Lower patience (40s), 2x tip
4. **Food Critic** - Low patience (45s), 3-4x tip
5. **Celebrity** - Medium patience (50s), 5x tip

## Dish Categories
1. **Fast Food:** Burgers, Pizza, Fries (Quick & Easy)
2. **Asian:** Ramen, Sushi, Dumplings (Medium Difficulty)
3. **Dessert:** Cake, Ice Cream, Cookies (Variable)
4. **Seafood:** Fish, Shrimp, Crab (Higher Difficulty)
5. **Drinks:** Coffee, Smoothies, Juice (Fast)

## App Structure
### Main Screens
1. **Home/Menu** - Navigate to different areas
2. **Kitchen** - Main gameplay screen
3. **Orders** - Daily orders and challenges
4. **Collection** - View cards, dishes, achievements
5. **Upgrade** - Kitchen improvements
6. **Profile** - Player stats and settings

### Kitchen Screen Layout
```
┌─────────────────────────────┐
│   Order Display Area        │
│   Customer + Patience       │
├─────────────────────────────┤
│                             │
│   Cooking Area              │
│   Progress Bar              │
│   Heat Indicator            │
│                             │
├─────────────────────────────┤
│  [Card] [Card] [Card] ...   │
│  Available Cards (5 cards)  │
└─────────────────────────────┘
```

## Progression System
- **Chef Level:** Increases with orders completed
- **Total Coins:** Currency for upgrades
- **Orders Completed:** Main progress metric
- **Collection Progress:** Cards/Dishes/Achievements unlocked

## Upgrade Types
1. **Stove:** Faster cooking speed
2. **Counter:** More workspace (more cards)
3. **Kitchen Size:** Better capacity
4. **Auto Tools:** Automation features
5. **Decoration:** Customer patience boost

## Daily Systems
- Daily Orders: Special requests for bonus rewards
- Daily Challenges: Complete specific tasks
- Achievement System: Long-term goals

## Content Scale (MVP)
- Cards: 52 (all playing cards)
- Dishes: 18 different dishes
- Customers: 12 customer types
- Upgrades: Expandable system
- Achievements: Track milestones

## Technical Implementation
- **Game Engine:** Flame (Flutter game engine)
- **Card Assets:** 52 SVG files (existing playing cards)
- **State Management:** Flutter StatefulWidget
- **Persistence:** Local storage for progress
- **Performance:** Optimized for mobile devices

## Key Differences from Memory Game
All game mechanics have been completely changed:
- No card matching or memory mechanics
- Real-time cooking simulation
- Customer service and time management
- Economic system with coins and upgrades
- Progressive difficulty and upgrade path
- Different UI/UX optimized for cooking game

## Color Scheme
- **Background:** Dark brown (#2C1810) - Kitchen theme
- **Primary:** Tomato red (#FF6347) - Cooking theme
- **Accent:** Gold (#FFD700) - Rewards/Chef
- **Secondary:** Brown (#8B4513) - Wood/Kitchen
- **Success:** Green (#4CAF50) - Orders/Completion
