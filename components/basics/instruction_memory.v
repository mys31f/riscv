module instruction_memory (
    input [31:0] a,
    output reg [31:0] rdata // keeping this an array but shouldn't this be 32 bits as well
);
   always @(*) rdata = a;
endmodule
