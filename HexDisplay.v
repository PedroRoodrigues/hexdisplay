//----------------------------------------------------
//Main Module

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
wire [3:0] count;

clk_slower u1(
		.clk(MAX10_CLK1_50), 
		.clk_slow(clk2)
		);

counter u2(
	.clk(clk2), 
	.count(count)
	);

hexdecoder u3(count, HEX0);
hexdecoder u4(count, HEX1);
hexdecoder u5(count, HEX2);
hexdecoder u6(count, HEX3);
hexdecoder u7(count, HEX4);
hexdecoder u8(count, HEX5);

endmodule

//----------------------------------------------------
//Module to set new 0,333hz clock

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

//----------------------------------------------------
//Module to count from 0 to 9

module counter(input clk, output reg [3:0] count);

	always @(posedge clk)begin
			
		if(count >= 9) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end
			
	end

endmodule

//----------------------------------------------------
//Module to decode to 7-segment display

module hexdecoder(input [3:0] count, output reg [7:0] HEX);

	always @(count) begin
		
		case(count)
			3'b000 : HEX <= 8'b01000000;
			3'b001 : HEX <= 8'b01111001;	 
			3'b010 : HEX <= 8'b00100100;		
			3'b011 : HEX <= 8'b00110000;	
			3'b100 : HEX <= 8'b00011001;
			3'b101 : HEX <= 8'b00010010;
			3'b110 : HEX <= 8'b00000010;	
			3'b111 : HEX <= 8'b01111000;
			4'b1000 : HEX <= 8'b00000000;
			4'b1001 : HEX <= 8'b00010000;
			default : HEX <= 8'b11111111;
		endcase
			
	end
		
endmodule