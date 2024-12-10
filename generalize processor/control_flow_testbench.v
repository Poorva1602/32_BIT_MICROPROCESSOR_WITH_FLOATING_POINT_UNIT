module control_flow_testbench();

	reg clk,rstn,z,c;
	reg [7:0]opcode;
	
	wire selPC,loadIR,loadPC,wr_en,rd_en,loadacc,incPC;
	wire [1:0]selacc;
	wire [7:0]alu_op;
	
	control_flow dut(.clk(clk),.rstn(rstn),.z(z),.c(c),.opcode(opcode),.selPC(selPC),.selacc(selacc),.incPC(incPC),
						.loadIR(loadIR),.loadPC(loadPC),.loadacc(loadacc),.wr_en(wr_en),.rd_en(rd_en),.alu_op(alu_op));
						
	initial begin
		clk=0;
		forever begin
			clk=~clk;#5;
		end
	end

	initial begin
		rstn=1;#10;
		rstn=0;
		/*<-each_instruction_requires_4_clock_cycle_to_complete->*/
		/*<-check_for_add_operation--------->*/
		opcode=8'h1;#40;
		/*<-check_for_sub_operation--------->*/
		opcode=8'h2;#40;
		/*<-check_for_mul_operation--------->*/
		opcode=8'h3;#40;
		/*<-check_for_not_operation--------->*/
		opcode=8'h5;#40;
		/*<-check_for_or_operation---------->*/
		opcode=8'h6;#40;
		/*<-check_for_exor_operation-------->*/
		opcode=8'h7;#40;
		/*<-check_for_and_operation--------->*/
		opcode=8'h8;#40;
		/*<-check_for_left_shift_operation-->*/
		opcode=8'h9;#40;
		/*<-check_for_right_shift_operation->*/
		opcode=8'h0A;#40;
		
		/*<-check_for_mov_imm_operation----->*/
		opcode=8'h81;#20;
		/*<-check_for_mov_addr_operation---->*/
		opcode=8'h82;#20;
		/*<-check_for_wr_en_operation------->*/
		opcode=8'h83;#20;
		/*<-check_for_rd_en_operation------->*/
		opcode=8'h84;#20;
		
		/*<-check_for_JC_imm_operation------>*/
		opcode=8'h85;c=1'b1;#20;
		/*<-check_for_JC_imm_operation------>*/
		opcode=8'h85;c=1'b0;#20;
		/*<-check_for_JC_addr_operation----->*/
		opcode=8'h86;c=1'b1;#20;
		/*<-check_for_JC_addr_operation----->*/
		opcode=8'h86;c=1'b0;#20;
		
		/*<-check_for_JZ_imm_operation------>*/
		opcode=8'h87;z=1'b1;#20;
		/*<-check_for_JZ_imm_operation------>*/
		opcode=8'h87;z=1'b0;#20;
		/*<-check_for_JZ_addr_operation----->*/
		opcode=8'h88;z=1'b1;#20;
		/*<-check_for_JZ_addr_operation----->*/
		opcode=8'h88;z=1'b0;#20;
		
		/*<-check_for_JNC_imm_operation----->*/
		opcode=8'h89;c=1'b0;#20;
		/*<-check_for_JNC_imm_operation----->*/
		opcode=8'h89;c=1'b1;#20;
		/*<-check_for_JNC_addr_operation---->*/
		opcode=8'h8A;c=1'b0;#20;
		/*<-check_for_JNC_addr_operation---->*/
		opcode=8'h8A;c=1'b1;#20;
		
		/*<-check_for_JNZ_imm_operation----->*/
		opcode=8'h8B;z=1'b0;#20;
		/*<-check_for_JNZ_imm_operation----->*/
		opcode=8'h8B;z=1'b1;#20;
		/*<-check_for_JNZ_addr_operation---->*/
		opcode=8'h8C;z=1'b0;#20;
		/*<-check_for_JNZ_addr_operation---->*/
		opcode=8'h8C;z=1'b1;#20;
	$finish;
	end
endmodule
