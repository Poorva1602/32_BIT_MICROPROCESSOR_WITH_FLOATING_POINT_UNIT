module division_testbench();

	reg clk,rstn,division_wakeup;
	reg [7:0] num1,num2;
	
	wire done;
	wire [7:0] remainder,quotient;
	
	/*<-intantiating_with_design_module---------------------------------------------->*/
	division dut(.clk(clk),.rstn(rstn),.num1(num1),.num2(num2),.remainder(remainder),
					.quotient(quotient),.division_wakeup(division_wakeup),.done(done));
					
	/*<-clock_generation-------------------------------->*/
	initial begin
		clk=0;
		forever begin
			#5;
			clk=~clk;
		end
	end
	
	/*<-handling_reset_signal--------------------------->*/
	initial begin
		rstn=1;#10;
		rstn=0;
	/*<-loaded_numbers_and_wakeup_signal_at_a_same_time->*/	
		num1=8'b0000_1101;
		num2=8'b0000_0011;		
		division_wakeup=1;#20;
	/*<-wakeup_signal_off_after_2_clock_cycles---------->*/
		division_wakeup=0;
	/*<-run_simulation_for_1000ns----------------------->*/	
		#1000;	
		$finish;
	/*<-terminate_the_simulation------------------------>*/
	end
	
endmodule
