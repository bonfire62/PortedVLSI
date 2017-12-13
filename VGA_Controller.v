`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:05:42 11/03/2016 
// Design Name: 
// Module Name:    VGA_Controller 
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
module VGA_Controller(clk,ColorIn,Address,Hsync,Vsync,ColorOut);
input clk;
input [7:0] ColorIn;
output [15:0] Address;
output Hsync;
output Vsync;
output [7:0] ColorOut;

parameter RED = 8'b00011100;
parameter BLACK = 8'b11111111;

wire [9:0] LineCount;
wire [9:0] PixelCount;
wire bit_out;

//reg toggle = 0;
//	
//	
//	if (toggle == 0)
		assign Address = {LineCount[8:2], PixelCount[9:2]} + 15'd1000;
//	else
//		assign Address = {LineCount[8:2], PixelCount[9:2]} + 15'd33768;
	
//	if(LineCount[8:2] == 7'd119 && PixelCount[9:2] == 8'd159)
//		assign toggle = (toggle ? 0 : 1);

	// Determine address of Area on screen in text area
	//if row and column are in the second vga output, then send the second vga screee
	//assign Address = (row == 120 || col == 160) ? ({row,col} + (toggle  15'd1000)) : ({row,col} + (toggle  15'd1000)) ;


	//TODO: read from this ROM later
	//Spiral_Rom SpiRom(LineCount[8:2], PixelCount[9:2], bit_out);

	// Signal Generator and Output to Screen
	VGA_SignalGen SignalGen(clk, 1'b0,ColorIn, PixelCount, LineCount, Hsync,Vsync, ColorOut);

endmodule