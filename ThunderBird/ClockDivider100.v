module ClockDivider100(clk, clk100);
	input clk;
	output reg clk100;
	reg [27:0] counter = 28'd0;
	parameter dnew = 500000;
	
	always @(posedge clk)
		begin
			counter <= counter + 28'd1;
			
				if(counter>= (dnew-1))
					counter <= 28'd0;
					clk100 <= (counter<dnew/2)?1'b1:1'b0;
		end

endmodule
