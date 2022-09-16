`timescale 1ns/1ps

module Decoder(
	input	[32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field; 			//LAB3只有R type 所以用不到
wire	[9-1:0]		Ctrl_o; 				//LAB3 只有 R type 所以用不到


/* Write your code HERE */
//注意我目前只時做了 R type 相關的，之後的 lab 會用到其他的 type，要記得改
//下面這些這樣寫是因為 All instr in given table are R type
assign funct3 = instr_i[14:12];
assign opcode = instr_i[6:0];
assign Branch = 1'b0;						//比如之後可能改成 Branch <=(opcode == 7'b1100011) ? 1: 0;
assign RegWrite = 1'b1;
assign ALUOp = 2'b10;
assign ALUSrc = 1'b0;

endmodule





                    
                    
