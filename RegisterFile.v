`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:50 10/25/2016 
// Design Name: 
// Module Name:    RegisterFile 
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
module RegisterFile(clk,AReg,BReg,WriteData,WriteReg,WE,Aout,Bout
//R1Out,R2Out
);
	 input clk;
	 input [3:0] AReg;
    input [3:0] BReg;
	 input [15:0] WriteData;
	 input [3:0] WriteReg;
    input WE;
    output reg[15:0] Aout;
    output reg[15:0] Bout;
	 // Debugging Outputs
//	 output [15:0] R1Out,R2Out;
//	 assign R1Out = R1;
//	 assign R2Out = R2;
	 // Create Registers (16x16)
	 reg [15:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15;
	 
	 //Initialize Registers
		initial R0 =16'd0;
		initial R1 =16'd0;
		initial R2 =16'd0;
		initial R3 =16'd0;
		initial R4 =16'd0;
		initial R5 =16'd0;
		initial R6 =16'd0;
		initial R7 =16'd0;
		initial R8 =16'd0;
		initial R9 =16'd0;
		initial R10 =16'd10;
		initial R11 =16'b0111_1111_1111_0000;
		initial R12 =16'd1000;
		initial R13 =16'b1111_1111_1111_1111;
		initial R14 =16'd0;
		initial R15 =16'd1;
	 
	 
	 
	// Combinatorially Outputting Data
	always @(*)
	begin
		case(AReg) // A output
			0: Aout = R0;
			1: Aout = R1;
			2: Aout = R2;
			3: Aout = R3;
			4: Aout = R4;
			5: Aout = R5;
			6: Aout = R6;
			7: Aout = R7;
			8: Aout = R8;
			9: Aout = R9;
			10: Aout = R10;
			11: Aout = R11;
			12: Aout = R12;
			13: Aout = R13;
			14: Aout = R14;
			15: Aout = R15;
		endcase
		case(BReg)
			0: Bout = R0;
			1: Bout = R1;
			2: Bout = R2;
			3: Bout = R3;
			4: Bout = R4;
			5: Bout = R5;
			6: Bout = R6;
			7: Bout = R7;
			8: Bout = R8;
			9: Bout = R9;
			10: Bout = R10;
			11: Bout = R11;
			12: Bout = R12;
			13: Bout = R13;
			14: Bout = R14;
			15: Bout = R15;
		endcase
	end

	// Writing to registers
	always @(posedge clk)
	begin
		if(WE)
		case(WriteReg)
			0:  R0 <= WriteData;
			1:  R1 <= WriteData;
			2:  R2 <= WriteData;
			3:  R3 <= WriteData;
			4:  R4 <= WriteData;
			5:  R5 <= WriteData;
			6:  R6 <= WriteData;
			7:  R7 <= WriteData;
			8:  R8 <= WriteData;
			9:  R9 <= WriteData;
			10: R10<= WriteData;
			11: R11<= WriteData;
			12: R12<= WriteData;
			13: R13<= WriteData;
			14: R14<= WriteData;
			15: R15<= WriteData;
		endcase
	end


endmodule
