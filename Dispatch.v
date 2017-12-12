`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:06 11/11/2016 
// Design Name: 
// Module Name:    Dispatch 
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
module Dispatch(Address, RAMData, weIn, WriteDataIn, WriteDataOut, ReadDataOut, weOut, AddressOut);   
           
   input [23:0] Address;
	input [15:0] RAMData;
	input weIn;           			// Write enable from core
	input [15:0] WriteDataIn; 		// Write data from core
	output [15:0] WriteDataOut; 	// Write data to RAM
	output reg [15:0] ReadDataOut; // Data from RAM to Core
	output weOut;    					 // write enable signal to RAM
	output [14:0] AddressOut; 		 // Address signal to RAM

	         
		
endmodule
