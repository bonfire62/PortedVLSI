`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:38:55 11/15/2016 
// Design Name: 
// Module Name:    MemCont 
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
module MemCont(
clk,
CoreWE,
CoreWriteData,
CoreAddress,
VGAAddress,
accelFlag, encLR, encUD, encColor,
CoreDataOut, VGADataOut,
accBeenRead);
	 input			clk;
	 input 		   CoreWE;
	 input [15:0]  CoreWriteData;
	 input [23:0]  CoreAddress;
	 input [14:0]  VGAAddress;
	 input [15:0]  accelFlag, encLR, encUD, encColor;
	 output [15:0] CoreDataOut, VGADataOut;
	 output accBeenRead;
	 // Wires

	 wire [15:0] RAMData; // Data from ram to dispatch
//	 wire [15:0] encLR; 	// Data from horizontal encoder to dispatch
//	 wire [15:0] encUD;  // Data from vertical encoder to dispatch
//	 wire [15:0] encColor; 	// Data from color encoder to dispatch
//	 wire [15:0] accelFlag; // Data from accelerometer to dispatcher
	 wire [14:0] AddressOut; 	// Address out of dispatch to RAM
	 wire [15:0] WriteDataOut; // Data out of dispatch to RAM
	 
	 // Instantiate dispatcher
	 Dispatch D(CoreAddress, RAMData, /*encLR, encUD, encColor, accelFlag,*/CoreWE, CoreWriteData, WriteDataOut,
					 CoreDataOut,weOut, AddressOut/*,accBeenRead*/);
	
	// Instantiate ROM module
	RAM Ram(
  .clka(clk), // input clka
  .wea(weOut), // input [0 : 0] wea
  .addra(AddressOut), // input [14 : 0] addra
  .dina(WriteDataOut), // input [15 : 0] dina
  .douta(RAMData), // output [15 : 0] douta
  .clkb(clk), // input clkb
  .web(1'b0), // input [0 : 0] web
  .addrb(VGAAddress[14:0]), // input [14 : 0] addrb
  .dinb(16'd0), // input [15 : 0] dinb
  .doutb(VGADataOut) // output [15 : 0] doutb
  );
	
	
	 
	 
endmodule
