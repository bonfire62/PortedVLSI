`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:07 11/15/2016 
// Design Name: 
// Module Name:    ACL_Controller 
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
module ACL_Controller(
    input clk,
	 input hasBeenRead,
	 input [9:0]selData,
	 output reg [15:0]aclOut
	 );

	 reg PS, NS;
	 parameter receive = 1'b0, send = 1'b1;
	 
	 initial aclOut = 16'b0;
	 initial PS = receive;
	 
	 always@(posedge clk) begin
		PS <= NS;	
	 end
	 
	 always@(*) begin
		case(PS)
			//receive singal from accelerometer
			receive: begin
				if(selData[8:7] == 2'b11) begin //above threshold
					aclOut = 16'b1;
					NS = send;
				end
				else begin
					aclOut = 16'b0;
					NS = receive;
				end
			end
			
			send: begin
				if(hasBeenRead) begin
					aclOut = 16'b0;
					NS = receive;
				end
				else begin
					aclOut = 16'b1;
					NS = send;
				end
			end
			
			default: begin
				NS = receive;
				aclOut = 16'b0;
			end
		endcase
	 end
endmodule

