module top();

	reg [15:0]program_memory[0:15];
	
	initial begin
		$readmemh("assembly_instructions.txt",program_memory);
	end

endmdule