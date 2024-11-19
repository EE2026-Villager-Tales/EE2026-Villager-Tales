# **Villager's Tales: User Guide**

**EE2026 Project**  
Team S1_16
- **Ong Zheng Kai**
- **Viswanathan Ravisankar**
- **Yar Xin Ning**
- **Ng Chee Fong**

---

## **Overview**

*Villager’s Tales* is an engaging role-playing game where players assume the role of a villager. Activities such as sleeping, farming, fishing, and shopping are performed on dual OLED displays:
- **Right OLED**: Displays the main gameplay activities.
- **Left OLED**: Displays the player's inventory.

The shop module enables purchasing items necessary for farming and fishing. The game's main controls use **pushbuttons** and **switches**, providing seamless movement and interaction. Achieve a balance of **$9000** to win the game, displayed with a victory frame!

---

## **Gameplay Features**

### **Menu and Navigation**
- **Initial Menu**: Upon game launch, a start menu appears. Press **BTNC** to begin and transition to the farming view.
- **Navigation**: Use the **BTNU**, **BTND**, **BTNL**, and **BTNR** buttons to move between locations:
    - **North**: House
    - **South**: Shop
    - **Right**: Beach
- Movement boundaries prevent out-of-bounds navigation.

---

### **Farming Module**
1. **Crops**: Two types - Wheat and Pumpkins.
2. **Stages**:
    - **Seed**
    - **Half-Grown**
    - **Fully-Grown**
3. **Steps**:
    - **Planting Seeds**: Toggle SW[1] for wheat or SW[2] for pumpkins and press **BTNC**.
    - **Watering**: Toggle SW[0] to equip a watering can and hold **BTNC** over a crop for 1 second.
    - **Harvesting**: Use **BTNC** without toggling SW switches.

Each crop grows over **2 days**, and players can manage up to **15 plots** simultaneously. Days progress by sleeping in the house.

---

### **Fishing Module**
- **Fishing Zones**: Accessible at the wooden port.
- **Fishing Process**:
    1. Equip a rod using SW[7:6]:
        - SW[7:6] = 1: Basic rod (Carps)
        - SW[7:6] = 2: Good rod (Carps, Bluetangs)
        - SW[7:6] = 3: Super rod (Carps, Bluetangs, Kois)
    2. Start fishing by pressing **BTNC** at the port.
    3. Catch fish or miss bites, determined by a random number generator.
- **Animation**: A zoomed-in sequence of throwing bait, casting the rod, and reeling in the fish.

---

### **Shop and Inventory**
#### **Shop**
- **Location**: Accessible by moving south from the farm.
- **Buying Items**:
    1. Approach an item in the shop (e.g., seeds or bait).
    2. A **chat bubble** appears.
    3. Press **BTNC** to enter buy mode:
        - Press **BTNL** to confirm purchase.
        - Press **BTNR** to cancel.
    - **Prices**:
        - Bait: $200
        - Wheat Seeds: $300
        - Pumpkin Seeds: $400
- **Selling Items**:
    1. Face the shopkeeper and press **BTNC** to enter sell mode.
    2. Use SW[15:8] to select items to sell (highlighted in pink).
    3. Press **BTNL** to confirm sale or **BTNR** to cancel.
    - **Prices**:
        - Carp: $300
        - Bluetang: $400
        - Koi: $1000
        - Wheat: $400
        - Pumpkin: $600

#### **Inventory**
- Always displayed on the **left OLED (JXADC)**.
- **Balance**: Displayed on the 7-segment display.
- Items and quantities are dynamically updated based on player actions.

---

## **Victory Condition**
Achieve a balance of **$9000** to display the **Winning Frame** with a blinking "Congratulations" message at 2Hz. Press **BTNC** to dismiss and continue gameplay.

---

## **References**
- Picture2Pixel: [GitHub Repository](https://github.com/gu0y1/picture2pixel)

---

## **Contributors**
- **Ong Zheng Kai**: Menu design, main house design, and character sleep animations.
- **Viswanathan Ravisankar**: Farming module, character sprite design, and movements.
- **Yar Xin Ning**: Fishing module, zoomed-in animations, and random fish generation.
- **Ng Chee Fong**: Shopkeeper design, inventory integration, and buy/sell system.

---
