`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:58 08/27/2016 
// Design Name: 
// Module Name:    buttonCount 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This module takes 3 UI inputs, up, down, and rst and controls the
// 				value of a 16 bit value, count, according to how the inputs are 
//					pressed. Upon starting and when rst is pressed, the output count is 
//					set to 1. When the up button is pressed, the count is incremented
//					
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module buttonCount(
    input clk,  // clock signal
	 input up,	 // button to increment count
    input down, // button to decrement count
    input rst,	 // reset count
    output reg [15:0] count	// current count 
    );
	 reg [1:0] NS, PS; // next state and present state registers
	 localparam [1:0] stall = 0, inc = 1, dec = 2;	 // available states
	 initial PS = 0; // initialize state
	 initial count = 16'd1; // initialize count
	 // Next state logic - combinational
	 always @(PS,up,down,count)
	 begin
		case (PS)
		stall:	
		begin
			if(up==1) 
			begin 
			NS<= inc; // if up button pressed, move to increment state
			end
			
			else if(down==1) 
			begin
				NS<= dec; //if down button pressed, move to decrement state
	 		end

			else NS<=stall; // otherwise, stall more 
		end
		inc: 
		begin
			if(~up) NS <=stall; // only leave increment state if up button released
			else NS <= inc;
		end
		dec: 
		begin
			if(~down) NS <=stall; // only leave decrement state if down button released
			else NS <= dec;
		end
		default: NS<=stall; 	// default case just for ISE's sake
		endcase
	 end


		// Output logic - change count value according to state transitions
	always @(posedge clk) begin
		// change on transition from inc state to stall state unless count is saturated
		if(PS == inc && NS ==stall && count<16'b1111111111111111)
			count <=count+16'd1;
		// change on transition from dec state to stall state unless count is saturated
		else if(PS == dec && NS ==stall && count>16'd0)
			count <= count - 16'd1;
		// otherwise maintain count
		else
			count <=count;

	// NEXT STATE LOGIC		
		// if reset button pressed then restart counting
		if (rst) begin
			PS<=0; 
			count <=16'd1; end
		// Switch states
		else
			PS <=NS;
	end
	
endmodule
