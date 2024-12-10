module lshift_up(acc_data,
			lshift_out,ci_lshift);
		
	input [7:0]acc_data; //[15:0]acc_data; 
	
	output ci_lshift;
	output [7:0]lshift_out; //[15:0]lshift_out;
	
	wire [8:0]lshift_intermediate; //[16:0]lshift_intermediate;
	
	assign lshift_intermediate=acc_data<<1'b1;
	
	assign lshift_out = lshift_intermediate[7:0]; //assign lshift_out = lshift_intermediate[15:0];
	assign ci_lshift=lshift_intermediate[8]; //assign ci_lshift=lshift_intermediate[16];
		
endmodule

