`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:36 08/27/2016 
// Design Name: 
// Module Name:    BinaryTo4DigHex7SegDisplay 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This module takes a 4-bit binary number as well as a 4-bit enable signal.
//				    The binary number input is combinationally encoded to pull down the
//					 cathodes necessary to convey the binary number as a hexadecimal value. The
//					 4-bit enable signal is then used to tell the 4-digit 7-segment display
//					 which of the 4 digits should be illuminated.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BinaryTo4DigHex7SegDisplay( 
	 input [3:0] en_bus, // enable for particular display 
    input [3:0] binIN, // 4 digit binary input
    output reg CA,CB,CC,CD,CE,CF,CG,DP, // Signals corresponding to display signal
    output AN0, AN1, AN2, AN3 // Common anodes for each 7 segment display
    );
	 // Defining hexadecimal values corresponding to their 7-segment LED representations
	localparam [7:0] Hex0 = 8'b00000011, Hex1=8'b10011111, Hex2=8'b00100101,
				  Hex3 = 8'b00001101, Hex4 = 8'b10011001, Hex5 = 8'b01001001, 
				  Hex6 = 8'b01000001, Hex7 = 8'b00011111, Hex8 = 8'b00000001, 
				  Hex9 = 8'b00011001, HexA = 8'b00010001, HexB = 8'b11000001, 			
				  HexC = 8'b01100011, HexD = 8'b10000101, HexE = 8'b01100001, 
				  HexF = 8'b01110001;
	//	Negate enable bus to pull down the proper anode and pull high the 
	assign {AN3,AN2,AN1,AN0} = ~en_bus; 
	
	always @(binIN)
	begin
		case(binIN)
			4'b0000: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex0;
			4'b0001: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex1;
			4'b0010: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex2;
			4'b0011: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex3;
			4'b0100: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex4;
			4'b0101: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex5;
			4'b0110: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex6;
			4'b0111:	{CA,CB,CC,CD,CE,CF,CG,DP} = Hex7;
			4'b1000: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex8;
			4'b1001: {CA,CB,CC,CD,CE,CF,CG,DP} = Hex9;
			4'b1010: {CA,CB,CC,CD,CE,CF,CG,DP} = HexA;
			4'b1011: {CA,CB,CC,CD,CE,CF,CG,DP} = HexB;
			4'b1100: {CA,CB,CC,CD,CE,CF,CG,DP} = HexC;
			4'b1101: {CA,CB,CC,CD,CE,CF,CG,DP} = HexD;
			4'b1110: {CA,CB,CC,CD,CE,CF,CG,DP} = HexE;
			4'b1111:	{CA,CB,CC,CD,CE,CF,CG,DP} = HexF;
		endcase
	end

endmodule
