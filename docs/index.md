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

![image](https://github.com/user-attachments/assets/8521e41d-906c-44a6-adb5-4f67f3a2c573)

---

## **Gameplay Features**

### **Menu and Navigation**
- **Initial Menu**: Upon game launch, a start menu appears. Press **BTNC** to begin and transition to the farming view.
  
  <img src= "https://github.com/user-attachments/assets/ea280107-01bf-443c-adf6-a83054ab527d" alt="Image" height="100">

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

<img src= "https://github.com/user-attachments/assets/d837a3ec-4db8-4600-ba40-de375396e69a" alt="Image" height="100">


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

<img src="https://github.com/user-attachments/assets/a30c5007-cfad-4317-a6b7-b6b4b874f779" alt="Image 1" height="100">

<img src="https://github.com/user-attachments/assets/af8857c8-7ddc-4b6b-b8b7-27f78ec7dfec" alt="Image 2" height="100">

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
          
    <img src="https://github.com/user-attachments/assets/4fff0b35-15d5-4f2a-8fb9-7cc7faed1f38" alt="Image 4" height="100">

#### **Inventory**
- Always displayed on the **left OLED (JXADC)**.
- **Balance**: Displayed on the 7-segment display.
- Items and quantities are dynamically updated based on player actions.
  
    <img src="https://github.com/user-attachments/assets/760ed4cd-3c11-4757-a039-885b9e97035f" alt="Image 5" height="100"> <img src="https://github.com/user-attachments/assets/1836db96-5658-4702-b2f3-2b2c74ce4524" alt="Image 6" height="100"> <img src="https://github.com/user-attachments/assets/e8917c5d-c0d2-4442-8d8a-264c60b1431a" alt="Image 7" height="100">
---

## **Victory Condition**
Achieve a balance of **$9000** to display the **Winning Frame** with a blinking "Congratulations" message at 2Hz. Press **BTNC** to dismiss and continue gameplay.

---

## **References**
- Picture2Pixel: [GitHub Repository](https://github.com/gu0y1/picture2pixel)

---

## **Contributors**
- **[Ong Zheng Kai](https://github.com/itsZK12)**: Menu design, main house design, and character sleep animations.
- **[Viswanathan Ravisankar](https://github.com/ravi-viswa105)**: Farming module, character sprite design, and movements.
- **[Yar Xin Ning](https://github.com/yarxinning29)**: Fishing module, zoomed-in animations, and random fish generation.
- **[Ng Chee Fong](https://github.com/NCF3535)**: Shopkeeper design, inventory integration, and buy/sell system.

---
