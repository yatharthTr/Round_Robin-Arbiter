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

## Getting Started

### Prerequisites

- Verilog simulator (e.g., ModelSim, XSIM)
- A compatible development environment (e.g., Vivado, Quartus)

### Running the Simulation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/round-robin-arbiter.git
    cd round-robin-arbiter
    ```

2. Compile the Verilog files:
    ```bash
    # Example for ModelSim
    vlog NGPRC.v grant_req_calc.v RRB_MUX.v RRB_final.v tb_RRB_final.v
    ```

3. Run the simulation:
    ```bash
    # Example for ModelSim
    vsim tb_RRB_final
    ```

4. Observe the simulation results and verify that the arbiter behaves as expected.

## Module Descriptions

- **NGPRC.v:** Contains the Verilog code for the next grant precalculator.
- **grant_req_calc.v:** Contains the Verilog code for the grant request calculator.
- **RRB_MUX.v:** Contains the Verilog code for the one-hot to decimal MUX.
- **RRB_final.v:** Contains the top-level module that integrates all components.
- **tb_RRB_final.v:** Contains the testbench code for simulating the top module.

## Contributing

If you would like to contribute to this project, please fork the repository and create a pull request with your proposed changes. Ensure that any new code or modifications are thoroughly tested.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or comments, please reach out to [your email](mailto:your.email@example.com).

---

**Note:** Replace `yourusername` with your actual GitHub username and provide your actual email address in the contact section.
