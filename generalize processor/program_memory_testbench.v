module testbench();
	reg rstn,clk,wr_enable,rd_enable;
	reg [3:0]addr;
	reg [7:0]acc_data;
	
	wire [7:0]rd_data;
	
	prog_mem dut(.rstn(rstn),.clk(clk),.wr_enable(wr_enable),
						.rd_enable(rd_enable),.acc_data(acc_data),.rd_data(rd_data),.addr(addr));
	
	initial begin
		clk=0;
		forever begin
			#5;
			clk=~clk;
		end
	end

	initial begin
		rstn=1;
		#10;
		
		rstn=0;
		#10;
		
		wr_enable=1;rd_enable=0;addr=3;acc_data=89;#10;
		
		wr_enable=1;rd_enable=0;addr=8;acc_data=46;#10;
		
		wr_enable=0;rd_enable=1;addr=3;#10;
		
		wr_enable=1;rd_enable=0;addr=5;acc_data=23;#10;
		
		wr_enable=0;rd_enable=1;addr=5;#100;
			
		$finish;
	end

endmodule