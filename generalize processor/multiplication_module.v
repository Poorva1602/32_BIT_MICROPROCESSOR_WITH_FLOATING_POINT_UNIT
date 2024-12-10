module mul_up(acc_data,rd_data,
			mul_out,ci_mul);
	
	input [7:0]acc_data,rd_data; 
	
	output ci_mul;
	output [7:0]mul_out; 
	
	wire [16:0]interim_mul; 
	
	assign interim_mul = {8'd0,acc_data}*{8'd0,rd_data}; 
	
	assign mul_out = interim_mul[15:0]; 
	assign ci_mul = interim_mul[16];
	/*
	input [15:0]acc_data,rd_data; 
	
	output ci_mul;
	output [15:0]mul_out; 
	
	wire [32:0]interim_mul; 
	
	assign interim_mul = {16'd0,acc_data}*{16'd0,rd_data}; 
	
	assign mul_out = interim_mul[31:0]; 
	assign ci_mul = interim_mul[32];
	*/
	
endmodule