module RodriguezProject(
	input clk,
	input [3:0]SW,
	output [3:0]LED
	);
	assign LED = SW[0];
	
endmodule
