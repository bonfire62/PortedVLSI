`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:08:10 10/30/2016
// Design Name:   CoreAndRAM
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/CoreAndRAM_Test.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CoreAndRAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CoreAndRAM_Test;

	// Inputs
	reg ExternalClk;

	// Outputs
	wire [15:0] DoutB;
	wire [15:0] R1Out,R2Out;

	// Instantiate the Unit Under Test (UUT)
	CoreAndRAM uut (
		.ExternalClk(ExternalClk), 
		.DoutB(DoutB),
		.R1Out(R1Out),
		.R2Out(R2Out)
	);

	initial begin
		// Initialize Inputs
		ExternalClk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
		always
		#200 ExternalClk <=~ExternalClk;
endmodule

