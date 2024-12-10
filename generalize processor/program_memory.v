module prog_mem(clk,rstn,wr_en,rd_en,
							rd_data,acc_data,addr);

//////////////////////////////////////////////////////////
	input clk,rstn,wr_en,rd_en; //from driver in fetech stage
	input [3:0]addr; // [7:0]addr;		   //from IR.
	input [7:0]acc_data; //[15:0]acc_data;     //from accumulator.
 
	output reg[7:0]rd_data;	//reg[15:0]rd_data;   //to alu.
	
	reg [15:0]mem[0:15]; //reg [31:0]mem[0:31];
	reg [4:0]i; // reg [5:0];

//////////////////////////////////////////////////////////	
	always @(posedge clk)
	begin
/*------------------------------------------------------*/	
		if(rstn)begin
			for(i=0;i<5'd16;i=i+1)
			begin
				mem[i]<=0;
				rd_data<=0;
			end
		end
/*------------------------------------------------------*/		
		else 
		begin
			if(wr_en && !rd_en)begin
	 			mem[addr]<=acc_data;
				rd_data<=0;
			end
/*------------------------------------------------------*/
			else if(!wr_en && rd_en)begin
				rd_data<=mem[addr];
			end
			else begin
				rd_data<=0;
			end
		end	
	end
//////////////////////////////////////////////////////////	
endmodule
