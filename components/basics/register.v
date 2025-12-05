module register (
    input [31:0] rdata,
    input clk, we,
    output rd1, rd2
);
    // assign [19:15] to a1, [24:20] to a2, [11:7] to a3
    wire [4:0] a1, a2, a3;
    assign a1 = rdata[19:15];
    assign a2 = rdata[24:20];
    assign a3 = rdata[11:7];

    
endmodule
