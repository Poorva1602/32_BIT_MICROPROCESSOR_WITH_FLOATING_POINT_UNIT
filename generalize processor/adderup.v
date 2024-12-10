module adder_up(acc_data,rd_data,
			add_out,ci_add);
	
	input [7:0]acc_data,rd_data;
	
	output ci_add;
	output [7:0]add_out;
	
	wire [8:0]interim_add;
	
	assign interim_add = {4'd0,acc_data}+{4'd0,rd_data};
	
	assign add_out = interim_add[7:0];
	assign ci_add = interim_add[8];
	
endmodule