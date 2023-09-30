![alt text](Processor_Data_Path.png)

# NYU-6463-RV32I Processor Design Project

**Authors:**
- Aswin Raj K (N121801008, ar7997)
- Anish (N12499733, am12553)
- Devashish (N19620681, dg4015)

**Department:** Department of Electrical Engineering

*Note: Zoom in to see the plots clearly.*

## Contents

1. [Complete Design Datapath](#complete-design-datapath)
2. [Individual Components](#individual-components)
   - 2.1 [Program Counter](#program-counter)
   - 2.2 [ALU](#alu)
   - 2.3 [Register File](#register-file)
   - 2.4 [Control Unit](#control-unit)
   - 2.5 [Data Extension](#data-extension)
   - 2.6 [Immediate Extension](#immediate-extension)
   - 2.7 [Instruction Decoder](#instruction-decoder)
   - 2.8 [Instruction Memory](#instruction-memory)
   - 2.9 [Data Memory](#data-memory)
3. [Finite State Machine](#finite-state-machine)
4. [The Whole Processor](#the-whole-processor)
5. [Design Analysis](#design-analysis)
   - 5.1 [Performance Analysis](#performance-analysis)
   - 5.2 [Area Analysis](#area-analysis)
   - 5.3 [Timing Analysis](#timing-analysis)
   - 5.4 [Resource Utilization](#resource-utilization)
6. [Testing](#testing)
   - 6.1 [Unit Testing](#unit-testing)
   - 6.2 [High-Level Testing](#high-level-testing)
      - 6.2.1 [Input Output Testing](#input-output-testing)
      - 6.2.2 [Generating Fibonacci Series](#generating-fibonacci-series)
      - 6.2.3 [RC5 Encryption](#rc5-encryption)
7. [Support For C](#support-for-c)
8. [Future Scope](#future-scope)
9. [Conclusion](#conclusion)
10. [Resources](#resources)

## 1. Complete Design Datapath

![Datapath Image](url_to_image)

Description of the complete datapath of the designed RISC V R32I processor. Major components include Program Counter (PC), Control Unit (CU), Instruction Memory (IM), Data Memory (DM), ALU, and Register File (Reg File).

## 2. Individual Components

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

Explanation of the Finite State Machine (FSM) used to coordinate the processor's operation.

## 4. The Whole Processor

Image and description of the complete processor's datapath.

## 5. Design Analysis

Analysis of the processor's design, including performance, area, timing, and resource utilization.

### 5.1 Performance Analysis

Explanation of performance metrics like clock frequency, instructions per second, and CPI.

### 5.2 Area Analysis

Analysis of the processor's gate count, power consumption, and physical size.

### 5.3 Timing Analysis

Summary of the timing analysis results.

### 5.4 Resource Utilization

Resource utilization details, including the number of block RAMs used and bonded pins.

## 6. Testing

Explanation of testing procedures.

### 6.1 Unit Testing

Details about unit testing for different instructions.

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

Possible extensions and improvements for the processor design.

## 9. Conclusion

Summary of the project's achievements and findings.

## 10. Resources

Links to project files, videos, or other relevant resources.

