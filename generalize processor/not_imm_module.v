module not_imm(acc_data,not_out,ci_not);

	input [7:0]acc_data;
	
	output ci_not;
	output[7:0]not_out;
	/*
	input [15:0]acc_data;
	
	output ci_not;
	output[15:0]not_out;
	*/
	
	assign not_out=~acc_data;
	assign ci_not = 0;
	
endmodule