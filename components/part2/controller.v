module controller (
    input [31:0] rdata,
    output reg rf_we,
    output reg sel_result,
    output reg dmem_we,
    output reg sel_alu_src_b,
    output reg sel_ext
);
    // as used in instruction_memory, the rdata can be divided into their respective formats:
    // where opcode is the first element of the array
    wire[6:0] opcode;
    assign opcode = rdata[6:0];

endmodule