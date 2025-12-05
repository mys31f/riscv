module two_complement (
    input [31:0] in_tc,
    output reg [31:0] out_tc
);
  always @(*) begin
    out_tc = ~in_tc + 1;
  end

endmodule

// called when mux_alu sel = 1
// r type instruction format:
// funct7 | rs2 | rs1 | funct3 | rd | opcode
module alu_r (
    input [31:0] rs1,
    input [31:0] rs2,
    input [3:0] funct3,
    input [6:0] funct7,
    output reg [31:0] rd
);
  reg status;
  initial status = 0;

  wire signed_rs1;
  wire signed_rs2;

  two_complement two_rs1 (
      rs1,
      signed_rs1
  );
  two_complement two_rs2 (
      rs2,
      signed_rs2
  );

  always @(*) begin
    case (funct3)
      4'h0: begin
        if (funct7 == 7'h00) begin  // add
          rd = rs1 + rs2;
        end else if (funct7 == 7'h20) begin
          rd = rs1 - rs2;
        end else begin
          status = 1;
        end
      end
      4'h4: begin  // xor
        rd = rs1 ^ rs2;
      end
      4'h6: begin  // or
        rd = rs1 | rs2;
      end
      4'h7: begin  // and
        rd = rs1 & rs2;
      end
      4'h1: begin  // sll
        rd = rs1 << rs2[4:0];
      end
      4'h5: begin  // srl, sra will not be touched rn
        rd = rs1 >> rs2[4:0];
      end
      4'h2: begin  // slt
        rd = (signed_rs1 < signed_rs2) ? 'b1 : 'b0;
      end
      4'h3: begin  // sltu
        rd = (rs1 < rs2) ? 'b1 : 'b0;
      end
      default: status = 1;  // invalid functions
    endcase
  end
endmodule

// called when mux_alu sel = 0
// i type instruction format:
// imm[11:0] | rs1 | funct3 | rd | opcode
module alu_i (
    // immediate should be processed through the sign extender
    input [31:0] rs1,
    input [3:0] funct3,
    input [31:0] imm,  // processed immediate
    output reg [31:0] rd
);
  reg status;
  initial status = 0;

  wire signed_rs1;
  wire signed_imm;
  two_complement two_rs1 (
      rs1,
      signed_rs1
  );
  two_complement two_imm (
      imm,
      signed_imm
  );

  always @(*) begin
    case (funct3)
      4'h0: begin  // addi
        rd = rs1 + imm;
      end
      4'h4: begin  // xori
        rd = rs1 ^ imm;
      end
      4'h6: begin  // ori
        rd = rs1 | imm;
      end
      4'h7: begin  // andi
        rd = rs1 & imm;
      end
      4'h1: begin  // slli
        rd = rs1 << imm[4:0];
      end
      4'h5: begin  // srli, srai will not be touched rn
        rd = rs1 >> imm[4:0];
      end
      4'h2: begin  // slti
        rd = (signed_rs1 < signed_imm) ? 'b1 : 'b0;
      end
      4'h3: begin  // sltiu
        rd = (rs1 < imm) ? 'b1 : 'b0;
      end
      default: status = 1;  // invalid functions
    endcase
  end


endmodule
