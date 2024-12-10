 module control_flow(clk,rstn,z,c,selPC,selacc,incPC,opcode,
						done,loadIR,loadPC,loadacc,wr_en,rd_en,alu_op);

	input clk,rstn,z,c,done;
	input [7:0]opcode; 

	output reg selPC,loadIR,loadPC,wr_en,rd_en,loadacc,incPC; 
	output reg[1:0]selacc;
	output reg[7:0]alu_op;
	
	reg [2:0]fsm_state;
	
	parameter idle = 3'd0;
	parameter fetch = 3'd1;
	parameter decode = 3'd2;
	parameter execute = 3'd3;
	parameter store = 3'd4;
		
	always@(fsm_state)begin
		if(rstn)begin
			selPC<=0;loadIR<=0;loadPC<=0;loadacc<=0;wr_en<=0;rd_en<=0;selacc<=0;alu_op<=0;
		end
		else begin
			if (fsm_state == fetch)begin
				/*<-load_the_instruction_register----------------->*/
				loadIR<=1;incPC<=0;selPC<=0;loadPC<=0;loadacc<=0;wr_en<=0;rd_en<=0;selacc<=0;alu_op<=0;
			end
			else if(fsm_state == decode)begin
				case(opcode)
				/*<-ALU_instruction------------------------------->*/
				8'h01:begin/*<-addition--------------------------->*/
					rd_en<=1;alu_op<=8'h01;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h02:begin/*<-subtractor------------------------->*/
					rd_en<=1;alu_op<=8'h02;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h03:begin/*<-multiplication--------------------->*/
					rd_en<=1;alu_op<=8'h03;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h04:begin/*<-division--------------------------->*/
					rd_en<=1;alu_op<=8'h04;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h05:begin/*<-not-------------------------------->*/
					rd_en<=1;alu_op<=8'h05;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h06:begin/*<-or--------------------------------->*/
					rd_en<=1;alu_op<=8'h06;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h07:begin/*<-exor------------------------------->*/
					rd_en<=1;alu_op<=8'h07;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h08:begin/*<-and-------------------------------->*/
					rd_en<=1;alu_op<=8'h08;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h09:begin/*<-lshift----------------------------->*/
					rd_en<=1;alu_op<=8'h09;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				8'h0A:begin/*<-rshift----------------------------->*/
					rd_en<=1;alu_op<=8'h0A;selacc<=2'b1x;loadacc<=1;loadIR<=0;
				end
				
				/*<-non_ALU_instruction------------------------------------------------------------------------------------------->*/
				8'h81:begin/*<-MOV_imm-->*/
					selacc<=2'b00;loadacc<=1;loadIR<=0;alu_op<=0;
				end
				8'h82:begin/*<-MOV_addr->*/
					rd_en<=1;selacc<=2'b10;loadacc<=1;loadIR<=0;
				end
				8'h83:begin/*<-wr_en---->*/
					loadacc<=1;wr_en<=1;loadIR<=0;
				end
				8'h84:begin/*<-rd_en---->*/
					rd_en<=1;selacc<=2'b10;loadacc<=1;loadIR<=0;
				end
				8'h85:begin/*<-JC_imm--------------------------------------------------------------------------------------------->*/
					if(c==1'b1)begin
						selPC<=0;loadPC<=1;incPC<=0;loadIR<=0;
					end
					else begin
						incPC<=1;loadIR<=0;
					end
				end	
				8'h86:begin/*<-JC_addr-------------------------------------------------------------------------------------------->*/
					if(c==1'b1)begin
						selPC<=1;loadPC<=1;incPC<=0;rd_en<=1;loadIR<=0;
					end
					else begin
						incPC<=1;loadIR<=0;
					end						
				end
				8'h87:begin/*<-JZ_imm--------------------------------------------------------------------------------------------->*/
					if(z==1'b1)begin
						selPC<=0;loadPC<=1;incPC<=0;loadIR<=0;
					end
					else begin
						incPC<=1;loadPC<=0;loadIR<=0;
					end
				end
				8'h88:begin/*<-JZ_addr--------------------------------------------------------------------------------------------->*/
					if(z==1'b1)begin
						selPC<=1;loadPC<=1;incPC<=0;rd_en<=1;loadIR<=0;
					end
					else begin
						incPC<=1;loadPC<=0;loadIR<=0;
					end
				end
				8'h89:begin/*<-JNC_imm---------------------------------------------------------------------------------------------->*/
					if(c==1'b0)begin
						selPC<=0;loadPC<=1;incPC<=0;loadIR<=0;
					end
					else begin
						incPC<=1;loadPC<=0;loadIR<=0;
					end
				end
				8'h8A:begin/*<-JNC_addr--------------------------------------------------------------------------------------------->*/
					if(c==1'b0)begin
						selPC<=1;loadPC<=1;incPC<=0;rd_en<=1;loadIR<=0;
					end
					else begin
						incPC<=1;loadPC<=0;loadIR<=0;
					end
				end
				8'h8B:begin/*<-JNZ_imm----------------------------------------------------------------------------------------------->*/
					if(z==1'b0)begin
						selPC<=0;loadPC<=1;incPC<=0;loadIR<=0;
					end
					else begin
						incPC<=1;loadPC<=0;loadIR<=0;
					end
				end
				8'h8C:begin/*<-JNZ_addr----------------------------------------------------------------------------------------------->*/
					if(z==1'b0)begin
						selPC<=1;loadPC<=1;incPC<=0;rd_en<=1;loadIR<=0;
					end
					else begin
						incPC<=1;loadPC<=0;loadIR<=0;
					end
				end
				default:begin/*<------------------------------------------------------------------------------------------------------>*/
					selPC<=selPC;loadIR<=loadIR;loadPC<=loadPC;loadacc<=loadacc;wr_en<=wr_en;rd_en<=rd_en;selacc<=selacc;alu_op<=alu_op;						
				    end
				endcase
			end
			else if(fsm_state == store)begin
				incPC<=1;
			end
			else begin
				selPC<=selPC;loadIR<=loadIR;loadPC<=loadPC;loadacc<=loadacc;wr_en<=wr_en;rd_en<=rd_en;selacc<=selacc;alu_op<=alu_op;
			end
		end
	end
	
	always@(posedge clk)begin
		if(rstn)begin
			fsm_state<=0;
		end
		else begin
			case(fsm_state)
			idle:begin
				if(rstn)begin
					fsm_state<=idle;
				end
				else begin
					fsm_state<=fetch;
				end
			end
			fetch:begin
				fsm_state<=decode;
			end
			decode:begin
				fsm_state<=(opcode[7]==1)?fetch:execute;
			end
			execute:begin
				fsm_state<=(opcode==8'h04)?(done?store:execute):(store);
			end
			store:begin	
				fsm_state<=fetch;
			end
			default:begin
					fsm_state<=fsm_state;
				end
			endcase
		end
	end
  
endmodule