`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */

always@( * )begin
    if(ALUOp == 2'b10)begin // Rtype
        if(instr == 4'b0000 ) ALU_Ctrl_o = 4'b0010; //add,addi
        else if(instr == 4'b0010) ALU_Ctrl_o = 4'b0111; //slt,slti
        else if(instr == 4'b1000) ALU_Ctrl_o = 4'b0110; //sub
        else if(instr == 4'b0111) ALU_Ctrl_o = 4'b0000; //and
        else if(instr == 4'b0110) ALU_Ctrl_o = 4'b0001; //or
        else if(instr == 4'b0100) ALU_Ctrl_o = 4'b0011; //xor
        else if(instr == 4'b0001) ALU_Ctrl_o = 4'b1000; //sll,slli

    end
    else if(ALUOp == 2'b00)begin //lw, sw
        ALU_Ctrl_o = 4'b0010; 
    end
    else if(ALUOp == 2'b01)begin //beq
        ALU_Ctrl_o = 4'b0110; 
    end
end
    
endmodule
