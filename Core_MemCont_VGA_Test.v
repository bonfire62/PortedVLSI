`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:18:14 11/15/2016
// Design Name:   Core_MemCont_VGA
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/Core_MemCont_VGA_Test.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Core_MemCont_VGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Core_MemCont_VGA_Test;

	// Inputs
	reg ExternalClk;
	reg rstBtn;

	// Outputs
	wire [7:0] ColorOut;
	wire Hsync;
	wire Vsync;

	// Instantiate the Unit Under Test (UUT)
	Core_MemCont_VGA uut (
		.ExternalClk(ExternalClk), 
		.rstBtn(rstBtn),
		.ColorOut(ColorOut), 
		.Hsync(Hsync), 
		.Vsync(Vsync)
	);

	initial begin
		// Initialize Inputs
		ExternalClk = 0;
		rstBtn=0;
		#10; // Reset
		rstBtn = 1;

	end
      always 
		#5	ExternalClk <=~ExternalClk; // Just let core run
      
endmodule

