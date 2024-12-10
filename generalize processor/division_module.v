 module division(clk,rstn,num1,num2,division_wakeup,remainder,quotient,done);

	input clk,rstn,division_wakeup;
	input [7:0]num1,num2; //[15:0]num1,num2;
	
	output done;
	output [7:0]remainder,quotient; //[15:0]remainder,quotient;
	
	wire [15:0]internal_acc;  //[31:0]internal_acc;
	
	reg [1:0] division_state; /*00/0-idle, 01/1-load, 10/2-exec, 11/3-store*/
	reg [7:0] quo_intermediate; //[15:0]quo_intermediate;
	reg [7:0] rem_intermediate; //[15:0]rem_intermediate;
	reg [15:0] acc_intermediate; //[31:0]acc_intermediate;
	
	/*<-logic_implementation_begin_here------------------------------------------------------------------------------>*/
	
	assign internal_acc = {8'd0,num1}; //{15'd0,num1};
	
	always @(posedge clk)begin
		/*<-idle_state---------------------------------------------->*/
		if(rstn)begin
			acc_intermediate<=0;
			quo_intermediate<=0; 	
		end
		/*<-load_state---------------------------------------------->*/
		else if(division_state == 2'd1)begin 
			acc_intermediate<=internal_acc; /*intializing accumulator*/
			quo_intermediate<=0; /*initializing quotient*/
		end
		/*<-compute_state------------------ -------------------------------------------------------------------------->*/
		else begin
			if( ((acc_intermediate[15:8] == num2) || (acc_intermediate[15:8] > num2)) && (division_state == 2'd2) )begin
		//  if( ((acc_intermediate[31:16] == num2) || (acc_intermediate[31:16] > num2)) && (division_state == 2'd2) )begin
			/*<-if_dividend_is_greater_or_equal_to_divisor----------------------------------------------------------->*/
				acc_intermediate[15:8] <= acc_intermediate[15:8] - num2;
			//  acc_intermediate[31:16] <= acc_intermediate[31:16] - num2;
				quo_intermediate[0] <= 1'b1;
			end
			else if( (acc_intermediate[15:8] < num2) && (division_state == 2'd2) && (acc_intermediate[7:0]!=0))begin
		//  else if( (acc_intermediate[31:16] < num2) && (division_state == 2'd2) && (acc_intermediate[15:0]!=0))begin
			/*<-if_dividend_is_lesser_than_divisor_so_shift_acc_intermediate_&_quo_intermediate---------------------->*/
				acc_intermediate <= acc_intermediate << 1'b1;
				quo_intermediate <= quo_intermediate << 1'b1;
			end
			else begin
			/*<-by_default_execution_if_non_is_satisfied------------------------------------------------------------->*/
				acc_intermediate <= internal_acc;
				quo_intermediate <= quo_intermediate;
			end
		end
	end
	
	/*<-separte_condition_for_remainder_intermediate_register_else_it_gives_new_loaded_value_of_acc_intermediate[15:8]--
	----in_the_next_iteration_of_FSM_states-------------------------------------------------------------------------->*/
	
	always @(posedge clk)begin
	   if(rstn)begin
	       rem_intermediate<=0;
	   end
	   else begin
	       rem_intermediate<=acc_intermediate[15:8]; //acc_intermediate[31:16];
	   end
	end
	
	/*<-upadating_final_values_in_assign_statements_during_store_state----------------------------------------------->*/
	assign done = (division_state == 2'd3)?1'd1:1'd0;
	assign quotient = (division_state == 2'd3)?quo_intermediate:quotient;
	assign remainder = (division_state == 2'd3)?rem_intermediate:remainder;

	/*<-tracking_states --------------------------------------------------------------->*/
	always @(posedge clk)begin
		if(rstn)
		begin
			division_state <= 0;
		end
		/*<-reset_condition_satisfied------------------------------------------------->*/
		else begin
			case(division_state)
		/*<-idle_state---------------------------------------------------------------->*/	
			2'd0:
			begin
				if(division_wakeup)begin
					division_state<=2'd1;
					end
				else begin
					division_state<=division_state;
				end
			end
		/*<-load_state_requires_one_clock_cycle---------------------------------------->*/	
			2'd1:
			begin
				division_state<=2'd2;
			end
		/*<-compute_state-------------------------------------------------------------->*/
			2'd2:
			begin
				if( (acc_intermediate[7:0] == 0) && (acc_intermediate[15:8] < num2) )begin
			//  if( (acc_intermediate[15:0] == 0) && (acc_intermediate[31:16] < num2) )begin
					division_state<=2'd3;
				end
				else begin
					division_state<=2'd2;
				end
			end
		/*<-store_state_computation_done----------------------------------------------->*/	
			2'd3:
			begin
				if(division_wakeup)begin
					division_state<=2'd1;
				end
				else begin
					division_state<=2'd0;
				end
			end
		/*<-default_condition---------------------------------------------------------->*/	
			default: begin
				division_state<=division_state;
			end
			endcase
		end
	/*<-fsm_logic_finishes_here-------------------------------------------------------->*/	
	end

endmodule
