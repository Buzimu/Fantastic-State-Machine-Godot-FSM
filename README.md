# 🎮 Fantastic State Machine
![Godot v4.0+](https://img.shields.io/badge/Godot-v4.0+-blue.svg)
![Status](https://img.shields.io/badge/Status-In_Development-green.svg)

A modular Finite State Machine implementation for Godot 4.0+, focusing on clean architecture and reusable game states.

## 🌟 Core Features

### 🛠️ Base Systems
- Advanced State Machine Architecture
- Universal Hit and Hurt Box System
- Dynamic Animation Management
- Item Collection System with Magnetic Pull

### 🦸 Player Character
| State | Features |
|-------|----------|
| 🧍 Idle | Base animation, input listening (walk/attack) |
| 🚶 Walk | Smooth movement & orientation, input listening (sprint/attack) |
| 🏃 Sprint | Enhanced movement speed, stamina management |
| ⚔️ Attack | Combat animation, dynamic hurtbox creation |

### 🐔 Passive NPCs (Chicken)
| State | Features |
|-------|----------|
| 🧍‍♂️ Idle | Base animation, wandering triggers |
| 🚶‍♂️ Wander | Pathfinding, random movement patterns |
| 💨 Flee | Threat detection, evasive movement |
| ❤️ Health | Damage system, invincibility frames, death handling |
| 💎 Loot | Dynamic item drops with collection mechanics |


## 🎯 Planned Features
1. 🎒 Player Inventory System
2. 👿 Hostile NPCs
3. 🍖 NPC Hunger Mechanics
4. 🎭 NPC Personality System
5. 📊 NPC Population Management

## 🔄 Development Workflow
- Modular development approach
- Regular feature updates
- Comprehensive testing
- Community-driven improvements

---
*Made with ❤️ using Godot Engine*
