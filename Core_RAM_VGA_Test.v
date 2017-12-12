`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:19:01 11/10/2016
// Design Name:   Core_RAM_VGA
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/Core_RAM_VGA_Test.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Core_RAM_VGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Core_RAM_VGA_Test;

	// Inputs
	reg ExternalClk;

	// Outputs
	wire [7:0] ColorOut;
	wire Hsync;
	wire Vsync;

	// Instantiate the Unit Under Test (UUT)
	Core_RAM_VGA uut (
		.ExternalClk(ExternalClk), 
		.ColorOut(ColorOut), 
		.Hsync(Hsync), 
		.Vsync(Vsync)
	);

	initial begin
		// Initialize Inputs
		ExternalClk = 0;

		// Wait 100 ns for global reset to finish
		#5;
        
		// Add stimulus here

	end
      always 
		#5	ExternalClk <=~ExternalClk;
endmodule

