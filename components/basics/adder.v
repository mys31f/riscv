`include "program_counter.v"

module adder (
    input in,
    output out
)

    param OFFSET = 4'b100;

    out = in + OFFSET;
endmodule