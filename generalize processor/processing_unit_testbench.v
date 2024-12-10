module processing_unit_testbench();

	reg clk,rstn;
	reg division_wakeup;
	reg [7:0] acc_data,rd_data,alu_opcode;
	
	wire z,ci_alu,done;
	wire [15:0]res_out;
	
	/*<-intantiating_with_design_module------------------------------------------------------------------------->*/
	processing_unit dut(.clk(clk),.rstn(rstn),.acc_data(acc_data),.rd_data(rd_data),.alu_opcode(alu_opcode),
							.z(z),.ci_alu(ci_alu),.division_wakeup(dividion_wakeup),.done(done),.res_out(res_out));
	/*<-clock_generation---------------------------------------------------------------------------------------->*/					
	initial begin
		clk=0;
		forever begin
			#5;
			clk=~clk;
		end
	end 
	
	initial begin
	/*<-handling_reset_signal---------------------------------------------->*/
		rstn=1;#10;
		rstn=0;
	/*<-stimulation_to_numbers_and_other_control_signals------------------->*/
	/*<-check_for_addition_operation--------------------------------------->*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h5;#10; 
		$display("output of addition,%d",res_out);
	/*<-check_for_subtraction_operation------------------------------------>*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h6;#10;
		$display("output of subtraction,%d",res_out);
	/*<-check_for_multiplication_operation--------------------------------->*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h7;#10;
		$display("output of multiplication,%d",res_out);
	/*<-check_for_not_operation-------------------------------------------->*/
		acc_data=8'b0101_1100;alu_opcode=8'h9;#10;
		$display("output of not operation,%d",res_out);
	/*<-check_for_or_operation--------------------------------------------->*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h0A;#10;
		$display("output of or operation,%d",res_out);
	/*<-check_for_exor_operation------------------------------------------->*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h0B;#10; 
		$display("output of exor operation,%d",res_out);
	/*<-check_for_and_operation-------------------------------------------->*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h0C;#10; 
		$display("output of and operation,%d",res_out);
	/*<-check_for_left_shift_operation_operation--------------------------->*/
		acc_data=8'd24;rd_data=8'd78;alu_opcode=8'h15;#10; 
		$display("output of left shift operation,%d",res_out);
	/*<-check_for_right_shift_operation_operation-------------------------->*/
		acc_data=8'd24; rd_data=8'd78; alu_opcode=8'h16;#10; 
		$display("output of right shift operation,%d",res_out);
	/*<-check_for_division_operation--------------------------------------->*/
		acc_data=8'd93; rd_data=8'd9; alu_opcode=8'h8; division_wakeup=1;#20;
		$display("output of quotient,%d",quotient);
		$display("output of remainder,%d",remainder);
	/*<-run_simulation_for_500ns------------------------------------------->*/	
		#500;	
		$finish;
	/*<-terminate_the_simulation------------------------------------------->*/		
	end
	
endmodule