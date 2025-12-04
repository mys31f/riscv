`include "./program_counter.v"
`include "adder.v"

module instruction_memory (
    input [31:0] a,
    output [31:0] rdata // keeping this an array but shouldn't this be 32 bits as well
);
    // 32 bits in total
    // immediately assignable
  wire [6:0] opcode; // bits 0 to 6 = length 7
  assign opcode = a[6:0];

    // not always assignable
  wire [4:0] rd; // r & i
  wire [2:0] funct3;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [6:0] funct7;
  wire [11:0] imm_i_type; // immediate goes from bits 20 to 31 (lsb to msb)
  wire [4:0] imm_s_type_1; // immediate part 1 goes from bits 7 to 11
  wire [6:0] imm_s_type_2; // immediate part 2 goes from bits 25 to 31
// immediate goes from bits 12 to 31 (lsb to msb)
  wire [19:0] imm_u_type;
  wire [19:0] imm_j_type;
      wire rst;
initial rst = 0;

  always_comb begin
    if (rst) begin
        rdata = 32'b0;
    end
end
    // decoding based on opcode
    // extracted data will be put into the rdata array, and will split up later

always_comb begin
case (opcode)
        7'b0110011: begin // algebraic instructions
            rd = a[11:7];
            funct3 = a[14:12];
            rs1 = a[19:15];
            rs2 = a[24:20];
            funct7 = a[31:25];

            // 5:0 elements = 6 total
            rdata = {funct7, rs2, rs1, funct3, rd, opcode};
        end
        7'b0010011: begin // immediate instructions
            rd = a[11:7];
            funct3 = a[14:12];
            rs1 = a[19:15];
            imm_i_type = a[31:20];

            // 4:0 elements = 5 total
            rdata = {imm_i_type, rs1, funct3, rd, opcode};
        end
        7'b0000011: begin // load instructions
            rd = a[11:7];
            funct3 = a[14:12];
            rs1 = a[19:15];
            imm_i_type = a[31:20];

            rdata = {imm_i_type, rs1, funct3, rd, opcode};
        end
        7'b0100011: begin // store instructions
            imm_s_type_1 = a[11:7];
            funct3 = a[14:12];
            rs1 = a[19:15];
            rs2 = a[24:20];
            imm_s_type_2 = a[31:25];

            rdata = {imm_s_type_2, rs2, rs1, funct3, imm_s_type_1, opcode};
        end
        7'b1100011: begin // branching instructions
            rd = a[11:7];
            imm_j_type = a[31:12];

            rdata = {imm_j_type, rd, opcode};
        end
        // 7'b1101111: jump and link (JAL) instruction
        // 7'b1101111: begin
        //     
        // end
        // 7'b1100111: jump and link register (JALR) instruction
        // 7'b1100111: begin
        //     
        // end
        // 7'b0110111: load upper immediate (LUI) instruction
        // 7'b0110111: begin
        // end
        // 7'b0010111: add immediate to PC (AUIPC) instruction
        // 7'b0010111: begin
        //     
        // end
        default: rst = 1;
    endcase
end

endmodule
