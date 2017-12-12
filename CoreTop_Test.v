`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:27:53 10/26/2016
// Design Name:   CoreTop
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/CoreTop_Test.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CoreTop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CoreTop_Test;

	// Inputs
	reg clk;
	reg [15:0] ReadData;

	// Outputs
	wire [23:0] Address;
	wire [15:0] WriteData;
	wire WriteEnable;

	// Instantiate the Unit Under Test (UUT)
	CoreTop uut (
		.clk(clk), 
		.ReadData(ReadData), 
		.Address(Address), 
		.WriteData(WriteData), 
		.WriteEnable(WriteEnable)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		ReadData = 0;

		// Wait 100 ns for global reset to finish
		#1;
		ReadData = 16'b0011_0111_0011_0000;
		#4;
		ReadData = 16'b1000_0000_0000_0000;
        
		// Add stimulus here

	end
	always 
	#1 clk <=~clk;
      
endmodule

