module alu(
	input                   rst_n,         // negative reset            (input)
	input signed [32-1:0]   src1,          // 32 bits source 1          (input)
	input signed [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
//助教要求除了XOR、sll、sra可以直接用 operator以外，其他運算都要套用 lab2的程式碼
   wire [32-1:0]    res;
   wire             per_cout;
   wire 	        slt;       //就是傳回去的set，但其實set不只有slt，我簡化成只做slt
   wire [32-1:0]    eq; 	   
   wire 	        sign_check, add, sign;
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

    assign slt = eq[31] ? src1[31] : sign; 
    assign add = ALU_control[1] & ~ALU_control[0];       //確認是否正在做加減法
    
    always @ (*) begin
        if (rst_n) begin
			if (ALU_control == 4'b0011)         //特判xor
				result <= src1 ^ src2;
			else if(ALU_control == 4'b1110)     //特判sll
				result <= src1 << src2;
			else if(ALU_control == 4'b1111)     //特判sra
				result <= src1 >>> src2;
			else
				begin
					result <= res;
					zero <= ~|res;                      //將 result 的所有位數拿出來做 nor
					cout <= per_cout & add;              //由 cla adder 拿出 carry out 之後, 再確認是否是作加減法
					overflow <= over & add;              //加了& ad，因為做加剪髮才會需要判斷overflow
				end
		end 
    end

endmodule
