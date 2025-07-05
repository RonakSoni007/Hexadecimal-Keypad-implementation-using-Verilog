# Hexadecimal-Keypad-implementation-using-Verilog

This project implements a **4x4 matrix-based Hex Keypad Interface** in Verilog HDL. The design detects and decodes keypresses from a physical or simulated keypad and outputs the corresponding hexadecimal value (`0–F`) with a valid signal flag.

---

##  Modules

### 1. `row_signal.v`
- **Inputs**: 16-bit `Key` matrix, 4-bit `col`
- **Output**: 4-bit `row`
- **Function**: Given the current active column and the 4x4 key matrix, this module determines which row line is active (i.e., which key has been pressed).

### 2. `synchronizer.v`
- **Inputs**: 4-bit `row`, `clock`, `reset`
- **Output**: `S_Row` (single-bit signal)
- **Function**: Synchronizes and debounces the `row` signal. Converts asynchronous row activity to a stable, clocked pulse `S_Row` that indicates a keypress occurred.

### 3. `hex_keypad.v`
- **Inputs**: `row`, `S_Row`, `clock`, `reset`
- **Outputs**: 4-bit `code` (hex value), `valid`, 4-bit `col`
- **Function**: Main controller. It scans columns sequentially, checks row activity using the synchronizer, and maps the `(row, col)` pair to a specific hexadecimal code.

### 4. `hex_keypad_tb.v`
- **Function**: A testbench to simulate keypress behavior. Randomly simulates keys from 0 to F, and prints detected values with timestamps.

---

##  How It Works

1. **Key Scanning**: Columns are scanned one at a time (`col`).
2. **Row Detection**: The corresponding `row` signal goes high when a key is pressed.
3. **Synchronization**: `S_Row` is generated to cleanly indicate that a key was pressed.
4. **Decoding**: The `(row, col)` pair is mapped to its respective hexadecimal code (`code`).
5. **Validation**: `valid` is raised for one clock cycle during a successful keypress.

---

## 🎯 Features

-  Accurate 4x4 keypad scanning
-  Hexadecimal output from 0 to F
-  Clean key detection using synchronization
-  FSM-based design for robust control
-  Testbench for simulation

---

## 🧪 Simulation Output

Sample log from testbench:

