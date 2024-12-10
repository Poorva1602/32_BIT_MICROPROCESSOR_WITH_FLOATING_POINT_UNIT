module subtraction_testbench();
	
	reg [7:0]acc_data,rd_data;
	
	wire bi_sub;
	wire [7:0]sub_out;
	
	subtractor_up dut(.acc_data(acc_data),.rd_data(rd_data),
							.sub_out(sub_out),.bi_sub(bi_sub));
	
	/*<-stimulating_signals----------------------------->*/
	initial begin
	/*<-loaded_numbers---------------------------------->*/	
		acc_data=8'd45;rd_data=8'd23;#10;		
	/*<-loaded_numbers---------------------------------->*/
		acc_data=8'd23;rd_data=8'd45;#10;	
	/*<-terminate_the_simulation------------------------>*/
		$finish;
	end
	
	/*
	reg [15:0]acc_data,rd_data;
	
	wire bi_sub;
	wire [7:0]sub_out;
	
	subtractor_up dut(.acc_data(acc_data),.rd_data(rd_data),
							.sub_out(sub_out),.bi_sub(bi_sub));
	
	/*<-stimulating_signals----------------------------->*/
	initial begin
	/*<-loaded_numbers---------------------------------->*/	
		acc_data=8'd45;rd_data=8'd23;#10;		
	/*<-loaded_numbers---------------------------------->*/
		acc_data=8'd23;rd_data=8'd45;#10;	
	/*<-terminate_the_simulation------------------------>*/
		$finish;
	end
	*/
	
endmodule