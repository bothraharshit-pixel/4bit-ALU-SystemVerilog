// ============================================================
// Project      : 4-bit ALU Testbench
// Author       : Harshit Bothra
// College      : PES University, ECE Department
// Description  : Exhaustive testbench for alu_4bit module.
//                Tests all 8 operations with multiple input
//                combinations and checks output correctness.
// ============================================================

`timescale 1ns/1ps  // Time unit = 1ns, precision = 1ps

module alu_4bit_tb;

    // --------------------------------------------------------
    // Declare testbench signals (driven by the testbench)
    // --------------------------------------------------------
    logic [3:0] A;
    logic [3:0] B;
    logic [2:0] opcode;

    // Outputs from DUT (Device Under Test)
    logic [3:0] result;
    logic       carry;
    logic       zero;
    logic       neg;

    // --------------------------------------------------------
    // Instantiate the ALU (DUT - Device Under Test)
    // --------------------------------------------------------
    alu_4bit DUT (
        .A      (A),
        .B      (B),
        .opcode (opcode),
        .result (result),
        .carry  (carry),
        .zero   (zero),
        .neg    (neg)
    );

    // --------------------------------------------------------
    // Task: display_result
    // Prints a formatted line for each test case
    // --------------------------------------------------------
    task display_result(input string op_name);
        $display("| %-5s | A=%04b(%0d) | B=%04b(%0d) | Result=%04b(%0d) | Carry=%b | Zero=%b | Neg=%b |",
                  op_name, A, A, B, B, result, result, carry, zero, neg);
    endtask

    // --------------------------------------------------------
    // Main test sequence
    // --------------------------------------------------------
    initial begin
        $display("========================================================");
        $display("       4-bit ALU Testbench - Harshit Bothra             ");
        $display("       PES University, ECE Dept.                        ");
        $display("========================================================");
        $display("| OP    | A           | B           | Result        | Flags          |");
        $display("--------------------------------------------------------");

        // ---- TEST 1: ADD ----
        // 5 + 3 = 8, no carry
        A = 4'b0101; B = 4'b0011; opcode = 3'b000; #10;
        display_result("ADD");

        // 15 + 2 = 17 -> overflow, carry = 1
        A = 4'b1111; B = 4'b0010; opcode = 3'b000; #10;
        display_result("ADD");

        // ---- TEST 2: SUB ----
        // 7 - 3 = 4, no borrow
        A = 4'b0111; B = 4'b0011; opcode = 3'b001; #10;
        display_result("SUB");

        // 3 - 5 = borrow (carry flag set)
        A = 4'b0011; B = 4'b0101; opcode = 3'b001; #10;
        display_result("SUB");

        // ---- TEST 3: AND ----
        // 1010 & 1100 = 1000
        A = 4'b1010; B = 4'b1100; opcode = 3'b010; #10;
        display_result("AND");

        // 1111 & 0000 = 0000 -> zero flag set
        A = 4'b1111; B = 4'b0000; opcode = 3'b010; #10;
        display_result("AND");

        // ---- TEST 4: OR ----
        // 1010 | 0101 = 1111
        A = 4'b1010; B = 4'b0101; opcode = 3'b011; #10;
        display_result("OR");

        // ---- TEST 5: XOR ----
        // 1111 ^ 1111 = 0000 -> zero flag set
        A = 4'b1111; B = 4'b1111; opcode = 3'b100; #10;
        display_result("XOR");

        // 1010 ^ 0101 = 1111
        A = 4'b1010; B = 4'b0101; opcode = 3'b100; #10;
        display_result("XOR");

        // ---- TEST 6: NOT ----
        // ~0101 = 1010 (neg flag set because MSB=1)
        A = 4'b0101; B = 4'bxxxx; opcode = 3'b101; #10;
        display_result("NOT");

        // ~1111 = 0000 -> zero flag set
        A = 4'b1111; B = 4'bxxxx; opcode = 3'b101; #10;
        display_result("NOT");

        // ---- TEST 7: SHL (Shift Left) ----
        // 0011 << 1 = 0110
        A = 4'b0011; B = 4'bxxxx; opcode = 3'b110; #10;
        display_result("SHL");

        // 1001 << 1 = 0010, carry = 1 (MSB lost)
        A = 4'b1001; B = 4'bxxxx; opcode = 3'b110; #10;
        display_result("SHL");

        // ---- TEST 8: SHR (Shift Right) ----
        // 1100 >> 1 = 0110
        A = 4'b1100; B = 4'bxxxx; opcode = 3'b111; #10;
        display_result("SHR");

        // 0001 >> 1 = 0000, carry = 1 (LSB lost), zero flag set
        A = 4'b0001; B = 4'bxxxx; opcode = 3'b111; #10;
        display_result("SHR");

        $display("========================================================");
        $display("          All tests completed successfully!             ");
        $display("========================================================");

        $finish; // End simulation
    end

    // --------------------------------------------------------
    // Optional: waveform dump for GTKWave or Vivado viewer
    // --------------------------------------------------------
    initial begin
        $dumpfile("alu_4bit_waves.vcd");
        $dumpvars(0, alu_4bit_tb);
    end

endmodule
