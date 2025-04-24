module toLetter(bcd, leds);
	input [3:0] bcd;
	output reg [6:0] leds;
	
	always@ (bcd)
	begin
		case (bcd)
			0: leds = 7'b1110111;
			1: leds = 7'b0000110;
			2: leds = 7'b1011011;
			3: leds = 7'b1001111;
			4: leds = 7'b1100110;
			5: leds = 7'b1101101;
			6: leds = 7'b1111101;
			7: leds = 7'b0000111;
			8: leds = 7'b1111111;
			9: leds = 7'b1101111;
			10: leds = 7'b1111111;
			11: leds = 7'b1111111;
			default: leds = 7'bx;
		endcase
	
	end
	
endmodule
			
			