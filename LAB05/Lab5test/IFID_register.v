`timescale 1ns/1ps
module IFID_register (
    input clk_i,
    input rst_i,
    input flush,            //來自 main decoder，處理例外
    input IFID_write,       //來自 hazard detector，如果有 hazard 就是0

    input [31:0] address_i,//??????
    input [31:0] instr_i,
    input [31:0] pc_add4_i, 

    output reg [31:0] address_o,
    output reg [31:0] instr_o,
    output reg [31:0] pc_add4_o
);
/* Write your code HERE */
always @(posedge clk_i or negedge rst_i)begin
    // if (rst_i) begin
    //     if (IFID_write == 1'b1)begin
    //        if(flush == 1'b1)begin
    //            address_o <= 32'b0;
    //            instr_o <= 32'b0;
    //            pc_add4_o <= 32'b0;
    //        end 
    //        else begin
    //            address_o <= address_i;
    //            instr_o <= instr_i;
    //            pc_add4_o <= pc_add4_i;
    //        end
    //     end
    // end

    if (~rst_i) begin //全部設定成0
        address_o <= 32'b0;
        instr_o <= 32'b0;
        pc_add4_o <= 32'b0;
    end
    else if (~IFID_write) begin 
        //不給改寫，PC應該是由 PC write 直接控制讓他不變 stall
        address_o <= address_i;
        instr_o <= instr_o;
        pc_add4_o <= pc_add4_i;
    end
    else if(flush) begin
        address_o <= address_i;
        instr_o <= 32'b0;
        pc_add4_o <= pc_add4_i;
    end
    else begin 
        address_o <= address_i;
        instr_o <= instr_i;
        pc_add4_o <= pc_add4_i;
    end
end
endmodule

