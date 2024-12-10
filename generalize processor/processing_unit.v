module processing_unit(clk,rstn,acc_data,rd_data,alu_op,z,
							division_wakeup,done,ci_alu,res_out);		

	input clk,rstn;
	input [7:0] acc_data,rd_data,alu_op; //[15:0]acc_data,rd_data; [7:0]alu_op;

	output reg z,ci_alu,done;
	output reg [15:0]res_out;	// [31:0]res_out;
	
	wire ci_add,bi_sub,ci_mul,ci_lshift,ci_rshift,division_wakeup; 
	wire [7:0] add_out,sub_out,mul_out,remainder,quotient; //[15:0]
	wire [7:0]not_out,or_out,and_out,exor_out,lshift_out,rshift_out; //[15:0]
	/*<-arithmetic_and_logical_module_instantiations----------------------------------------------------->*/
	adder_up add_reg(.acc_data(acc_data),.rd_data(rd_data),.add_out(add_out),.ci_add(ci_add));
	subtractor_up sub_reg(.acc_data(acc_data),.rd_data(rd_data),.sub_out(sub_out),.bi_sub(bi_sub));
	mul_up mul_reg(.acc_data(acc_data),.rd_data(rd_data),.mul_out(mul_out),.ci_mul(ci_mul));
	division div_reg(.clk(clk),.rstn(rstn),.acc_data(num1),.rd_data(num2),.division_wakeup(division_wakeup),
						.remainder(remainder),.quotient(quotient),.done(done));
	not_imm not_up(.acc_data(acc_data),.not_out(not_out),.ci_not(ci_not));
	or_up or_imm(.acc_data(acc_data),.rd_data(rd_data),.or_out(or_out),.ci_or(ci_or));
	and_up and_imm(.acc_data(acc_data),.rd_data(rd_data),.and_out(and_out),.ci_and(ci_and));
	exor_up exor_imm(.acc_data(acc_data),.rd_data(rd_data),.exor_out(exor_out),.ci_exor(ci_exor));
	rshift_up rshift_imm(.acc_data(acc_data),.rshift_out(rshift_out),.ci_rshift(ci_rshift));
	lshift_up lshift_imm(.acc_data(acc_data),.lshift_out(lshift_out),.ci_lshift(ci_lshift));
	/*<-execution_of_processing_unit_logic--------------------------------------------------------------->*/
	
	assign division_wakeup = (alu_op == 8'h04)?1'b1:1'b0; 
	
	always@(*)
	begin
		if(rstn)begin
		/*<-negative_reset----------------------------->*/
			res_out<=0;
			z<=0;
			ci_alu<=0;
			done<=0;
		end
		else begin
		case(alu_op)
			/*<-addition_operation_opcode_05----------->*/
			8'h01:begin
				res_out=add_out;
				ci_alu=ci_add;
				z=((add_out==0)?1:0);
			end
			/*<-subtraction_operation_opcode_06-------->*/			
			8'h02:
			begin
				res_out=sub_out;
				ci_alu=bi_sub;
				z=((sub_out==0)?1:0);
			end
			/*<-multiplication_operation_opcode_07----->*/
			8'h03:
			begin
				res_out=mul_out;
				ci_alu=ci_mul;
				z=((mul_out==0)?1:0);
			end
			/*<-division_operation_opcode_08----------->*/
			8'h04:
			begin
				res_out[7:0]=remainder;
				res_out[15:7]=quotient;
				z=((res_out[15:7]==0)?1:0); //z=((res_out[31:15]==0)?1:0);
				done=done;
			end					
			/*<-not_operation_opcode_09---------------->*/
			8'h05:
			begin
				res_out=not_out;
				ci_alu=ci_not;
				z=((not_out==0)?1:0);
			end
			/*<-or_operation_opcode_0A----------------->*/
			8'h06:
			begin
				res_out=or_out;
				ci_alu=ci_or;
				z=((or_out==0)?1:0);
			end	
			/*<-exor_operation_opcode_0B--------------->*/
			8'h07:
			begin
				res_out=exor_out;
				ci_alu=ci_exor;
				z=((exor_out==0)?1:0);
			end	
			/*<-and_operation_opcode_0C---------------->*/
			8'h08:
			begin
				res_out=and_out;
				ci_alu=ci_and;
				z=((and_out==0)?1:0);
			end	
			/*<-left_shift_operation_opcode_15--------->*/
			8'h09:
			begin
				res_out=lshift_out;
				ci_alu=ci_lshift;
				z=((lshift_out==0)?1:0);
			end	
			/*<-right_shift_operation_opcode_16-------->*/
			8'h0A:
			begin
				res_out=rshift_out;
				ci_alu=ci_rshift;
				z=((rshift_out==0)?1:0);
			end				
		endcase
		end
	end
 
endmodule 
