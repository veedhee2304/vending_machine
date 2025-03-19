 🛒 **Vending Machine with 4 Items - Verilog Implementation**

---

### 📄 **README**

#### ✅ **Description**
This is a Verilog-based implementation of a vending machine that dispenses 4 items: Chocolate, Chips, Cold Drink, and Ice Cream. The machine accepts coin input, verifies the item selection, dispenses the selected item, and returns the appropriate change. 

---

### 🔧 **Features**
- Supports 4 items with their respective prices:
  - **Chocolate:** ₹5  
  - **Chips:** ₹10  
  - **Cold Drink:** ₹20  
  - **Ice Cream:** ₹50  
- Handles proper change calculation.  
- Displays the item dispensed using a 4-bit signal.  
- Returns change if the coin input is greater than the item price.  
- Uses **Finite State Machine (FSM)** for systematic control flow.  

---

### 🛠️ **Module Overview**

- **Inputs:**
  - `clk`: Clock signal for synchronous operations.
  - `rst`: Reset signal to initialize the machine.
  - `coin_in`: 8-bit input representing the amount inserted in ₹ (0-255 range).
  - `select`: 2-bit item selection signal.
    - `00` → Chocolate  
    - `01` → Chips  
    - `10` → Cold Drink  
    - `11` → Ice Cream  

- **Outputs:**
  - `out`: Dispense signal (1 → item dispensed, 0 → no dispense).
  - `change`: 8-bit change output in ₹.
  - `item_dispensed`: 4-bit signal indicating the item:
    - `0001` → Chocolate  
    - `0010` → Chips  
    - `0100` → Cold Drink  
    - `1000` → Ice Cream  

---

### 🔑 **FSM States**

| State           | Description                     |
|-----------------|---------------------------------|
| `IDLE`          | Waits for coin input.           |
| `PROCESS`       | Checks if enough coins are inserted for the selected item. |
| `DISPENSE`      | Dispenses the selected item.    |
| `RETURN_CHANGE` | Returns the change and goes back to IDLE. |

---

### 📊 **FSM Diagram**
Here’s the FSM diagram representing the vending machine's operation:

```
            +---------+
    Reset   |         |
   +------->|  IDLE   |
   |        |         |
   |        +---------+
   |             |
   |   Coin > 0   | 
   |------------- |
   |              v
   |        +-----------+
   |        |  PROCESS   |
   |        +-----------+
   |              |
   |   Enough Coins? 
   |     /    \
   |    No     Yes
   |    |      |
   |    |      v
   |    |   +-----------+
   |    |   | DISPENSE  |
   |    |   +-----------+
   |    |      |
   |    |      v
   |    |   +--------------+
   |    |   | RETURN_CHANGE |
   |    |   +--------------+
   |    |      |
   |    |      v
   |    +------+
   |           |
   |    Go to IDLE
   |           |
   +-----------+
```

---

### ⚙️ **ASM (Algorithmic State Machine) Diagram**
The ASM diagram illustrates the step-by-step operation of the vending machine.

```
       +----------------+
       |    IDLE         |
       |-----------------|
       | Coin = 0        |
       +-----------------+
                 |
         Coin > 0 |
                 v
       +----------------+
       |   PROCESS      |
       |----------------|
       | Check item cost |
       +-----------------+
          |           |
     Enough     Not Enough
      |              |
      v              |
+----------------+   |
|   DISPENSE     |   |
|----------------|   |
| Dispense item  |   |
+----------------+   |
      |              |
      v              |
+----------------+   |
| RETURN_CHANGE  |   |
|----------------|   |
| Return change  |   |
+----------------+   |
      |              |
      v              |
+----------------+   |
|      IDLE       |<--+
+----------------+
```

---

### 🚀 **How to Simulate**
1. **Run the Simulation**:  
   - Load the Verilog module in ModelSim, Xilinx Vivado, or any compatible simulation tool.  
   - Apply clock (`clk`) and reset (`rst`) signals.  
   - Provide the `coin_in` and `select` inputs.  
   - Observe the `out`, `change`, and `item_dispensed` outputs.  

2. **Test Cases:**
   - Insert ₹10 and select `01` (Chips) → Item dispensed with no change.  
   - Insert ₹50 and select `00` (Chocolate) → Item dispensed with ₹45 change.  
   - Insert ₹20 and select `11` (Ice Cream) → No dispense due to insufficient coins.  

---

### 🔥 **Improvements and Scalability**
- Easily extendable to support more items by adding new parameters and states.  
- Can include multi-coin validation and real-time coin acceptance.  
- Possible expansion to handle invalid or incorrect selections gracefully.  

---

✅ **Author:** Veedhee Channey  
✅ **Date:** March 2025  
✅ **Version:** 1.0
