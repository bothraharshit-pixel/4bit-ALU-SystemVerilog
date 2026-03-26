// ============================================================
// Project      : 4-bit Arithmetic Logic Unit (ALU)
// Author       : Harshit Bothra
// College      : PES University, ECE Department
// Tool         : ModelSim / Xilinx Vivado
// Description  : A fully functional 4-bit ALU that supports
//                arithmetic and logic operations using
//                a 3-bit opcode selector.
// ============================================================

module alu_4bit (
    input  logic [3:0] A,       // 4-bit operand A
    input  logic [3:0] B,       // 4-bit operand B
    input  logic [2:0] opcode,  // 3-bit operation selector
    output logic [3:0] result,  // 4-bit ALU output
    output logic       carry,   // Carry/borrow flag
    output logic       zero,    // Zero flag (result == 0)
    output logic       neg      // Negative flag (MSB of result)
);

    // Internal 5-bit wire to capture carry out from arithmetic ops
    logic [4:0] temp;

    // --------------------------------------------------------
    // ALU Operation Encoding (opcode table):
    //   000 -> ADD  : result = A + B
    //   001 -> SUB  : result = A - B
    //   010 -> AND  : result = A & B  (bitwise)
    //   011 -> OR   : result = A | B  (bitwise)
    //   100 -> XOR  : result = A ^ B  (bitwise)
    //   101 -> NOT  : result = ~A     (bitwise NOT of A)
    //   110 -> SHL  : result = A << 1 (shift left by 1)
    //   111 -> SHR  : result = A >> 1 (shift right by 1)
    // --------------------------------------------------------

    always_comb begin
        // Default values to avoid latches
        temp   = 5'b0;
        carry  = 1'b0;

        case (opcode)
            3'b000: begin
                // ADD: Add A and B, capture carry in bit[4]
                temp   = {1'b0, A} + {1'b0, B};
                result = temp[3:0];
                carry  = temp[4];
            end

            3'b001: begin
                // SUB: Subtract B from A using 2's complement
                // If A < B, carry (borrow) flag is set
                temp   = {1'b0, A} - {1'b0, B};
                result = temp[3:0];
                carry  = temp[4]; // borrow flag
            end

            3'b010: begin
                // AND: Bitwise AND - used in masking operations
                result = A & B;
            end

            3'b011: begin
                // OR: Bitwise OR - used in setting bits
                result = A | B;
            end

            3'b100: begin
                // XOR: Bitwise XOR - used in parity and toggling bits
                result = A ^ B;
            end

            3'b101: begin
                // NOT: Bitwise complement of A (B is ignored)
                result = ~A;
            end

            3'b110: begin
                // SHL: Logical Shift Left by 1 (multiply by 2)
                // MSB is lost; carry captures it
                result = A << 1;
                carry  = A[3]; // MSB shifted out
            end

            3'b111: begin
                // SHR: Logical Shift Right by 1 (divide by 2)
                // LSB is lost; carry captures it
                result = A >> 1;
                carry  = A[0]; // LSB shifted out
            end

            default: begin
                // Safety default - output zero for undefined opcodes
                result = 4'b0000;
            end
        endcase

        // --------------------------------------------------------
        // Status Flags
        // zero : asserted when result is 0000
        // neg  : asserted when MSB of result is 1 (negative in 2's complement)
        // --------------------------------------------------------
        zero = (result == 4'b0000) ? 1'b1 : 1'b0;
        neg  = result[3];
    end

endmodule
