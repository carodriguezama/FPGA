
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module ThunderBird(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// Accelerometer //////////
	output		          		GSENSOR_CS_N,
	input 		     [2:1]		GSENSOR_INT,
	output		          		GSENSOR_SCLK,
	inout 		          		GSENSOR_SDI,
	inout 		          		GSENSOR_SDO
);

//=======================================================
//  REG/WIRE declarations
//=======================================================
	//switches and clock change
	wire R = SW[0];
	wire L = SW[3];
	wire H = SW[1];
	wire I = SW[2];
	wire up = ~KEY[0];
	wire down = ~KEY[1];
	wire clk = MAX10_CLK1_50;

	//wires for the outputs
	wire clk100HZ;
	wire [9:0] LED_N;
	wire [7:0] H0;
	wire [7:0] H1;
	wire [7:0] H2;
	wire [7:0] H3;
	wire [7:0] H4;
	wire [7:0] H5;

	reg [1:0] state_reg;
	reg [7:0] counter;//counter for different patterns at left and right and to flash for hazards
	reg [27:0] speed;//
	
	//parameters to represent each state
	parameter idle = 2'b00;
	parameter left = 2'b01;
	parameter right = 2'b10;
	parameter hazard = 2'b11;

	initial begin 
		state_reg = idle;
		counter = 0;
		speed = 500000;
	end



//=======================================================
//  Structural coding
//=======================================================
//FSM for the four states idle, hazard, left, and right
	always @(posedge clk100HZ)
		begin
		if(up)
			speed <= speed + 100000;
		else if(down)
			speed <= speed - 10000;
		end
	always @(posedge clk100HZ)
		begin
			case (state_reg)//if statesments for each switch
				idle:		if(H)							state_reg <= hazard;
							else if(R)					state_reg <= right;
							else if(L)					state_reg <= left;
							else							state_reg <= idle;
							
				left:		if(H)							state_reg <= hazard;
							else if(I)					state_reg <= idle;
							else if(R)					state_reg <= right;
							else
								begin							
									state_reg <= left;
									counter <= counter + 1;
									if(counter == 80)
										counter <= 0;
								end
							
				right:	if(H)							state_reg <= hazard;
							else if(I)					state_reg <= idle;
							else if(L)					state_reg <= left;
							else	
								begin
									state_reg <= right;
									counter <= counter + 1;
									if(counter == 80)
										counter <= 0;
								end
							
				hazard:	if(I)							state_reg <= idle;
							else if(R)					state_reg <= right;	
							else if(L)					state_reg <= left;
							else	
								begin						
									state_reg <= hazard;
									counter<=counter+1;
									if(counter > 40)
										counter <= 0;
								end
							
				default:									state_reg <= idle;
			endcase
		end
	
	ClockDivider100 CLK_MUT(clk, clk100HZ, speed);
	
	ThunderCases Cases_MUT(clk100HZ, state_reg, LED_N, counter, H0, H1, H2, H3, H4, H5);
	
	//update the display
	assign LEDR = LED_N;
	assign HEX0 = ~H0;
	assign HEX1 = ~H1;
	assign HEX2 = ~H2;
	assign HEX3 = ~H3;
	assign HEX4 = ~H4;
	assign HEX5 = ~H5;
endmodule
