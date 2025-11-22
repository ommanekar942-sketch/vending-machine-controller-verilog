# Vending Machine Controller (Verilog HDL)

This project implements a vending machine controller using Verilog HDL.  
The design handles product selection, coin insertion, cancellation,  
price checking, change return, and product dispensing based on a  
simple finite state machine (FSM).

The repository includes:
- Verilog RTL 
- Testbench 
- VCD waveform output and screenshots

---

##  Design Overview

The vending machine supports five products, each with a different price:

- Wafers → 10
- Toffees → 7
- Water Bottle → 18
- Cold Drink → 30
- Biscuits → 22

The controller uses six states:

| State | Description              |
|--------|--------------------------|
| start | Initialize machine       |
| select_product | Read product selection |
| insert_the_coin | Wait for coin input or cancel |
| Cancel | Return refund           |
| check_the_statements | Compare price vs. coins |
| done | Dispense item and reset  |

The main outputs controlled by the FSM are:
- dispense — delivers the selected product  
- refund — returns coins when cancel is pressed  
- change — remaining balance after purchase  

---

##  Testbench Behavior

The testbench provides:
- A 5 ns clock toggle  
- Reset sequence  
- A simulated purchase sequence  
- `$monitor` for real-time display of signals  
- `$dumpfile` and `$dumpvars` for waveform output

Inputs included in the testbench:
- Product select  
- Coin insertion  
- Cancel signal  
- Reset and clock  

Example setup inside the testbench:

```verilog
$dumpfile("vending_machine.vcd");
$dumpvars(0, vending_machine_tb);

/*-------------------------------------------------------------------------------------------------------*/

FSM Summary

The controller operates as follows:

Machine resets → goes to start

User selects a product → select_product

User inserts coins → insert_the_coin

If cancel → Cancel

If enough coins inserted → check_the_statements

If coins match or exceed price → give change → done

Product dispensed → machine returns to start
