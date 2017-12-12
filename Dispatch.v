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
module Dispatch(Address, RAMData, /*encUD, encColor, accelFlag,*/weIn, WriteDataIn, WriteDataOut,
					 ReadDataOut,weOut, AddressOut/*, accBeenRead*/
    );              
   input [23:0] Address;
	input [15:0] RAMData; // Data from RAM module for core
//	encLR, 					 // Incoming data from horizontal axis encoder
//	encUD, 					 // Incoming data from vertical axis encoder
//	encColor, 				 // Incoming data from color encoder
//	accelFlag;				 // Accelerometer flag
	input weIn;           // Write enable from core
	input [15:0] WriteDataIn; // Write data from core
	output [15:0] WriteDataOut; // Write data to RAM
	output reg [15:0] ReadDataOut; // Data from RAM to Core
	output weOut;    					 // write enable signal to RAM
	output [14:0] AddressOut; 		 // Address signal to RAM
//	output accBeenRead;

	//assign accBeenRead = (Address[23:16]==8'b0000_0011); // Send out "Has been read" to accelerometer
	assign weOut = weIn; // Core controls when writing directly
	assign WriteDataOut = WriteDataIn; // Core controls when writing directly
	assign AddressOut = Address[14:0];                 
	always @ (*)     
	begin            
		case (Address[23:16])
		8'b0000_0000: ReadDataOut <= RAMData;
//		8'b0000_0001: ReadDataOut <= encUD;
//		8'b0000_0010: ReadDataOut <= encLR;
//		8'b0000_0011: ReadDataOut <= accelFlag;
//		8'b0000_0100: ReadDataOut <= encColor;
		default: 	  ReadDataOut <= RAMData;
		endcase       
	end              
		
endmodule
