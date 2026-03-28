# 4-bit ALU in SystemVerilog

**Author:** Harshit Bothra  
**Institution:** PES University, ECE Department  
**Year:** 2nd Year  
**Tools:** SystemVerilog, ModelSim / Xilinx Vivado

---

## Project Overview

This project implements a fully functional **4-bit Arithmetic Logic Unit (ALU)** in SystemVerilog. The ALU supports 8 operations selected via a 3-bit opcode, along with status flags (carry, zero, negative) that reflect the result of each operation.

This type of ALU forms the core of every CPU and GPU — including those designed by Nvidia — making it a foundational hardware design project.

---

## Supported Operations

| Opcode | Operation | Description                     |
|--------|-----------|----------------------------------|
| 000    | ADD       | A + B (with carry out)          |
| 001    | SUB       | A - B (with borrow flag)        |
| 010    | AND       | A & B (bitwise AND)             |
| 011    | OR        | A \| B (bitwise OR)             |
| 100    | XOR       | A ^ B (bitwise XOR)             |
| 101    | NOT       | ~A (bitwise NOT, B ignored)     |
| 110    | SHL       | A << 1 (logical shift left)     |
| 111    | SHR       | A >> 1 (logical shift right)    |

---

## Status Flags

| Flag  | Description                                      |
|-------|--------------------------------------------------|
| carry | Set when addition overflows or shift loses a bit |
| zero  | Set when result equals 0000                      |
| neg   | Set when MSB of result is 1 (negative in 2's complement) |

---

## File Structure

```
alu_4bit/
├── alu_4bit.sv       # Main ALU design module
├── alu_4bit_tb.sv    # Testbench with exhaustive test cases
└── README.md         # Project documentation
```

---

## How to Run

### Using ModelSim
```bash
vlog alu_4bit.sv alu_4bit_tb.sv
vsim alu_4bit_tb
run -all
```

### Using Vivado (Simulation)
1. Create a new project → Add `alu_4bit.sv` as design source
2. Add `alu_4bit_tb.sv` as simulation source
3. Run Behavioral Simulation → observe waveforms

### View Waveforms (GTKWave)
```bash
vvp alu_4bit_tb
gtkwave alu_4bit_waves.vcd
```

---

## Sample Output

```
========================================================
       4-bit ALU Testbench - Harshit Bothra
       PES University, ECE Dept.
========================================================
| ADD   | A=0101(5)  | B=0011(3)  | Result=1000(8)  | Carry=0 | Zero=0 | Neg=1 |
| ADD   | A=1111(15) | B=0010(2)  | Result=0001(1)  | Carry=1 | Zero=0 | Neg=0 |
| SUB   | A=0111(7)  | B=0011(3)  | Result=0100(4)  | Carry=0 | Zero=0 | Neg=0 |
| AND   | A=1111(15) | B=0000(0)  | Result=0000(0)  | Carry=0 | Zero=1 | Neg=0 |
| XOR   | A=1111(15) | B=1111(15) | Result=0000(0)  | Carry=0 | Zero=1 | Neg=0 |
| NOT   | A=1111(15) | B=xxxx     | Result=0000(0)  | Carry=0 | Zero=1 | Neg=0 |
========================================================
          All tests completed successfully!
========================================================

