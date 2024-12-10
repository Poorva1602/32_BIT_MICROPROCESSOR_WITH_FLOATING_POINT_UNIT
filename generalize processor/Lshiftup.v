module Lshift_up(acc_data,
				res_out_alu,c);
		
	input [7:0]acc_data; //[15:0]acc_data;
	
	output c;
	output [7:0]res_out_alu; //[15:0]res_out_alu;
	
	assign res_out_alu=acc_data<<1'b1; 
	assign c=0;
		
endmodule