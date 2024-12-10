module or_up(acc_data,rd_data,
			or_out,ci_out);
		
	input [7:0]acc_data,rd_data;
	
	output ci_or;
	output [7:0]or_out;
	/*
	input [15:0]acc_data,rd_data;
	
	output ci_or;
	output [15:0]or_out;
	*/
		
	assign ci_or=1'b0;
	assign or_out=acc_data|rd_data;
	
endmodule