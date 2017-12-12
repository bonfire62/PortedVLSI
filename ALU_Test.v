`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:33:48 10/25/2016
// Design Name:   ALU
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/ALU_Test.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_Test;

	// Inputs
	reg [15:0] Ain;
	reg [15:0] Bin;
	reg [15:0] Instruction;

	// Outputs
	wire [15:0] Output;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.Ain(Ain), 
		.Bin(Bin), 
		.Instruction(Instruction), 
		.Output(Output)
	);
integer i,j; 
	initial begin
		// Initialize Inputs
		Ain = 16'b0001_1010_0011_0001;
		Bin = 16'b0001_1010_0011_0000;
		Instruction = 0;

		// Wait 100 ns for global reset to finish
		#1;
        
		// Add stimulus here
		for(i = 0; i <16;i= i+1)
		begin
			Instruction[15:12] = i;
			for(j=0;j<16;j=j+1)
			begin
				Instruction[3:0] = j;
				#1;
			end

		end
	end
      
endmodule

