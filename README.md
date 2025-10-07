# Smart Traffic Light (FPGA – DE10-Lite)

This project implements a **Verilog-based smart traffic light controller** on the **DE10-Lite FPGA board**. It simulates real-world intersection logic using finite state machines (FSMs) to control red, yellow, and green lights for vehicles and pedestrians.

---

## Overview
The system cycles through traffic light states with timed intervals and includes a pedestrian push-button for safe crossings. Timing is managed through clock division using the board’s 50 MHz clock signal.

**Main objectives:**
- Apply digital design concepts using Verilog HDL  
- Demonstrate timing, control, and state transitions  
- Simulate smart infrastructure logic (transportation systems)

---

## Features
- 3-phase traffic signal (Red, Yellow, Green)  
- Pedestrian crossing control (Walk / Don’t Walk)  
- Adjustable timing using clock dividers  
- Reset button for emergency stop or system restart  
- Designed for DE10-Lite FPGA (Intel MAX 10)

---

## Tools and Technologies
- **Hardware:** Terasic DE10-Lite (MAX 10 FPGA)  
- **Software:** Intel Quartus Prime Lite Edition  
- **Language:** Verilog HDL  
- **Clock:** 50 MHz onboard oscillator  

---

## Pin Assignments
| Signal | FPGA Pin | Component |
|--------|-----------|------------|
| `clk_50` | PIN_R8 | Onboard 50 MHz clock |
| `rst_n` | PIN_P11 | Push button KEY[0] |
| `ped_btn` | PIN_N12 | Push button KEY[1] |
| `led_red` | PIN_A8 | LEDR[0] |
| `led_yellow` | PIN_B8 | LEDR[1] |
| `led_green` | PIN_C8 | LEDR[2] |

*(Update pin numbers based on your actual setup.)*

---

## File Structure
```
/rtl              # Verilog source files
    top.v         # Top-level design
    fsm.v         # State machine logic
    clk_div.v     # Clock divider module
/simulation       # Testbench files
/docs             # Photos, block diagram, notes
constraints.sdc   # Timing constraints
README.md         # Project documentation
```

---

##  How to Run
1. Open the project in **Intel Quartus Prime Lite**.  
2. Set the target device to **Intel MAX 10 (10M50DAF484C7G)**.  
3. Add all Verilog files from `/rtl`.  
4. Assign pins in **Pin Planner** according to the table above.  
5. Compile the project and program the FPGA using the USB-Blaster.


---

## Author
**Matthew Abdalla**  
Electrical Engineering Student | Interested in Power Systems, Circuit Design & Automation  





