`include "adder.v"

module program_counter (
    input [31:0] in,  //32 bits
    input clk,
    input rst,
    output reg [31:0] out
);
  wire [31:0] next_pc;  // wire for adder output

  adder(
      .in(out), .out(next_pc) // calling adder since connected later
  );

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out <= 32'b0; // reset to 0 on rst
    end else begin
      out <= next_pc;
    end
  end

endmodule
