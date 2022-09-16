module alu32 (/*AUTOARG*/ 
    input [32-1:0]  src1, //32 bit
    input [32-1:0]  src2, //32 bit
    input           less, //1 bit 
    input           Ainvert,//1 bit
    input           Binvert,//1 bit
    input           cin, //1 bit
    input [2-1:0]   operation, //2 bit????????????????????????
    output [32-1:0] result, //32 bit
    output          cout, //1 bit
	output [32-1:0] eq, //32 bit
	output          overflow, //1 bit overflow，他原本叫做V
    output          Sign//1 bit sign
) ;

   wire [4-1:0]    c;
   wire [4-1:0]    p, g;
   wire [8-1:0]    v;
   
   
   //top level carry look ahead
   cla4 cl(.G(g),
        .P(p),
        .cin(cin),
        .cout(c));

   alu_8bit e1(.src1(src1[8-1:0]),
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

   alu_8bit e2(.src1(src1[16-1:8]),
           .src2(src2[16-1:8]),
           .less(1'b0),
           .Ainvert(Ainvert),
           .Binvert(Binvert),
           .cin(c[0]),
           .operation(operation),
           .result(result[16-1:8]),
           .P(p[1]),
           .G(g[1]),
	   .eq(eq[16-1:8])           
           );

   alu_8bit e3(.src1(src1[24-1:16]),
           .src2(src2[24-1:16]),
           .less(1'b0),
           .Ainvert(Ainvert),
           .Binvert(Binvert),
           .cin(c[1]),
           .operation(operation),
           .result(result[24-1:16]),
           .P(p[2]),
           .G(g[2]),
	   .eq(eq[24-1:16])
           );

   alu_8bit e4(.src1(src1[32-1:24]),
           .src2(src2[32-1:24]),
           .less(1'b0),
           .Ainvert(Ainvert),
           .Binvert(Binvert),
           .cin(c[2]),
           .operation(operation),
           .result(result[32-1:24]),
           .P(p[3]),
           .G(g[3]),
	   .eq(eq[32-1:24]),
	   .cout(v)
           );
   
   assign cout = c[3];
   assign overflow = c[3] ^ v[6];
   assign Sign = eq[31] ^ v[6];
   
endmodule // alu32