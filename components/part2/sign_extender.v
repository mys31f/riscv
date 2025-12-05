module sign_extender (
    input type, // goes from 1-5, anything else goes to default
    input [31:0] rdata,
    output reg [31:0] out_se
);
// damn thanks edaboard for the idea this is actually a fun idea
    always @(*) begin 
        case (type)
            1: begin
                
            end
            2:
            3:
            4:
            5:
            default: out_se = rdata;
        endcase
    end
endmodule
