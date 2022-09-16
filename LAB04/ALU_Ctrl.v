
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];
/* Write your code HERE */
always@( * )begin
    if(ALUOp == 2'b10)begin // Rtype
        if(func3 == 3'b000 ) ALU_Ctrl_o = 4'b0010; //add,addi
        else if(instr == 4'b0010) ALU_Ctrl_o = 4'b0111; //slt

    end
    else if(ALUOp == 2'b00)begin //lw, sw
        ALU_Ctrl_o = 4'b0010; 
    end
    else if(ALUOp == 2'b01)begin //beq
        ALU_Ctrl_o = 4'b0110; 
    end
end

endmodule

