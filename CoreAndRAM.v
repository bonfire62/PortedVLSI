`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:56 10/30/2016 
// Design Name: 
// Module Name:    CoreAndRAM 
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
module CoreAndRAM(ExternalClk,DoutB,R1Out,R2Out);
	input ExternalClk;
	output [15:0] DoutB;
	output [15:0] R1Out,R2Out;
	
	wire [15:0] ReadData, WriteData;
	wire WriteEnable;
	wire [23:0] Address;
	
	IBUFG g(.I(ExternalClk), .O(InternalClk));
	BUFG a(.I(InternalClk), .O(clk));
	
	CoreTop Core(clk,ReadData, Address,WriteData,WriteEnable,R1Out,R2Out);
	
	RAM ram(
  .clka(clk), // input clka
  .wea(WriteEnable), // input [0 : 0] wea
  .addra(Address[14:0]), // input [14 : 0] addra
  .dina(WriteData), // input [15 : 0] dina
  .douta(ReadData), // output [15 : 0] douta
  .clkb(clk), // input clkb
  .web(1'b0), // input [0 : 0] web
  .addrb(Address[14:0]), // input [14 : 0] addrb
  .dinb(16'd0), // input [15 : 0] dinb
  .doutb(DoutB) // output [15 : 0] doutb
);


endmodule
