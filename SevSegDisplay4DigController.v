`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:28 08/27/2016 
// Design Name: 
// Module Name:    SevSegDisplay4DigController 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This module takes a 16-bit word input,binIN, and sends out sections 
//					 of 4-bits,binOUT, as well as the position of those 4 bits in the original
// 				 word as an enable signal on en_bus in a loop over time.
//	
//					For example, given binIN of 16'b1010 1111 0000 0110, this module would
//					send out the following in one period of time:
//					binOUT = 4'b0110		en_bus = 4'b0001	
//					binOUT = 4'b0000		en_bus = 4'b0010	
//					binOUT = 4'b1111		en_bus = 4'b0100	
//					binOUT = 4'b1010		en_bus = 4'b1000
// 				
// 				The period assigned for each output is determined by dividing the clock
//					frequency by 2^15 and giving each set of outputs one-fourth of the 
//					modified clock period.	
//					
// 				
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SevSegDisplay4DigController(
    input clk,
    input rst,
    input [15:0] binIN,
	 output reg [3:0] binOUT, en_bus
    );
//	 reg [1:0] NS, PS;
//	 localparam [1:0] Dig0 = 0, Dig1 = 1, Dig2 = 2, Dig3 = 3;
	 
	 
	 // Clock frequency fed into counter for frequency division
	 
	reg [15:0] counter;
	initial counter = 16'd1;
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			counter<=16'd1;
		else if(counter==16'd32768)
			counter<=16'd1;
		else
		counter<=counter+16'd1;

	end

	// assign clk_out = (counter==16'd16384);
	
	
	// Assigning outputs to each 4th of modified clock period
	always @(posedge clk)
		// First output period
		if(counter>=1 &&counter<=8192) begin
			binOUT = binIN[3:0]; 
			en_bus = 4'b0001;
		end
		// second output period
		else if(counter>=8193 &&counter<=16384) begin
			binOUT = binIN[7:4]; 
			en_bus = 4'b0010;
		end 
		// third output period
		else if(counter>=16385 &&counter<=24576) begin
			binOUT = binIN[11:8]; 
			en_bus = 4'b0100;
		end
		// fourth output period
	   else if(counter>=24577 &&counter<=32768) begin
			binOUT = binIN[15:12]; 
			en_bus = 4'b1000;
		end
	 
	 
	 
	 
	 
	 //FreqDivider100MHzTo1kHz ClkDivider(clk,rst,clk_1kHz);

	 // Next state logic
/*	 always @(PS) 
		case(PS)
			Dig0: NS <=Dig1;
			Dig1: NS <=Dig2;
			Dig2: NS <=Dig3;
			Dig3: NS <=Dig0;
		endcase
	// Output Logic
	always @(posedge clk_out)
	begin
		case(PS)
			Dig0: begin binOUT = binIN[3:0]; 
							en_bus = 4'b0001;
					end
			Dig1: begin binOUT = binIN[7:4]; 
							en_bus = 4'b0010;
					end
			Dig2: begin binOUT = binIN[11:8]; 
							en_bus = 4'b0100;
					end
			Dig3: begin binOUT = binIN[15:12]; 
							en_bus = 4'b1000;
					end
	
		endcase
		
		PS <=NS;
	end*/
	
	/*always @(posedge clk)
		if(rst)
			PS <= Dig0;*/
		
	 

endmodule
