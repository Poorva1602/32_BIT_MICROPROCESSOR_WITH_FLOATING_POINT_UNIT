module and_up(acc_data,rd_data,
			and_out,ci_and);
		
	input [7:0]acc_data,rd_data;
	
	output ci_and;
	output [7:0]and_out;
		
	assign ci_and=1'b0;
	assign and_out=acc_data&rd_data;
	
endmodule