# UVM-Exploration

This repository contains my implementation of a full **Universal Verification Methodology (UVM)** testbench for a Greatest Common Divisor (GCD) module. This project focuses on building a reusable, modular verification environment from scratch, debugging faulty RTL, and closing functional coverage.

## **<u>Project Overview</u>**

Moving beyond standard SystemVerilog testbenches, this project utilizes the UVM library (CDNS-1.1d) to verify a DUT (Device Under Test) that computes the GCD of two operands. The goal was to construct a layered testbench architecture that separates stimulus generation from the checking logic, allowing for scalable and randomized testing.

## **<u>UVM Architecture</u>**

I architected the testbench using standard UVM components located in `src/uvm/`:

* **The Agent (`uvm_agent`):** Encapsulates the signal-level logic.
    * **Driver:** Pulls transaction objects (sequence items) and drives pin-level signals to the DUT.
    * **Monitor:** Passively observes the interface and broadcasts transactions to the scoreboard via analysis ports.
    * **Sequencer:** Arbitrates the flow of transaction items from the sequences to the driver.
* **The Environment (`uvm_env`):** The top-level container.
    * **Scoreboard:** The self-checking mechanism. It compares the DUT's output against a mathematical reference model to ensure data integrity.
* **Sequences:** I wrote a library of sequences extending from a base class to target specific scenarios (e.g., randomized inputs, corner cases, and directed tests).

## **<u>Debugging & Coverage</u>**

A key part of this project was validating a "faulty" RTL design provided by the team.

* **RTL Debugging:** Using waveform analysis in **SimVision**, I identified and fixed logic errors in the GCD state machine and protocol violations in the handshake signals.
* **Code Coverage:** I utilized **Cadence IMC** to analyze code coverage. By writing specific constraints and directed tests to hit edge cases (such as zero-value inputs or immediate resets), I achieved a **>96% coverage score**, ensuring the design was thoroughly exercised.

## **<u>Directory Structure</u>**

* `src/sv/rtl/`: Source code for the GCD module.
* `src/uvm/agent/`: Driver, Monitor, and Sequencer definitions.
* `src/uvm/env/`: Scoreboard and Environment wrapper.
* `src/uvm/sequences/`: Sequence items and test scenarios.
* `src/uvm/tests/`: Top-level UVM tests.
* `sim/behav/`: Simulation makefiles and scripts.

## **<u>Tools Used</u>**

SystemVerilog, UVM 1.1d, Cadence Xcelium (`xrun`), Cadence SimVision (Waveforms), Cadence IMC (Coverage).
