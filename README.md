# NYU-6463-RV32I Processor Design

Welcome to the NYU-6463-RV32I Processor Design project README. This document provides a comprehensive overview of our RISC V R32I processor design project.

## 1. Complete Design Datapath

![Processor Data Path](Processor_Data_Path.png)

A visual representation of the complete datapath of the designed RISC V R32I processor is provided here. This includes major components such as the Program Counter (PC), Control Unit (CU), Instruction Memory (IM), Data Memory (DM), Arithmetic Logic Unit (ALU), and Register File (Reg File).

## 3. Finite State Machine

## Finite State Machine (FSM) in Processor Design

In processor design, a Finite State Machine (FSM) plays a critical role in modeling the control logic responsible for coordinating various processor components such as the instruction fetch unit, decoder, and execution unit. It defines a series of steps for the orderly execution of instructions, encompassing stages like instruction fetching, decoding, and execution, each governed by specific conditions.

### Key Characteristics of the FSM:

- **States**: The FSM operates with a set of 8 distinct states, each representing a specific phase in the processor's operation. These states include fundamental stages like instruction fetching, decoding, and execution.

- **Inputs**: Inputs to the FSM are sourced from various components, such as the instruction memory and register files. These inputs influence the behavior of the processor and determine state transitions within the FSM.

- **Outputs**: One of the primary functions of the FSM is to generate outputs that control the behavior of various processor components. These outputs might include information such as the address of the next instruction to be executed, decoder signals for instruction interpretation, or data read from the register file.

- **Transitions**: Transitions between states are orchestrated by the FSM based on a combination of inputs and the current state. For example, when an instruction is fetched successfully, the FSM transitions from the "fetch" state to the "decode" state.

- **Next State Logic**: The determination of the next state is a crucial aspect of FSM design. This is achieved through the use of logic circuits, which can include multiplexers, decoders, or programmable logic elements like lookup tables and state machines.

The FSM serves as the backbone of the processor's control unit, ensuring that instructions are executed in a well-defined sequence and that the necessary data and signals are routed to the appropriate components at each stage of execution.


## 4. The Whole Processor

Here, we provide an image and a detailed description of the complete processor's datapath. This section gives a holistic view of how all the components work together to execute instructions.

## 5. Design Analysis

This section presents a comprehensive analysis of various aspects of our processor's design, including its performance, area requirements, timing characteristics, and resource utilization.

### 5.1 Performance Analysis

We explain the performance metrics used to evaluate our processor, such as clock frequency, instructions per second, and CPI (cycles per instruction). We also provide performance benchmark results.

### 5.2 Area Analysis

An analysis of the processor's gate count, power consumption, and physical size is presented in this section. We discuss the impact of the design on hardware resources.

### 5.3 Timing Analysis

A summary of the timing analysis results, including critical paths and clock distribution, is provided to assess the processor's timing performance.

### 5.4 Resource Utilization

We provide detailed information about the resource utilization in our processor, including the number of block RAMs used and the bonded pins.

## 6. Testing

This section offers insights into the testing procedures we employed to validate the functionality of our processor.

### 6.1 Unit Testing

We explain our approach to unit testing for different instructions, ensuring that individual components perform as expected.

### 6.2 High-Level Testing

Testing procedures for high-level functions are described, including Input-Output testing, Fibonacci series generation, and RC5 encryption.

#### 6.2.1 Input Output Testing

We provide an explanation of input-output testing procedures and share the results obtained during testing.

#### 6.2.2 Generating Fibonacci Series

Details about the testing of our processor's ability to generate Fibonacci series, along with test results, are presented.

#### 6.2.3 RC5 Encryption

We explain the RC5 encryption testing process and share the outcomes of our encryption tests.

## 7. Support For C

This section contains information on setting up GCC compiler support for C programs on our processor, making it more versatile and adaptable for various applications.

## 8. Future Scope

We discuss potential extensions and improvements for our processor design, outlining directions for future development and enhancement.

## 9. Conclusion

In the concluding section, we summarize the project's achievements, findings, and the overall success of our RISC V R32I processor design.

Thank you for visiting our project README. For additional resources, including project files, videos, and related materials, please refer to the [Resources](#resources) section.
