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
CoreDataOut, 
VGADataOut);

	 input			clk;
	 input 		   CoreWE;
	 input [15:0]  CoreWriteData;
	 input [23:0]  CoreAddress;
	 input [15:0]  VGAAddress;
	 output [15:0] CoreDataOut, VGADataOut;
	 
	 // Wires
	 wire [15:0] RAMData; // Data from ram to dispatch
	 wire [14:0] AddressOut; 	// Address out of dispatch to RAM
	 wire [15:0] WriteDataOut; // Data out of dispatch to RAM
   
	// Instantiate RAM module
	RAM Ram(
  .clka(clk), // input clka
  .wea(CoreWE), // input [0 : 0] wea
  .addra(CoreAddress[15:0]), // input [15 : 0] addra (changed to 16 bits by ken)
  .dina(CoreWriteData), // input [15 : 0] dina
  .douta(CoreDataOut), // output [15 : 0] douta
  .clkb(clk), // input clkb
  .web(1'b0), // input [0 : 0] web
  .addrb(VGAAddress[15:0]), // input [15 : 0] addrb (changed to 16 bits by ken)
  .dinb(16'd0), // input [15 : 0] dinb
  .doutb(VGADataOut) // output [15 : 0] doutb
  );
	
	 
endmodule
