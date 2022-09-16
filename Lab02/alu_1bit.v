`timescale 1ns/1ps
module alu_1bit(        //7 input 、5 output
	input				src1,       
	input				src2,       
	input				less,       //如果以做slt ，這邊就是1，那result就直接是1
	input 				Ainvert,  
	input				Binvert,    
    input 				cin,        
	input 	    [2-1:0] operation,  

    output reg          result,     
	output		        cout,       
	output				p,			
	output				g,			
	output				eq	
	);
	

    wire _and,_or_add;
    wire in1,in2;

	assign in1 = Ainvert ^ src1;
	assign in2 = Binvert ^ src2;

	assign _and = in1 & in2; // op=0
	assign _or = in1 | in2;  // op=1
	assign _add = in1 ^ in2 ^ cin; //op=2，就是sum拉，做 XOR。

	assign p = _or;
   	assign g = _and;
	assign eq = ~(in1 ^ in2);//判斷AB是否相同，如果一樣的畫 eq = 1
	assign cout = (in1 & in2) | (in1 & cin) | (in2 & cin);

	always @ (*) 
		begin
			case(operation)
				2'b00: result = _and;
				2'b01: result = _or;				
				2'b10: result = _add;
				2'b11: result = less;
			endcase
		end

endmodule	//1 bit alu


//--------------------------------------------------------------------------------------------

module cla4(        //3 input 、 1 output
	input [4-1:0]	G,
	input [4-1:0]	P,
	input			cin,
	output [4-1:0]	cout
	);

	assign cout[0] = G[0] | (P[0] & cin);
   	assign cout[1] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
  	assign cout[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin);
   	assign cout[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & cin);
endmodule	//cla4

//------------------------------------------------------------------------------------------
//我發現他沒有用到 1 bit alu 的 output eq，出事在說，卡

/*module alu_4bit(    //7 input 2 output
	input [4-1:0]	src1, 
	input [4-1:0]	src2, 
    input			less, 
    input			Ainvert, 
    input			Binvert, 
    input			cin, 
    input [2-1:0]	operation, 

    output	reg [4-1:0]	result,
    output			    cout
	);

	wire [4-1:0] res;
	wire [4-1:0] per_cout;
	wire [4-1:0] p,g;

	cla4 cl(
		.G(g),
		.P(p),
		.cin(cin),
		.cout(per_cout)
	);
	alu_1bit a1(
		.src1(src1[0]),
        .src2(src2[0]),
        .less(less),
        .Ainvert(Ainvert),
    	.Binvert(Binvert),
        .cin(cin),
        .operation(operation),

        .result(res[0]),
        .p(p[0]),
        .g(g[0])
    );
   alu_1bit a2(
	    .src1(src1[1]),
        .src2(src2[1]),
        .less(less),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[0]),
        .operation(operation),

        .result(res[1]),
        .p(p[1]),
        .g(g[1])
	);

   alu_1bit a3(
	    .src1(src1[2]),
        .src2(src2[2]),
    	.less(less),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[1]),
        .operation(operation),
        .result(res[2]),
        .p(p[2]),
        .g(g[2])
    );

   alu_1bit a4(
	    .src1(src1[3]),
        .src2(src2[3]),
        .less(less),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[2]),
        .operation(operation),
        .result(res[3]),
        .p(p[3]),
        .g(g[3])
    );

	assign cout = per_cout[3];
	always @ (*)
		begin
			result = res;
		end

endmodule //4 bit alu*/

//-----------------------------------------------------------------------------------------------------------
module cla8 (   //3 input 3output
	input [8-1:0] G, 
	input [8-1:0] P, 
    input 	cin,
    output [8-1:0] cout,
	output	Pout,
    output	Gout
    ) ;

   wire   pw, gw;
   
   assign cout[0] = G[0] | (P[0] & cin);
   assign cout[1] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
   assign cout[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin);
   assign cout[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & cin);
   assign cout[4] = G[4] | (P[4] & G[3]) | (P[4] & P[3] & G[2]) | (P[4] & P[3] & P[2] & G[1]) | (P[4] & P[3] & P[2] & P[1] & G[0]) | (P[4] & P[3] & P[2] & P[1] & P[0] & cin);
   assign cout[5] = G[5] | (P[5] & G[4]) | (P[5] & P[4] & G[3]) | (P[5] & P[4] & P[3] & G[2]) | (P[5] & P[4] & P[3] & P[2] & G[1]) | (P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) | (P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & cin);
   assign cout[6] = G[6] | (P[6] & G[5]) | (P[6] & P[5] & G[4]) | (P[6] & P[5] & P[4] & G[3]) | (P[6] & P[5] & P[4] & P[3] & G[2]) | (P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & cin);
   
   assign gw = G[7] | (P[7] & G[6]) | (P[7] & P[6] & G[5]) | (P[7] & P[6] & P[5] & G[4]) | (P[7] & P[6] & P[5] & P[4] & G[3]) | (P[7] & P[6] & P[5] & P[4] & P[3] & G[2]) | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1]) | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0]) ;
   assign pw = (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0]);
   
   assign cout[7] = gw | (pw & cin);
   
   assign Pout = pw;
   assign Gout = gw;
   
endmodule // 8 bit cla generator cla8

//---------------------------------------------------------------------------------------
module alu_8bit ( //7 input 5 outpur ，跟 1bit alu 一樣
    input [8-1:0]	src1, 
    input [8-1:0]	src2, 
    input			less, 
    input			Ainvert, 
    input			Binvert, 
    input			cin, 
    input [2-1:0]	operation,
    
	output [8-1:0]	result,     //我不知道這裡為甚麼不能加 reg，卡
    output [8-1:0]	cout,       
    output 			P, 
	output 			G, 
	output [8-1:0]	eq          //存 8 bit 是否bitwise相同的結果，注意 eq = 0 才代表兩bit相同
    );

    wire [8-1:0]    per_cout;
    wire [8-1:0]    p, g;
   
    cla8 cl(.G(g),
           .P(p),
           .cin(cin),
           .cout(per_cout),
           .Pout(P),
           .Gout(G)
           );
   
   
    alu_1bit a1(
        .src1(src1[0]),
        .src2(src2[0]),
        .less(less),        //只有第一個 1 bit alu 的less 會受到後面接回來的影響
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(cin),
        .operation(operation),
        .result(result[0]),
        .p(p[0]),
        .g(g[0]),
	    .eq(eq[0])
        );

    alu_1bit a2(
        .src1(src1[1]),
        .src2(src2[1]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[0]),
        .operation(operation),
        .result(result[1]),
        .p(p[1]),
        .g(g[1]),
	    .eq(eq[1])
        );

    alu_1bit a3(
        .src1(src1[2]),
        .src2(src2[2]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[1]),
        .operation(operation),
        .result(result[2]),
        .p(p[2]),
        .g(g[2]),
	    .eq(eq[2])	      
        );

    alu_1bit a4(
        .src1(src1[3]),
        .src2(src2[3]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[2]),
        .operation(operation),
        .result(result[3]),
        .p(p[3]),
        .g(g[3]),
	    .eq(eq[3])
        );

    alu_1bit a5(
        .src1(src1[4]),
        .src2(src2[4]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[3]),
        .operation(operation),
        .result(result[4]),
        .p(p[4]),
        .g(g[4]),
	    .eq(eq[4])
        );

    alu_1bit a6(
        .src1(src1[5]),
        .src2(src2[5]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[4]),
        .operation(operation),
        .result(result[5]),
        .p(p[5]),
        .g(g[5]),
	    .eq(eq[5])
        );

    alu_1bit a7(
        .src1(src1[6]),
        .src2(src2[6]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[5]),
        .operation(operation),
        .result(result[6]),
        .p(p[6]),
        .g(g[6]),
	    .eq(eq[6])	      
        );

    alu_1bit a8(
        .src1(src1[7]),
        .src2(src2[7]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[6]),
        .operation(operation),
        .result(result[7]),
        .p(p[7]),
        .g(g[7]),
	    .eq(eq[7])	      
        );

   
   assign cout = per_cout;

endmodule // alu8

//-------------------------------------------------------------------------------------------------

module alu32 ( //7 input、5 output
    input [32-1:0]  src1, 
    input [32-1:0]  src2, 
    input           less,  
    input           Ainvert,
    input           Binvert,
    input           cin, 
    input [2-1:0]   operation,

    output [32-1:0] result, 
    output          cout, 
	output [32-1:0] eq,         //回傳AB的每一個 bit 是否相同，注意相同的話 eq 值是0
	output          overflow,   //也就是ZCV中的V
    output          Sign        
    );

   wire [4-1:0]     per_cout;
   wire [4-1:0]     p, g;
   wire [8-1:0]     over;       //存放最高位的那個 8bit alu 中的 MSB 的每一個 bit 的 cin，但其實我們只關心 32 bit中的 MSB 拉

   
    //top level carry look ahead
    cla4 cl(
        .G(g),
        .P(p),
        .cin(cin),
        .cout(per_cout)
        );

    alu_8bit e1(
       .src1(src1[8-1:0]),
        .src2(src2[8-1:0]),
        .less(less),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(cin),
        .operation(operation),
        .result(result[8-1:0]),
        .P(p[0]),
        .G(g[0]),
	    .eq(eq[8-1:0])
        );

    alu_8bit e2(
        .src1(src1[16-1:8]),
        .src2(src2[16-1:8]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[0]),
        .operation(operation),
        .result(result[16-1:8]),
        .P(p[1]),
        .G(g[1]),
	    .eq(eq[16-1:8])           
        );

    alu_8bit e3(
        .src1(src1[24-1:16]),
        .src2(src2[24-1:16]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[1]),
        .operation(operation),
        .result(result[24-1:16]),
        .P(p[2]),
        .G(g[2]),
	    .eq(eq[24-1:16])
        );

    alu_8bit e4(
        .src1(src1[32-1:24]),
        .src2(src2[32-1:24]),
        .less(1'b0),
        .Ainvert(Ainvert),
        .Binvert(Binvert),
        .cin(per_cout[2]),
        .operation(operation),
        .result(result[32-1:24]),
        .P(p[3]),
        .G(g[3]),
	    .eq(eq[32-1:24]),
	    .cout(over) //只有最後一個有cout over,因為觀察overflow我們只需要 MSB 的cin和cout
        );
   
   
   
    assign cout = per_cout[3];
    assign overflow = per_cout[3] ^ over[6]; //V = MSB的cout xor MSB的cin，原因請看數電筆記
    assign Sign = ~eq[31] ^ over[6];          //代表算術結果的正負號，也就是result[31]是0還是1
    //eq[31] == 1 代表 AB 的 MSB 相同、 over[6]則是 MSB 的Cin。
    //劃出2*2表格就知道了，只有當 AB 同號且Cin = 1時，結果才會是1。就跟full adder裡面定義的 sum = A^B^Cin 一樣
    //  ~eq\over  |    0    |    1
    //  0         |    0    |    1        
    //  1         |    1    |    0

endmodule // alu32
