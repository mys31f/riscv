module mux_alu (
    input [31:0] in_mux,
    output reg sel_mux
);
  reg array_size;
  integer i;

  always @(*) begin
    for (i = 0; i < 10; i = i + 1) begin
      array_size = i;
    end

    if (array_size == 6) begin
      sel_mux = 1;  // r type demo
    end else begin
      sel_mux = 0;  // i type demo
    end
  end
endmodule
