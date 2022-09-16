`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input  signed   [32-1:0]   src1,          // 32 bits source 1          (input)
    input  signed   [32-1:0]   src2,          // 32 bits source 2          (input)
    input           [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg      [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero           // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */
always @(*) begin
    // if (rst_n) begin
    case (ALU_control)
        0: result <= src1 & src2;
        1: result <= src1 | src2;
        2: result <= src1 + src2;
        3: result <= src1 ^ src2;
        6: result <= src1 - src2;
        7: result <= src1 < src2 ? 1 : 0;
        8: result <= src1 << src2; //slli

        
        default: result <= 0;
    endcase
    // end
end

assign Zero = ~|result;

endmodule
