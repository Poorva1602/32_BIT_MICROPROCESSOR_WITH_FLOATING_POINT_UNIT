module exor_up(acc_data,rd_data,
			exor_out,ci_exor);
		
	input [7:0]acc_data,rd_data; //[15:0]acc_data,rd_data;
	
	output ci_exor;
	output [7:0]exor_out; //[15:0]exor_out;
		
	assign ci_exor=1'b0;
	assign exor_out=(acc_data&~(rd_data)) | ((~acc_data)&rd_data);
	
endmodule