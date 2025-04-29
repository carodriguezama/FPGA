module ClockDivider100(clk, clk100, dnew);
	input clk;
	input [27:0] dnew;//input is the parameter with the frequency that increases or decreases with the key button presses
	output reg clk100;
	reg [27:0] counter = 28'd0;
	
	always @(posedge clk)
		begin
			counter <= counter + 28'd1;
			
				if(counter>= (dnew-1))
					counter <= 28'd0;
					clk100 <= (counter<dnew/2)?1'b1:1'b0;
		end

endmodule
