module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
/* Write your code HERE */

    /*input   src1, src2, select;
    output  result;

    wire    src1, src2, select;
    reg     result;*/

    always @( src1, src2, select ) begin
        if( !select )
            result <= src1;
        else
            result <= src2;
    end

endmodule
