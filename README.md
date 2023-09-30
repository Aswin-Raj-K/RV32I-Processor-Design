# NYU-6463-RV32I Processor Design

## 1. Complete Design Datapath

![alt text](Processor_Data_Path.png)

This section provides an overview and image representation of the complete datapath of the designed RISC V R32I processor. Major components, including Program Counter (PC), Control Unit (CU), Instruction Memory (IM), Data Memory (DM), ALU, and Register File (Reg File), are described.

## 2. Individual Components

In this section, each major component of the processor is individually described.

### 2.1 Program Counter

Description of the Program Counter, a 32-bit register containing the address of the next instruction to be executed.

### 2.2 ALU

Description of the ALU (Arithmetic Logic Unit), responsible for performing various operations like addition, subtraction, comparison, etc.

### 2.3 Register File

Description of the Register File, containing 32 32-bit registers used for temporary data storage.

### 2.4 Control Unit

Description of the Control Unit, responsible for generating control signals based on the instruction being executed.

### 2.5 Data Extension

Description of Data Extension, which extends data with the most significant bit for arithmetic operations.

### 2.6 Immediate Extension

Description of Immediate Extension, which extends data with the most significant bit for specific opcode operations.

### 2.7 Instruction Decoder

Description of the Instruction Decoder, responsible for converting 32-bit instructions into control signals.

### 2.8 Instruction Memory

Description of the Instruction Memory, used to store instructions for the processor.

### 2.9 Data Memory

Description of the Data Memory, used for storing data that the processor operates on.

## 3. Finite State Machine

This section explains the role of the Finite State Machine (FSM) in coordinating the processor's operation.

## 4. The Whole Processor

An image and description of the complete processor's datapath are provided in this section.

## 5. Design Analysis

This section analyzes various aspects of the processor's design, including performance, area, timing, and resource utilization.

### 5.1 Performance Analysis

Explanation of performance metrics like clock frequency, instructions per second, and CPI (cycles per instruction).

### 5.2 Area Analysis

Analysis of the processor's gate count, power consumption, and physical size.

### 5.3 Timing Analysis

Summary of the timing analysis results.

### 5.4 Resource Utilization

Details about resource utilization, including the number of block RAMs used and bonded pins.

## 6. Testing

This section provides details about the testing procedures used to validate the processor's functionality.

### 6.1 Unit Testing

Explanation of unit testing for different instructions.

### 6.2 High-Level Testing

Testing procedures for high-level functions, including Input-Output testing, Fibonacci series generation, and RC5 encryption.

#### 6.2.1 Input Output Testing

Explanation and results of input-output testing.

#### 6.2.2 Generating Fibonacci Series

Explanation and results of Fibonacci series generation testing.

#### 6.2.3 RC5 Encryption

Explanation and results of RC5 encryption testing.

## 7. Support For C

Information on setting up GCC compiler support for C programs on the processor.

## 8. Future Scope

This section discusses possible extensions and improvements for the processor design.

## 9. Conclusion

A summary of the project's achievements and findings.

