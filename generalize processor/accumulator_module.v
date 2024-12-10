module accumulator(clk,rstn,acc_data,loadacc,selacc,immediate,rd_data,res_out);
	
	input clk,rstn,loadacc;
	input [1:0]selacc;
	input [7:0]immediate;
	input [15:0]rd_data,res_out;
	
	output [15:0]acc_data;
	
	reg [15:0]accumulator;
	
	wire [15:0]mux_out1,mux_out2;
	
	assign acc_data = (loadacc)?accumulator:16'b0;
	assign mux_out1 = (selacc[0])?rd_data:immediate;
	assign mux_out2 = (selacc[1])?res_out:mux_out1;
	
	always@(posedge clk)begin
		if(rstn)begin
			accumulator<=16'b0;
		end
		else begin
			if(loadacc)begin
				accumulator<=mux_out2;
			end
			else begin
				accumulator<=accumulator;
			end
		end
	end

endmodule