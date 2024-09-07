# Round-Robin Arbiter in Verilog

This repository contains a Verilog implementation of a round-robin arbiter with 8 channels. The arbiter utilizes one-hot encoding for the grant vector and incorporates a next grant precalculator to handle requests and priorities in a circular fashion. The system also features modules for converting one-hot encoding to decimal, calculating grants, and a testbench for verifying functionality.

## Overview

The arbiter is designed to manage multiple channels using a round-robin scheduling algorithm. It ensures that each channel gets a turn based on request priorities and handles cases where there are no active requests by defaulting to the first channel.

## Modules

### 1. **NGPRC (Next Grant Precalculator)**
- **Function:** Calculates the next grant based on the current grant and request priorities.
- **Description:** Determines the next channel to be granted access based on the current state and request priorities, cycling through channels as needed.

### 2. **grant_req_calc**
- **Function:** Evaluates grant requests and calculates the grants.
- **Description:** Uses the values from NGPRC along with the current requests and priorities to determine which channel should be granted access. Also handles cycle counting according to the assigned weights.

### 3. **RRB_MUX (Round-Robin MUX)**
- **Function:** Converts one-hot encoding to decimal encoding.
- **Description:** Takes the one-hot encoded grant vector and converts it to a decimal format, facilitating easier interpretation and handling within other modules.

### 4. **RRB_final (Top Module)**
- **Function:** Integrates NGPRC, grant_req_calc, and RRB_MUX.
- **Description:** Coordinates the interactions between the submodules and manages the overall functionality of the arbiter.

### 5. **tb_RRB_final (Testbench)**
- **Function:** Simulates various scenarios to verify the arbiter's functionality.
- **Description:** Tests the top module under different conditions, including single requests, multiple simultaneous requests, and edge cases such as no requests.


## Module Descriptions

- **NGPRC.v:** Contains the Verilog code for the next grant precalculator.
- **grant_req_calc.v:** Contains the Verilog code for the grant request calculator.
- **RRB_MUX.v:** Contains the Verilog code for the one-hot to decimal MUX.
- **RRB_final.v:** Contains the top-level module that integrates all components.
- **tb_RRB_final.v:** Contains the testbench code for simulating the top module.

![image](https://github.com/user-attachments/assets/44e08a5d-46ca-4834-ac4c-6fe1ec580252)

![image](https://github.com/user-attachments/assets/50d98e5c-6d27-4ebd-893c-f51d424cfed9)


