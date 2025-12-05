module mux_se (
    input [31:0] rdata,
    output reg out
);
    // extract opcode per instruction type
    wire [6:0] opcode;
    assign opcode = rdata[6:0];
    
    // instruction types with extender required:
    // I, S, B, U, J

    always @(*) begin
        case (opcode)
            7'b0010011: out = 1; // i type
            7'b0100011: out = 2; // s type
            7'b1100011: out = 3; // b type
            7'b0110111: out = 4; // u type
            7'b1101111: out = 5; // j type
            default: out = 0; // no immediate sign extension required
        endcase
    end

endmodule