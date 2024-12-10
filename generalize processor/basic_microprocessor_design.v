module basic_microprocessor(clk,rstn);
	
	input clk,rstn; 
	
	/*<-16-bits_X_65,536_mem_loacations------------------------------->*/
	reg [15:0]program_memory[65535:0];
	/*<-addr_requires_4-bits_to_access_all_loactions_of_data_memory--->*/
	wire [7:0]addr;
	/*<-program_counter_requires_8-bits_to_access_program_memory------>*/
	/*<-also_read_data_is_16-bits------------------------------------->*/
	reg [15:0]program_counter;
	/*<-program_memory_and_instruction_register_should_have_same_size->*/
	reg [15:0]instruction_register;
	reg [15:0]accumulator;
	
	wire wr_en,rd_en,z,c;
	wire selPC,loadIR,loadPC,loadacc,incPC;
	wire [1:0]selacc;
	wire [7:0]alu_op,opcode;
	wire [15:0]acc_data,rd_data,res_out;
	
	initial begin
		$readmemh("Assembly_instructions.txt",program_memory);
	end
	
	prog_mem data_memory(.clk(clk),.rstn(rstn),.wr_en(wr_en),.rd_en(rd_en),
							.rd_data(rd_data),.acc_data(acc_data),.addr(addr));

	control_flow fsm_unit(.clk(clk),.rstn(rstn),.z(z),.c(c),.selPC(selPC),.selacc(selacc),.opcode(opcode),
								.incPC(incPC),.loadIR(loadIR),.loadPC(loadPC),.loadacc(loadacc),
									.wr_en(wr_en),.rd_en(rd_en),.alu_op(alu_op));
	
	processing_unit alu_unit(.clk(clk),.rstn(rstn),.accumulator(acc_data),.rd_data(rd_data),.alu_op(alu_op),.z(z),
							.c(ci_alu),.res_out(res_out));
	
	always@(posedge clk)begin
		if(rstn)begin
			program_counter<=0;
		end
		/*<-increment_counter_either_in_execute_or_store_state-------->*/
		else if(incPC)begin
			program_counter<=program_counter+1;
		end
		/*<-during_execute_state_for_jumping_and_mov_operations------->*/
		else if(loadPC&&!selPC&&!incPC)begin
			program_counter<=instruction_register[7:0]; //[15:0];
		end
		else if(loadPC&&selPC&&!incPC)begin
			program_counter<=rd_data;
		end
	end

	always@(posedge clk)begin
		if(rstn)begin
			instruction_register<=0;
		end
		/*<-loading_instruction_register_during_fetch_state----------->*/
		else if(loadIR==1'b1)begin
			instruction_register<=program_memory[program_counter];
		end
		/*<-instruction_remains_in_IR_during_other_FSM_states--------->*/
		else begin
			instruction_register<=instruction_register;
		end
	end
	
	always@(posedge clk)begin
		if(rstn)begin
			accumulator<=0;
		end
		/*<-immediate_value_to_accumulator---------------------------->*/
		else if(loadacc&&(selacc==2'b00))begin
			accumulator<=instruction_register[7:0];
		end
		/*<-RAM_data_to_accumulator----------------------------------->*/
		else if(loadacc&&(selacc==2'b01))begin
			accumulator<=rd_data;
		end
		/*<-output_of_alu_to_accumulator------------------------------>*/
		else if(loadacc&&(selacc==2'b1x))begin
			accumulator<=res_out;
		end
	end

endmodule