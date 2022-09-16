`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signals
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire [1:0] ALUOp;
wire [3:0]ALU_control;
wire zero,cout,overflow;
wire [31:0]imm_4 = 4;
wire branch;	
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i(rst_i),     
	    .pc_i(pc_i),   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
		.rst_i(rst_i),     
        .RSaddr_i(instr[19:15]),	//rs1
		.RTaddr_i(instr[24:20]), 	//rs2
 		.RDaddr_i(instr[11:7]),  	//rd
        .RDdata_i(ALUresult), 				//data input to write to rd，來自最後一個 MUX，但他作業的圖是簡單版，ˋALU輸出直接接過來
 		.RegWrite_i(RegWrite),				//control line : RegWrite
 		.RSdata_o(RSdata_o),  				//read data output1，接到 ALU src1
        .RTdata_o(RTdata_o)   				//read data output2，接到選擇ALU src2的 MUX
	    );
		
Decoder Decoder(
		.instr_i(instr),					//因為他 decoder.v 那邊的 input 是32 bit而不是7bit，邊才直接丟的
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.Branch(branch),
		.ALUOp(ALUOp)
	    );	

Adder PC_plus_4_Adder(
		.src1_i(pc_o),
		.src2_i(imm_4),
		.sum_o(pc_i)
	    );
			
ALU_Ctrl ALU_Ctrl(
		.instr({instr[30],instr[14:12]}),	//ALU_Ctrl.v 的 instruction input 是 4 bit
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALU_control)
		);
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(RTdata_o),
		.ALU_control(ALU_control),
		.result(ALUresult),
		.zero(zero),
		.cout(cout),
		.overflow(overflow)
		);
	
		
endmodule
		  


