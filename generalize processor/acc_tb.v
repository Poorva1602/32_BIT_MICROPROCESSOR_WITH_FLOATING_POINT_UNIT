module accumulator_testbench();
	
	reg clk,rstn,loadacc;
	reg [1:0]selacc;
	reg [7:0]immediate;
	reg [15:0]rd_data,res_out;
	
	wire [15:0]acc_data;

	accumulator dut(.clk(clk),.rstn(rstn),.acc_data(acc_data),.loadacc(loadacc),.selacc(selacc),
						.immediate(immediate),.rd_data(rd_data),.res_out(res_out));
		
	initial begin
		clk=0;
		forever begin
			clk=~clk;#5;
		end
	end

	initial begin
		rstn=1;#10;
		rstn=0;#10;
		/*<----load_immediate_into_accumulator----------->*/
		immediate=8'd90;selacc=2'b00;loadacc=1;#10;
		$display("output of accumulator",acc_data);
		$display("data stored in accumulator",acc_data);
		
		/*<----load_rd_data_into_accumulator------------->*/
		rd_data=8'd78;selacc=2'b01;loadacc=1;#20;
		$display("output of accumulator",acc_data);
		$display("data stored in accumulator",acc_data);
		
		/*<----load_res_out_into_accumulator------------->*/
		res_out=16'd9998;selacc=2'b10;loadacc=1;#20;
		$display("output of accumulator",acc_data);
		$display("data stored in accumulator",acc_data);
		$finish;
	end

endmodule
