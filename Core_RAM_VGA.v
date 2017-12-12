`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:32 11/03/2016 
// Design Name: 
// Module Name:    Core_RAM_VGA 
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
module Core_RAM_VGA(ExternalClk,ColorOut,Hsync,Vsync);
	input ExternalClk;
	output [15:0] ColorOut;
	output Hsync, Vsync;
	
	wire [15:0] ReadDataA, WriteDataA;
	wire WriteEnableA;
	wire [23:0] AddressA;
	
	// Internal Clock Buffers
	IBUFG g(.I(ExternalClk), .O(InternalClk));
	BUFG a(.I(InternalClk), .O(clk));
	
	// Wires
	wire [15:0]CoreDataOut,CoreWriteData,VGADataOut;
	wire [14:0] VGAAddress;
	wire [23:0] CoreAddress;

	// Core Instantiation - look into core data out
	CoreTop Core(clk, CoreDataOut, CoreAddress, CoreWriteData, CoreWE);
	
	// Frame buffer memory controller
	MemCont MemoryController(clk, 
	CoreWE, 
	CoreWriteData,	
	CoreAddress, 
	VGAAddress, 
	CoreDataOut, 
	VGADataOut);	

	// VGA Controller Instantiation
	VGA_Controller VGA(clk, VGADataOut, VGAAddress, Hsync, Vsync, ColorOut);

endmodule
