`include "adder.v"

module program_counter(
    input in, clk,
    output out
);
    wire [31:0] current; // keeping state of 

    adder(
        .in(out),
        .out(next)
    )

    

endmodule