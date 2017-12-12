`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:38 11/10/2016 
// Design Name: 
// Module Name:    EncCounter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module EncCounter(
	input clk,
	input [1:0] move,
	output reg [15:0] pixel
	 );
	
	//initialize cursor 
	initial pixel = 16'b0;
	
	//Max number of pixels
	parameter max = 0; 
	parameter factor = 1;
	
	always @ (posedge clk) begin
		case(move)
			2'b00: pixel <= pixel;
			
			2'b10: begin
				if(pixel < max)
					pixel <= pixel + (1'b1 << factor);
			end
			
			2'b01: begin
				if(pixel > 0)
					pixel <= pixel - (1'b1 << factor);
			end
			
			default: pixel <= pixel;
		endcase
	end
endmodule
