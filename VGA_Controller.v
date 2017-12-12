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
input[7:0] ColorIn;
output[14:0] Address;
output Hsync;
output Vsync;
output [7:0] ColorOut;

wire [9:0] LineCount;
wire [9:0] PixelCount;


	// Determine address of Area on screen in text area
	assign Address = {LineCount[8:2],PixelCount[9:2]} +15'd1000;

// Signal Generator and Output to Screen
	VGA_SignalGen SignalGen(clk, 1'b0,ColorIn, PixelCount, LineCount, Hsync,Vsync, ColorOut);



endmodule
