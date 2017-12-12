`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:09:47 10/30/2016
// Design Name:   RAM
// Module Name:   C:/Users/imana/OneDrive/Documents/GitHub/Core/RAM_Scan.v
// Project Name:  Core
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RAM_Scan;

	// Inputs
	reg clka;
	reg [0:0] wea;
	reg [14:0] addra;
	reg [15:0] dina;
	reg clkb;
	reg [0:0] web;
	reg [14:0] addrb;
	reg [15:0] dinb;

	// Outputs
	wire [15:0] douta;
	wire [15:0] doutb;

	// Instantiate the Unit Under Test (UUT)
	RAM uut (
		.clka(clka), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta), 
		.clkb(clkb), 
		.web(web), 
		.addrb(addrb), 
		.dinb(dinb), 
		.doutb(doutb)
	);
integer i;
	initial begin
		// Initialize Inputs
		clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		clkb = 0;
		web = 0;
		addrb = 0;
		dinb = 0;

		// Wait 100 ns for global reset to finish
		#1;
		for(i=0;i<100;i=i+1)
		begin
			addra <= i;
			#5;
		end
		// Add stimulus here

	end
		always
		#1 clka<= ~clka;
		
endmodule

