`timescale 1ns/1ps
module ForwardingUnit (
    input [5-1:0] IDEXE_RS1,
    input [5-1:0] IDEXE_RS2,
    input [5-1:0] EXEMEM_RD,
    input [5-1:0] MEMWB_RD,
    input EXEMEM_RegWrite,
    input MEMWB_RegWrite,
    output reg [2-1:0] ForwardA,
    output reg [2-1:0] ForwardB
);
/* Write your code HERE */
always @(*) begin
    // for src1
    if(EXEMEM_RegWrite && (EXEMEM_RD != 0) && (EXEMEM_RD == IDEXE_RS1))  //EX hazard 
        ForwardA = 2'b10;
    else if (MEMWB_RegWrite && (MEMWB_RD != 0) && (MEMWB_RD == IDEXE_RS1)) //Mem hazard
        //因為我用 else if 所以可以不用打判斷優先權那一串
        ForwardA = 2'b01;
    else
        ForwardA = 2'b00;

    // for src2
    if(EXEMEM_RegWrite && (EXEMEM_RD != 0) && (EXEMEM_RD == IDEXE_RS2))  //EX hazard 
        ForwardB = 2'b10;
    else if (MEMWB_RegWrite && (MEMWB_RD != 0) && (MEMWB_RD == IDEXE_RS2)) //Mem hazard
        //因為我用 else if 所以可以不用打判斷優先權那一串
        ForwardB = 2'b01;
    else
        ForwardB = 2'b00;

end
endmodule

