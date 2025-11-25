module HexDisplay(

 input MAX10_CLK1_50,
 
 output [7:0] HEX0,
 output [7:0] HEX1,
 output [7:0] HEX2,
 output [7:0] HEX3,
 output [7:0] HEX4,
 output [7:0] HEX5
 
 
);

wire clk2;

clk_slower u1(MAX10_CLK1_50, clk2);

display u2(clk2, HEX0);
display u3(clk2, HEX1);
display u4(clk2, HEX2);
display u5(clk2, HEX3);
display u6(clk2, HEX4);
display u7(clk2, HEX5);


endmodule

//----------------------------------------------------

module clk_slower(input clk, output reg clk_slow);

	reg [24:0] counter;

	always @(posedge clk) begin
		
		if(counter >= 16666666) begin
		
			counter = 0;
			clk_slow = ~clk_slow;
		
		end else begin
		
			counter = counter + 1;
		
		end
		
	end
	


endmodule

module display(input clk, output reg [7:0] HEX);

		reg [3:0] counter = 0;

		always @(posedge clk) begin
	
			if(counter >= 9) begin
				counter = 0;
			end else begin
				counter = counter + 1;
			end
	
		end
		

		always @(counter) begin
	
			case(counter)
		
				0 : HEX <= 8'b01000000;
				1 : HEX <= 8'b01111001;	 
				2 : HEX <= 8'b00100100;		
				3 : HEX <= 8'b00110000;	
				4 : HEX <= 8'b00011001;
				5 : HEX <= 8'b00010010;
				6 : HEX <= 8'b00000010;	
				7 : HEX <= 8'b01111000;
				8 : HEX <= 8'b00000000;
				9 : HEX <= 8'b00010000;		
			 
			endcase
	
		end

endmodule