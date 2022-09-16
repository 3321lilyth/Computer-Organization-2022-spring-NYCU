
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */
reg temp_Reg, temp_B, temp_J, temp_WB1, temp_WB0, temp_MR, temp_MW;
reg temp_SrcA, temp_SrcB;
reg temp_ALUOp[2-1:0];
//WB0 = MemtoReg
//SrcB = ALUSrc

always@(*) begin
    if (instr_i == 7'b0000000)begin //for nop
        temp_Reg = 1'b0;
        temp_B = 1'b0;
        temp_J = 1'b0;
        temp_WB0 = 1'b0;
        temp_WB1 = 1'b0;
        temp_MR = 1'b0;
        temp_MW = 1'b0;
        temp_SrcA = 1'b0;
        temp_SrcB = 1'b0;
        temp_ALUOp[1] = 1'b0;
        temp_ALUOp[0] = 1'b0;
    end
    if(instr_i == 7'b0110011)begin //Rtype
        temp_Reg = 1'b1;
        temp_B = 1'b0;
        temp_J = 1'b0;
        temp_WB0 = 1'b0;
        temp_WB1 = 1'b0;
        temp_MR = 1'b0;
        temp_MW = 1'b0;
        //
        temp_SrcB = 1'b0;
        temp_ALUOp[1] = 1'b1;
        temp_ALUOp[0] = 1'b0;
    end

    else if(instr_i == 7'b0010011)begin //Itype
        temp_Reg = 1'b1;
        temp_B = 1'b0;
        temp_J = 1'b0;
        temp_WB0 = 1'b0;
        temp_WB1 = 1'b0;
        temp_MR = 1'b0;
        temp_MW = 1'b0;
        temp_SrcB = 1'b1;
        temp_ALUOp[1] = 1'b1;
        temp_ALUOp[0] = 1'b0;
    end
    else if(instr_i == 7'b0000011)begin //lw
        temp_Reg = 1'b1;
        temp_B = 1'b0;
        temp_J = 1'b0;
        temp_WB0 = 1'b1;
        temp_WB1 = 1'b0;
        temp_MR = 1'b1;
        temp_MW = 1'b0;
        temp_SrcB = 1'b1;
        temp_ALUOp[1] = 1'b0;
        temp_ALUOp[0] = 1'b0;
    end
    else if(instr_i == 7'b0100011)begin //sw
        temp_Reg = 1'b0;
        temp_B = 1'b0;
        temp_J = 1'b0;
        // temp_WB1 = 1'b0;
        //temp_WB0 = 1'b1;
        temp_MR = 1'b0;
        temp_MW = 1'b1;
        temp_SrcB = 1'b1;
        temp_ALUOp[1] = 1'b0;
        temp_ALUOp[0] = 1'b0;
    end
    else if(instr_i == 7'b1100011)begin //beq
        temp_Reg = 1'b0;
        temp_B = 1'b1;
        temp_J = 1'b0;
        // temp_WB1 = 1'b0;
        //temp_WB0 = 1'b1;
        temp_MR = 1'b0;
        temp_MW = 1'b0;
        temp_SrcB = 1'b0;
        temp_ALUOp[1] = 1'b0;
        temp_ALUOp[0] = 1'b1;
    end
    else if(instr_i == 7'b1101111)begin //jal
        temp_Reg = 1'b1; //把 PC+ imm 寫進 rd 
        temp_B = 1'b0;
        temp_J = 1'b1;
        temp_WB1 = 1'b1;
        //temp_WB0 = 1'b1;
        temp_MR = 1'b0;
        temp_MW = 1'b0;
        temp_SrcA = 1'b0; //因為要選立即值 ，PC = PC +imm
        //temp_SrcB = 1'b0;
        //temp_ALUOp[1] = 1'b0;
        //temp_ALUOp[0] = 1'b1;
    end
    else if(instr_i == 7'b1100111)begin //jalr
        temp_Reg = 1'b1;//把 src1 + imm 寫進 rd 
        temp_B = 1'b0;
        temp_J = 1'b1;
        temp_WB1 = 1'b1;
        //temp_WB0 = 1'b0;
        temp_MR = 1'b0;
        temp_MW = 1'b0;
        temp_SrcA = 1'b1;
        //temp_SrcB = 1'b0;
        //temp_ALUOp[1] = 1'b0;
        //temp_ALUOp[0] = 1'b1;
    end
end

assign RegWrite = temp_Reg;
assign Branch = temp_B;
assign Jump = temp_J;
assign WriteBack1 = temp_WB1;
assign WriteBack0 = temp_WB0;
assign MemRead = temp_MR;
assign MemWrite = temp_MW;
assign ALUSrcA = temp_SrcA;
assign ALUSrcB = temp_SrcB;
assign ALUOp[1] = temp_ALUOp[1];
assign ALUOp[0] = temp_ALUOp[0];

endmodule

