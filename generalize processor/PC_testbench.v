module PC_testbench();
	
	reg clk,rstn,loadPC,incPC;
	reg selPC;
	reg [7:0]immediate;
	reg [15:0]rd_data;
	
	wire [15:0]wire_PC;

	accumulator dut(.clk(clk),.rstn(rstn),.loadPC(loadPC),.incPC(incPC),.selPC(selPC),.rd_data(rd_data),.wire_PC(wire_PC));
		
	initial begin
		clk=0;
		forever begin
			clk=~clk;#5;
		end
	end

	initial begin
		rstn=1;#10;
		rstn=0;#10;
		/*<----load_immediate_into_program_counter----------->*/
		immediate=8'd5;selPC=0;loadPC=1;incPC=0;#10;
		$display("output of program counter",wire_PC);
		//$display("data stored in accumulator",acc_data);
		
		/*<----load_rd_data_into_program_counter------------->*/
		rd_data=8'd8;selPC=1;loadPC=1;#20;
		$display("output of program counter",wire_PC);
		//$display("data stored in accumulator",acc_data);
		
		/*<----normal_increment_of_program_counter------------->*/
		incPC=1;#100;
		$display("output of program counter",wire_PC);
		//$display("data stored in accumulator",acc_data);
		$finish;
	end

endmodule
