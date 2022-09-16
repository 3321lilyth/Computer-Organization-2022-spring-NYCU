
`timescale 1ns/1ps

module Imm_Gen(
    input  [31:0] instr_i,
    output reg[31:0] Imm_Gen_o
);

//Internal Signals
wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];
assign func3  = instr_i[14:12];

/* Write your code HERE */
always@(*)begin
    case (opcode)
        7'b0010011: Imm_Gen_o = {{20{instr_i[31]}}, instr_i[31:20]};    //Itype = 20-12
        7'b0000011: Imm_Gen_o = {{20{instr_i[31]}}, instr_i[31:20]};    //lw，也是 I type
        7'b1100111: Imm_Gen_o = {{20{instr_i[31]}}, instr_i[31:20]};    //jalr，就是 Itype
        7'b0100011: Imm_Gen_o = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]}; //store = 20+7+5，S type
        7'b1100011: Imm_Gen_o = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};//beq = 20+1+6+4+1 ，B type
            //(因為branch跳的指令的bit數量一定偶數所以最後一bit不存，但你要自己補個0回去)
        7'b1101111: Imm_Gen_o = {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};//jal  = 12+8+1+10+1，J type
    endcase 
    end
endmodule
