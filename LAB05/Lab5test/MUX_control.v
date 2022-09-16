`timescale 1ns/1ps

module MUX_control(
    input [3:0] WB_i,           //4 bit，MemToReg(拆成兩個WriteBack) 和 RegWite 和 jump
    input [1:0] Mem_i,          //2 bit，MemWrite 和 MemRead，沒有 branch因為 branch 移到L2了
    input [2:0] Exe_i,          //3 bit，ALU_src *1 和 ALU op*2
    input       hazard_control,
    output reg [3:0] WB_o,
    output reg [1:0] Mem_o,
    output reg [2:0] Exe_o
);
/* Write your code HERE */
always @(*) begin
    if (hazard_control == 1'b1)begin //發生 hazard，全部歸0
        WB_o <= 4'b0;
        Mem_o <= 2'b0;
        Exe_o <= 3'b0;
    end
    else begin //照常輸出
        WB_o <= WB_i;
        Mem_o <= Mem_i;
        Exe_o <= Exe_i;
    end
end
endmodule

