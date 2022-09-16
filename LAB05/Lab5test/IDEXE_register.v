`timescale 1ns/1ps
module IDEXE_register (
    //這邊感覺要自己加 rs1、rs2當input 和 output ????
    input clk_i,
    input rst_i,
    input [31:0] instr_i,

    //這邊傳進來的應該是已經經過 MUX 選過的八，所以直接照著傳出去就好
    input [3:0] WB_i,           //4 bit，MemToReg(拆成兩個WriteBack) 和 RegWite 和 jump
    input [1:0] Mem_i,          //2 bit，MemWrite 和 MemRead，沒有 branch因為 branch 移到L2了
    input [2:0] Exe_i,          //3 bit，ALU_src *1 和 ALU op*2
    
    input [31:0] data1_i,
    input [31:0] data2_i,

    input [31:0] immgen_i,          
    input [3:0] alu_ctrl_instr,     //???? for what
    input [4:0] WBreg_i,            //rd 往後不斷傳下去，沒問題
    input [31:0] pc_add4_i,         // for what????
    input [5-1:0] RS1_i,
    input [5-1:0] RS2_i, 
    //為甚麼不用 src1 和 src2ㄚㄚㄚㄚㄚㄚㄚ啊?
    //--------------------------
    output reg [31:0] instr_o,

    output reg [3:0] WB_o,
    output reg [1:0] Mem_o,
    output reg [2:0] Exe_o,
    
    output reg [31:0] data1_o,
    output reg [31:0] data2_o,
    output reg [31:0] immgen_o,
    output reg [3:0] alu_ctrl_input,
    output reg [4:0] WBreg_o,       //rd
    output reg [31:0] pc_add4_o,
    output reg [5-1:0] RS1_o,
    output reg [5-1:0] RS2_o
);

/* Write your code HERE */
always @(posedge clk_i or negedge rst_i)begin
    if (~rst_i)begin //全部設定成0
        instr_o <= 0;
        WB_o <= 0;
        Mem_o <= 0;
        Exe_o <= 0;

        data1_o <= 0;
        data2_o <= 0;
        immgen_o <= 0;
        alu_ctrl_input <= 0;
        WBreg_o <= 0;
        pc_add4_o <= 0;
        RS1_o <= 0;
        RS2_o <= 0;
    end
    else begin
        instr_o <= instr_i;
        WB_o <= WB_i;
        Mem_o <= Mem_i;
        Exe_o <= Exe_i;

        data1_o <= data1_i;
        data2_o <= data2_i;
        immgen_o <= immgen_i;
        alu_ctrl_input <= alu_ctrl_instr;
        WBreg_o <= WBreg_i;
        pc_add4_o <= pc_add4_i;
        RS1_o <= RS1_i;
        RS2_o <= RS2_i;
    end


end

endmodule
