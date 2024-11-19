# EE2026 - Villager's Tales

Villager's Tales is a role-playing game developed as a course project for EE2026. Players take on the role of a villager and can perform various activities such as farming, fishing, and shopping, all displayed on dual OLED screens. The game utilises pushbuttons and switches for navigation and interaction, with a real-time inventory and balance display.

## Features

- **Farming:** Players can grow crops in multiple stages, including planting, watering, and harvesting. Two types of crops are available: wheat and pumpkins. Days progress when the character sleeps, and crops take two days to reach full growth.
- **Fishing:** Players can catch different fish types depending on the rod used. The fishing activity includes an animation sequence with a zoomed-in view, and a random fish generator determines the fish caught.
- **Shopping:** The shop allows players to buy and sell items, with a chat bubble prompt appearing when the player approaches an item. Buy and sell modes enable resource management to support other activities.
- **Inventory System:** The player's inventory and balance are displayed live on the left OLED, allowing players to monitor items and resources consistently.
- **Victory Condition:** Reaching a balance of over $9000 triggers a congratulatory message and a blinking victory screen.

## Controls

- **Movement:** Use `btnL`, `btnR`, `btnU`, and `btnD` to move the character around the map, with boundary restrictions to keep the player within set limits.
- **Interactions:** Press `btnC` to interact with items, including fishing, buying, and selling. Switches control item selection for actions like planting, watering, and harvesting.
- **Switches:** 
  - `SW[0]`: Equip watering can for crops
  - `SW[1]`: Plant wheat seeds
  - `SW[2]`: Plant pumpkin seeds
  - `SW[7:6]`: Select fishing rod type
  - `SW[15:8]`: Choose items to sell

## Gameplay Overview

1. **Starting the Game:** The game begins with a start menu. Press `btnC` to enter the farming view.
2. **Farming:** Navigate to the farm area and use the switches to plant, water, and harvest crops. Each plot is independent, allowing for multiple crops to grow simultaneously.
3. **Fishing:** Move to the fishing port on the beach and press `btnC` with bait and a fishing rod equipped. Different rods catch different fish types.
4. **Shopping:** Enter the shop from the farm by moving downwards. A chat bubble will appear when near an item, allowing players to buy or sell items by entering buy/sell mode.
5. **Winning the Game:** When the player's balance exceeds $9000, a victory frame appears with a blinking congratulatory message.

## Technical Details

- **Required Hardware:** The game requires **two OLED displays** and **one Basys3 board**.
- **Display:** The game uses two OLED displays – one for the main gameplay (connected to the JC port) and one for inventory and balance tracking (connected to the JXADC port).
- **Modules:** Each feature (farming, fishing, shopping) is developed in separate Verilog modules, allowing modularity and easy debugging.
- **Balance Display:** The player's balance is shown on a 7-segment display, cycling through each digit at 200Hz for a stable view.

## Team Members

- **Ong Zheng Kai** - Menu design, house design, character sleeping animation
- **Viswanathan Ravisankar** - Farming mechanics, art and sprite design, character movement
- **Yar Xin Ning** - Fishing mechanics, zoomed-in fishing animation, random fish generation
- **Ng Chee Fong** - Shop and shopkeeper design, buy/sell system, inventory display

## How to Play

1. **Clone the repository**:
   ```bash
   git clone https://github.com/EE2026-Villager-Tales/EE2026-Villager-Tales.git
2. **Set up the hardware**:
   - Connect **two OLED displays** to the **Basys3 FPGA board**:
     - One OLED to the **JC port** (for main gameplay).
     - The second OLED to the **JXADC port** (for inventory and balance tracking).

3. **Load the project**:
   - Open the project files in your FPGA development environment (e.g., Vivado).
   - Synthesize and implement the Verilog design.
   - Generate the bitstream file and program the Basys3 board.

4. **Start the game**:
   - After programming the FPGA board, the game starts with a menu screen.
   - Use `btnC` to enter the farming view and begin gameplay.

5. **Play the game**:
   - **Farming**: 
     - Navigate the farm using `btnL`, `btnR`, `btnU`, and `btnD`.
     - Use switches to plant (`SW[1]` for wheat, `SW[2]` for pumpkin) and water (`SW[0]` to equip the watering can).
     - Harvest crops when fully grown and earn money by selling them.
   - **Fishing**:
     - Move to the beach and equip a fishing rod (`SW[7:6]`).
     - Press `btnC` with bait equipped to catch fish.
     - Different rods catch different fish types.
   - **Shopping**:
     - Navigate to the shop by moving down from the farm.
     - Interact with items using `btnC` to buy or sell.
     - Use switches (`SW[15:8]`) to select items to sell.

6. **Win the game**:
   - Your objective is to reach a balance of $9000 or more.
   - Once achieved, a congratulatory victory screen will appear with a blinking animation.

7. **Refer to the User Guide**:
   - For detailed setup, gameplay tips, and troubleshooting, refer to the [User Guide](https://ee2026-villager-tales.github.io/EE2026-Villager-Tales/) included in the repository.
