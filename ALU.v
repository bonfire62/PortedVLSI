`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:59:39 10/25/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(Ain,Bin,Instruction,Output,eqFlag);

// I/O
	input [15:0] Ain;
   input [15:0] Bin;
	input [15:0] Instruction;
// input [3:0] OpCode;
   output reg [15:0] Output;
	output eqFlag;
//   output ALessB,
//   output AEqB
	
	assign eqFlag = (Ain==Bin);
	always @(*)
	begin
	case(Instruction[15:12])  // Interpret OpCode
		4'b0000: Output = Ain + Bin; // Add
		4'b0001: Output = Ain + Instruction[3:0]; // Add Immediate
		4'b0010: Output = Ain + ~Bin+1'b1; // Subtract 
	//	4'b0011:	// Load Word
	//	4'b0100: // Store Word
		4'b0101: Output = (Ain == Bin)? 1'b1:1'b0; // Set Equal
		4'b0110: Output = (Ain <  Bin)? 1'b1:1'b0; // Set Less Than
	//	4'b0111: // Branch on Equal
	//	4'b1000: // Jump
	//	4'b1001: // Jump and Link
		4'b1010: Output = Ain>>Instruction[3:0]; // Right Shift Logical
		4'b1011: Output = Ain<<Instruction[3:0]; // Left Shift Logical
		4'b1100: Output = ~(Ain&Bin);				  // NAND
		4'b1101:	Output = Instruction[7:0]; // Load Immediate
	//	4'b1110:
	//	4'b1111:
		default: Output = 16'bx;
	endcase
	end
endmodule
