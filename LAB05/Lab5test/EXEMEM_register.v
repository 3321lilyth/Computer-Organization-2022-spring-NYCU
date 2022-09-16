`timescale 1ns/1ps
module EXEMEM_register (
    input clk_i,
    input rst_i,
    
    input [31:0] instr_i,
    input [3:0] WB_i,       //4 bit，MemToReg(拆成兩個WriteBack) 和 RegWite 和 jump
    input [1:0] Mem_i,      //2 bit，MemWrite 和 MemRead，沒有 branch因為 branch 移到L2了
    input zero_i,
    input [31:0] alu_ans_i,
    input [31:0] rtdata_i,      //alu src2
    input [4:0] WBreg_i,        //rd
    input [31:0] pc_add4_i,

    output reg [31:0] instr_o,
    output reg [3:0] WB_o,
    output reg [1:0] Mem_o,
    output reg zero_o,
    output reg [31:0] alu_ans_o,
    output reg [31:0] rtdata_o,
    output reg [4:0] WBreg_o, 
    output reg [31:0] pc_add4_o
);
/* Write your code HERE */
always @(posedge clk_i or negedge rst_i)begin
    if (~rst_i)begin //全部設定成0
        instr_o <= 0;
        WB_o <= 0;
        Mem_o <= 0;
        zero_o <= 0;
        alu_ans_o <= 0;
        rtdata_o <= 0;
        WBreg_o <= 0;
        pc_add4_o <= 0;
    end
    else begin
        instr_o <= instr_i;
        WB_o <= WB_i;
        Mem_o <= Mem_i;
        zero_o <= zero_i;
        alu_ans_o <= alu_ans_i;
        rtdata_o <= rtdata_i;
        WBreg_o <= WBreg_i;
        pc_add4_o <= pc_add4_i;
    end
end
endmodule
