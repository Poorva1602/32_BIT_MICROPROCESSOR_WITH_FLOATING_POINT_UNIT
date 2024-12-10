module top_testbench();

	reg clk,rstn;
	
	top(.clk(clk),.rstn(rstn));
	
	initial begin
		clk=0;
		forever begin
			clk=~clk;#5;
		end
	end

	initial begin
		rstn=1;#20;
		rstn=0;#800;
		
        $display("value of accumulator,%h",acc_data);	
        //$display("data stored in R0,%h",mem[0]);
        	
		$finish;

	end

endmodule