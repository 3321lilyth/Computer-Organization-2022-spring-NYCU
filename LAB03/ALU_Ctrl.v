`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr, //[30,14-12]，也就是先 func7才 func3
	input		[2-1:0]	ALUOp, //本次作業全部都ˋR type ，根本不會用到 ALU_op去判斷，所以之後要用再來改
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
always @(*)
	begin
		case(instr)
			4'b0000: ALU_Ctrl_o = 4'b0010; //add
			4'b1000: ALU_Ctrl_o = 4'b0110; //sub
			4'b0111: ALU_Ctrl_o = 4'b0000; //and
			4'b0110: ALU_Ctrl_o = 4'b0001; //or
			4'b0010: ALU_Ctrl_o = 4'b0111; //slt
			4'b0100: ALU_Ctrl_o = 4'b0011; //xor 我自己定義的 ALU_control_input
			4'b0001: ALU_Ctrl_o = 4'b1110; //sll 我自己定義的 ALU_control_input
			4'b1101: ALU_Ctrl_o = 4'b1111; //sra 我自己定義的 ALU_control_input

			default: ALU_Ctrl_o = 4'b0000;
		endcase
	end



endmodule
