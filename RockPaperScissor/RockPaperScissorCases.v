module RockPaperScissorCases(Clock, state, fpgachoice, LEDn, choice, h0, h1, h2, h3 , h4, h5, ctn, score,wins,losses);
	input Clock;
	input [1:0] state;
	input [1:0] score;
	input [2:0] choice;
	input [7:0] ctn;
	input [7:0] fpgachoice;
	input [3:0] wins;
	input [3:0] losses;
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
		begin
		
		if(state == 0)
			begin
			//in the idle state display the score
			//display wins on the left side
				LED[9:0] <= 10'b0000000000;
				a1 <= 64;
				a3<=0;
				a4<=0;
				a5<=0;
				if(wins == 0)
				a2 <= 7'b0111111;
				if(wins == 1)
				a2 <= 7'b0000110;
				if(wins == 2)
				a2 <= 7'b1011011;
				if(wins == 3)
				a2 <= 7'b1001111;
				if(wins == 4)
				a2 <= 7'b1100110;
				if(wins == 5)
				a2 <= 7'b1101101;
				if(wins == 6)
				a2 <= 7'b1111101;
				if(wins == 7)
				a2<= 7'b0000111;
				if(wins == 8)
				a2 <= 7'b1111111;
				if(wins == 9)
				a2<= 7'b1101111;
				if(losses == 0)
				a0 <= 7'b0111111;
				if(losses == 1)
				a0 <= 7'b0000110;
				//display losses on the right side
				if(losses == 2)
				a0 <= 7'b1011011;
				if(losses == 3)
				a0 <= 7'b1001111;
				if(losses == 4)
				a0 <= 7'b1100110;
				if(losses == 5)
				a0 <= 7'b1101101;
				if(losses == 6)
				a0 <= 7'b1111101;
				if(losses == 7)
				a0<= 7'b0000111;
				if(losses == 8)
				a0 <= 7'b1111111;
				if(losses == 9)
				a0<= 7'b1101111;
				
			end
			else if(state == 1)
			begin
			//display fpga choice
				LED[9:0] <= 10'b1000000000;
				if(fpgachoice<19)//rock
				begin
				a0 <= 57;
				a1 <= 57;
				a2 <= 63;
				a3 <= 49;
				a4 <= 0;
				a5 <= 0;
				end
				else if(fpgachoice<39)//paper
				begin
				a0 <= 49;
				a1 <= 121;
				a2 <= 115;
				a3 <= 119;
				a4 <= 115;
				a5 <= 0;
				end
				else if(fpgachoice<59)//scissor
				begin
				a0 <= 49;
				a1 <= 63;
				a2 <= 109;
				a3 <= 6;
				a4 <= 57;
				a5 <= 109;
				end
				else if(fpgachoice<79)//lizard
				begin
				a0 <= 94;
				a1 <= 49;
				a2 <= 119;
				a3 <= 109;
				a4 <= 6;
				a5 <= 56;
				end
				else if(fpgachoice<99)//spiock
				begin
				a0 <= 57;
				a1 <= 57;
				a2 <= 63;
				a3 <= 115;
				a4 <= 109;
				a5 <= 0;
				end
			end
			
			else if(state == 2)
			begin
			//Make LEDs scroll if win
			if(score == 1)
			begin
			if(ctn < 10)
			LED[9:0] <= 10'b1000000000;
			else if(ctn < 20)
			LED[9:0] <= 10'b0100000000;
			else if(ctn < 30)
			LED[9:0] <= 10'b0010000000;
			else if(ctn < 40)
			LED[9:0] <= 10'b0001000000;
			else if(ctn < 50)
			LED[9:0] <= 10'b0000100000;
			else if(ctn < 60)
			LED[9:0] <= 10'b0000010000;
			else if(ctn < 70)
			LED[9:0] <= 10'b0000001000;
			else if(ctn < 80)
			LED[9:0] <= 10'b0000000100;
			else if(ctn < 90)
			LED[9:0] <= 10'b0000000010;
			else if(ctn < 100)
			LED[9:0] <= 10'b0000000001;
			else if(ctn > 100)
			LED[9:0] <= 10'b1111111111;
			a0 <= 55;
			a1 <= 6;
			a2 <= 62;
			a3 <= 62;
			a4 <= 0;
			a5 <= 0;
			end
			else if(score == 2)
			begin
			a0 <= 121;
			a1 <= 6;
			a2 <= 78;
			a3 <= 0;
			a4 <= 0;
			a5 <= 0;
			end
			else
			begin
			a0 <= 109;
			a1 <= 109;
			a2 <= 63;
			a3 <= 6;
			a4 <= 0;
			a5 <= 0;
			LED[9:0] <= 0;
			end
			end
		end
		
		//update all the wires at the end
		assign LEDn = LED;
		assign h0 = a0;
		assign h1 = a1;
		assign h2 = a2;
		assign h3 = a3;
		assign h4 = a4;
		assign h5 = a5;

endmodule
