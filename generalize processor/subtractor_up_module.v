module subtractor_up(acc_data,rd_data,
						sub_out,bi_sub);

	input [7:0]acc_data,rd_data;

	output bi_sub;
	output [7:0]sub_out;

	wire [7:0] twos_compliment;
	wire [8:0] intermediate_add;
	wire [7:0] ones_complement;
	wire [7:0] final_intermediate;
	
	/*<-step_one_of_binary_subtraction------------------------------------------------>*/
	assign twos_compliment = (~rd_data)+1'b1;
	/*<-2's_compliment_of_rd_data_performed------------------------------------------->*/
	/*<-step_two_of_binary_subtraction------------------------------------------------>*/
	assign intermediate_add = acc_data+twos_compliment;
	/*<-step_three_of_binary_subtraction---------------------------------------------->*/
	/*<-focus_on_carry---------------------------------------------------------------->*/
	assign ones_complement=~intermediate_add[7:0];
	assign final_intermediate=ones_complement+1;
	assign bi_sub=(intermediate_add[8]==1)?(1'b0):(1'b1);
	assign sub_out=(intermediate_add[8]==1)?(intermediate_add[7:0]):(final_intermediate);

endmodule