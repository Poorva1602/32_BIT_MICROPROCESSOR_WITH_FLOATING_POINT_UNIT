module program_counter(clk,rstn,loadPC,incPC,selPC,rd_data,wire_PC);

	input clk,rstn,loadPC,incPC;
	input selPC;
	input [7:0]immediate;
	input [15:0]rd_data;

	reg [15:0]program_counter;
	
	wire [15:0]mux_out

	output [15:0]wire_PC;
	/*
	input [15:0]immediate;
	input [31:0]rd_data;

	reg [31:0]program_counter;
	
	wire [31:0]mux_out

	output [31:0]wire_PC;
	*/
	
	assign mux_out = (selPC)?rd_data:immediate;
	assign wire_PC = program_counter;
	
	always@(posedge clk)begin
		if(rstn)begin
			program_counter<=0;
		end
		else begin
			if(incPC)begin
				program_counter<=program_counter+1;
			end
			else if(loadPC&&!selPC&&!incPC)begin
				program_counter<=immediate;
			end
			else if(loadPC&&selPC&&!incPC)begin
				program_counter<=rd_data;
			end
			else begin
				program_counter<=program_counter;
			end
		end
	end
	
endmodule