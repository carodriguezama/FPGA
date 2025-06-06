module reaction2(Clock, state, FLAG, LEDn, Digit1, Digit0);
	input Clock;
	input [1:0] state;
	output reg FLAG;
	output wire [9:0] LEDn;
	output wire [6:0] Digit1, Digit0;

	reg [9:0] LED;
	reg [3:0] BCD1, BCD0;
	reg [9:0] k;
	reg [9:0] myRand;

	always@ (posedge Clock)
		begin
		
		if(state == 0)
			begin
				LED[9:0] <= 10'b0000000000;
				BCD1 <= 0;
				BCD0 <= 0;
				FLAG <= 0;
				k <= 0;
				myRand <= myRand + 11;
			end
			else if(state == 1)
			begin
				LED[9:0] <= 10'b1000000000;
					BCD1 <= 0;
				BCD0 <= 0;
				myRand <= myRand;
				k<= k +1;
				
				if(k>myRand%400)
				FLAG <= 1;
				else FLAG <=0;
			end
			
			else if(state == 2)
			begin
				LED[9:0] <= 10'b1111111111;
				FLAG = 0;
				k <= 0;
				myRand <= myRand;
				
				if(BCD0 == 4'b1001)
					begin
						BCD0 <= 0;
						if(BCD1 == 4'b1001)
						BCD1 <= 0;
						else 
							BCD1 <= BCD1 + 1;
					end
				else 
					BCD0 <= BCD0 + 1;
			end
			
			else if(state == 3)
			begin
				LED[9:0] <= 10'b1010101010;
				BCD0 <= BCD0;
				BCD1 <= BCD1;
				FLAG <= 0;
				k<= 0;
				myRand <= myRand;
			end
			
			else 
			begin
				LED[9:0] <= 10'b1000000001;
				BCD0 <= 4'b1000;
				BCD1 <= 4'b1000;
				FLAG <= 0;
				k <= 0;
				myRand <= myRand;
			end
		end

		assign LEDn = LED;
		
		seg7 seg1(BCD1, Digit1);
		seg7 seg0(BCD0, Digit0);
endmodule
		