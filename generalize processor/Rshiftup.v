module rshift_up(acc_data,
			rshift_out,ci_rshift);
		
	input [7:0]acc_data;
	
	output ci_rshift;
	output [7:0]rshift_out;
	
	wire [8:0]rshift_intermediate;
	
	assign rshift_intermediate=acc_data>>1'b1;
	
	assign rshift_out = rshift_intermediate[7:0];
	assign ci_rshift=rshift_intermediate[8];
	/*
	input [15:0]acc_data;
	
	output ci_rshift;
	output [15:0]rshift_out;
	
	wire [16:0]rshift_intermediate;
	
	assign rshift_intermediate=acc_data>>1'b1;
	
	assign rshift_out = rshift_intermediate[15:0];
	assign ci_rshift=rshift_intermediate[16];
	*/
		
endmodule

