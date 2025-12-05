module adder #(
    parameter logic OFFSET = 4'b0100
) (
    input  in,
    output out
);

  assign out = in + OFFSET;
endmodule
