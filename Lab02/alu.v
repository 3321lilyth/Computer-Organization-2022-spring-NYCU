`timescale 1ns/1ps
module alu(
    input           rst_n,         
    input [32-1:0]  src1,          
    input [32-1:0]  src2,          
    input [4-1:0]   ALU_control,   
    output reg [32-1:0] result,    
    output reg      zero,          
    output reg      cout,          
    output reg      overflow       
    );
   wire [32-1:0]    res;
   wire             per_cout;
   wire 	        slt;       //就是傳回去的set，但其實set不只有slt，我簡化成只做slt
   wire [32-1:0]    eq; 	   
   wire 	        sign_check, ad, sign;
   wire 	        over;
   
   alu32 a1(.src1(src1),
            .src2(src2),
            .less(slt),
            .Ainvert(ALU_control[3]), 
            .Binvert(ALU_control[2]),   //ALU_ctrl同時代表 Binvert 跟 cin 的原因在老師PPT有教
            .cin(ALU_control[2]),
            .operation(ALU_control[1:0]),
            .result(res),
            .cout(per_cout),
	        .eq(eq),
	        .overflow(over),
            .Sign(sign)     //sign回傳的是計算結果的正負號，也就是MSB是0還是1。Sign = eq[31] ^ over[6];
            );
    assign slt = eq[31] ? src1[31] : sign; //eq[31] = src1[31] ^ ~src2[31]; 、Sign = eq[31] ^ over[6]; 
        //in1、in2同異號? 異號:同號。本來他前面是slt，但我不會用到其他Set，所以直接簡化成只做slt
        //slt : 當 A<B 時設為 1      //AB同號時，考慮減法出來的結果, MSB = 1 ，也就是 A-B<0 ，則 slt = 1。 
                                    //AB異號時，只要 A 的 MSB = 1 ，也就是 A 為負且 B 為正，則 slt = 1
    assign ad = ALU_control[1] & ~ALU_control[0];       //確認是否正在做加減法
    always @ (*) begin
        if (rst_n) begin
            result <= res;
	        zero <= ~|res;                      //將 result 的所有位數拿出來做 nor
	        cout <= per_cout & ad;              //由 cla adder 拿出 carry out 之後, 再確認是否是作加減法
	        overflow <= over & ad;              //加了& ad，因為做加剪髮才會需要判斷overflow
        end 
    end
endmodule