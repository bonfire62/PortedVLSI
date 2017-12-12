`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:57:32 11/03/2016 
// Design Name: 
// Module Name:    Pmod 
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
module PmodEnc(
    clk,
    JA,
    //an,
    //seg,
    Led
    );

	 // ===========================================================================
	 // 										Port Declarations
	 // ===========================================================================
    input clk;
    input [5:4] JA;
    //output [3:0] an;
    //output [6:0] seg;
    output [7:0] Led;

	 // ===========================================================================
	 // 							  Parameters, Regsiters, and Wires
	 // ===========================================================================
	 wire [3:0] an;
	 wire [6:0] seg;
	 wire [7:0] Led;
	 
	 parameter [7:0] MAX = 8'd120;
	 
	 //wire [4:0] EncO;
	 
	 // ===========================================================================
	 // 										Implementation
	 // ===========================================================================
 	 Debouncer C0_Debouncer (
				  .clk(clk),
				  .Ain(JA[4]),
				  .Bin(JA[5]),
				  .Aout(AO),
				  .Bout(BO)
	 );
	 
 	Encoder C1_Encoder (
				  .clk(clk),
				  .A(AO),
				  .B(BO),
				  .max(MAX),
				 // .BTN(),
				  .EncOut(Led)
				// .LED(Led)
	 ); 

 	 /*EncDisplayController C2_DisplayController (
				  .clk(clk),
				  .SWT(JA[7]),
				  .DispVal(Led),
				  .anode(an),
				  .segOut(seg)
	 );*/
endmodule
