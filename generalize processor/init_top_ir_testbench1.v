module testbench1();

	reg clk,rstn,loadIR;
	reg [15:0]program_counter;
	
	top dut(.clk(clk),.rstn(rstn),.program_counter(program_counter),.loadIR(loadIR));
	
	initial begin
		clk=0;
		forever clk=~clk;#5;
	end
	
	initial begin
		rstn=1;program_counter=0;loadIR=0;#10;
		rstn=0;loadIR=1;#10;
		program_counter=0;#10;
		program_counter=1;#10;
		program_counter=2;#10;
		program_counter=3;#10;
		$finish;
	end

endmodule