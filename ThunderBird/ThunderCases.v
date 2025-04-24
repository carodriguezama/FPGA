module ThunderCases(Clock, state, LEDn, ctn, h0, h1, h2, h3, h4, h5);
	input Clock;
	input [1:0] state;
	input [7:0] ctn;
	output wire [9:0] LEDn;
	output wire [7:0] h0;
	output wire [7:0] h1;
	output wire [7:0] h2;
	output wire [7:0] h3;
	output wire [7:0] h4;
	output wire [7:0] h5;

	reg [9:0] LED;
	reg [7:0] a0;
	reg [7:0] a1;
	reg [7:0] a2;
	reg [7:0] a3;
	reg [7:0] a4;
	reg [7:0] a5;

	always@ (posedge Clock)
	//under each if statement use the toLetter module to print the state in the segment display
		begin
		
		if(state == 0)
		begin
				//led pattern
				LED[9:0] <= 10'b0000000000;
				//decimal values for the segment display
				a0 <= 121;
				a1 <= 6;
				a2 <= 94;
				a3 <= 6;
				a4 <= 0;
				a5 <= 0;
		end
			
			else if(state == 1)
			begin
				//different pattern for each counter 
				if(ctn <20)
				LED[9:0] <= 10'b0001000000;
				else if(ctn <40)
				LED[9:0] <= 10'b0011000000;
				else if(ctn<60)
				LED[9:0] <= 10'b0111000000;
				else if(ctn<=80)
				LED[9:0] <= 10'b1111000000;
				a0 <= 78;
				a1 <= 113;
				a2 <= 121;
				a3 <= 6;
				a4 <= 0;
				a5 <= 0;				
			end
			
			else if(state == 2)
			begin
				if(ctn <20)
				LED[9:0] <= 10'b0000001000;
				else if(ctn <40)
				LED[9:0] <= 10'b0000001100;
				else if(ctn<60)
				LED[9:0] <= 10'b0000001110;
				else if(ctn<=80)
				LED[9:0] <= 10'b0000001111;
				a0 <= 78;
				a1 <= 116;
				a2 <= 103;
				a3 <= 6;
				a4 <= 49;
				a5 <= 0;
			end
			
			else if(state == 3)
			begin
				//use the counter to flash
				if(ctn<20)
				LED[9:0] <= 10'b1111001111;
				else if(ctn>20)
				LED[9:0] <= 10'b0000000000;
				
				a0 <= 94;
				a1 <= 49;
				a2 <= 119;
				a3 <= 91;
				a4 <= 119;
				a5 <= 118;
			end
			
			else 
			
				LED[9:0] <= 10'b1000000001;
			
		end
		//update everything

		assign LEDn = LED;
		assign h0 = a0;
		assign h1 = a1;
		assign h2 = a2;
		assign h3 = a3;
		assign h4 = a4;
		assign h5 = a5;
		
endmodule
		