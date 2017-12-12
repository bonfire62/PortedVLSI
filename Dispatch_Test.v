`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:41 11/14/2016
// Design Name:   Dispatch
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/Dispatch_Test.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Dispatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Dispatch_Test;

	// Inputs
	reg [23:0] Address;
	reg [15:0] RAMData;
	reg [15:0] encLR;
	reg [15:0] encUD;
	reg [15:0] encColor;
	reg [15:0] accelFlag;
	reg weIn;
	reg [15:0] WriteDataIn;

	// Outputs
	wire [15:0] WriteDataOut;
	wire [15:0] ReadDataOut;
	wire weOut;
	wire [15:0] AddressOut;

	// Instantiate the Unit Under Test (UUT)
	Dispatch uut (
		.Address(Address), 
		.RAMData(RAMData), 
		.encLR(encLR), 
		.encUD(encUD), 
		.encColor(encColor), 
		.accelFlag(accelFlag), 
		.weIn(weIn), 
		.WriteDataIn(WriteDataIn), 
		.WriteDataOut(WriteDataOut), 
		.ReadDataOut(ReadDataOut), 
		.weOut(weOut), 
		.AddressOut(AddressOut)
	);
integer i;
	initial begin
		// Initialize Inputs
		Address = 0;
		RAMData = 16'd1;
		encLR = 16'd2;
		encUD = 16'd3;
		encColor = 16'd4;
		accelFlag = 16'd5;
		weIn = 0;
		WriteDataIn = 16'd0;

		// Wait 100 ns for global reset to finish
		#1;
        
		// Add stimulus here
		for (i = 0; i <2048; i = i+1)
		begin
			Address[24:14] = i;
			#1;
		end
	end
      
endmodule

