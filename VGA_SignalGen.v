`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:17:58 10/14/2016 
// Design Name: 
// Module Name:    VGA_SignalGen 
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
module VGA_SignalGen(clk, rst,ColorIn,  PixelCount, LineCount, Hsync,Vsync, ColorOut);
	input clk, rst;
	input [7:0] ColorIn;
	//output reg [subPixelCountNBITS-1:0] subPixelCount;
	reg [subPixelCountNBITS-1:0] subPixelCount;
	output reg [HorzPixNBITS-1:0] PixelCount;
	output reg [VertPixNBITS-1:0] LineCount;
	output reg Hsync;
	output reg Vsync;
	output reg [7:0] ColorOut;
	//output Active;
	// Initialization of registers
	initial subPixelCount = 0;
	initial PixelCount = 0;
	initial LineCount = 0;
	// Parameters
	parameter HorzPixelCount = 800;
	parameter HorzPixNBITS = 10; // Number of bits necessary to contain all 
	parameter VertPixelCount = 525;
	parameter VertPixNBITS = 10;
	parameter subPixelCountNBITS = 2;
	parameter subPixFreqDivision = 4; // Integer value by which 100MHz Clock Frequency is divided
	parameter HorzBackPorch = 48;
	parameter HorzFrontPorch = 16;
	parameter HorzActiveReg = 640;
	parameter VertBackPorch = 33;
	parameter VertFrontPorch = 10;
	parameter VertActiveReg = 480;
	parameter HSyncReg = 96;
	parameter VSyncReg = 2;
	
	
	//
	always @(posedge clk)
	begin
		// Reset Condition
		if (rst)
		begin
			subPixelCount <= {(subPixelCountNBITS){1'b0}}; //
			PixelCount <= {(HorzPixNBITS){1'b0}};
			LineCount <= {(VertPixNBITS){1'b0}};
		end
		else
		begin
			// Frequency Dividing Logic
			if(subPixelCount == (subPixFreqDivision-1))
				subPixelCount <= {(subPixelCountNBITS){1'b0}}; //
			else
				subPixelCount <=subPixelCount+1'b1;
			// Counting Logic
			if (subPixelCount == (subPixFreqDivision-1))
			begin
				//Increment Horizontal Counter
				if(PixelCount == (HorzPixelCount-1))
					PixelCount <= {{(HorzPixNBITS){1'b0}}};
				else
					PixelCount <= PixelCount + 1'b1;
					
				// Increment Vertical Counter
				if (PixelCount == (HorzActiveReg + HorzFrontPorch - 1) )// When Hsync pulse strikes
				begin
					// If max count reached, reset count
					if (LineCount == (VertPixelCount - 1))
						LineCount <= {(VertPixNBITS){1'b0}};
					// else increment count when Hsync pulse hits
					else
						LineCount <= LineCount + 1'b1;			
				
				// Sync Assignment
				Vsync <= ~(LineCount>=(VertActiveReg + VertFrontPorch - 1)  && LineCount <(VertActiveReg + VertFrontPorch +VSyncReg-1));
				end
				Hsync <= ~(PixelCount>=(HorzActiveReg + HorzFrontPorch +8)  && PixelCount <(HorzActiveReg + HorzFrontPorch +HSyncReg +8));
				ColorOut <= ((PixelCount == (HorzPixelCount+8) || PixelCount <HorzActiveReg+8) && (LineCount == VertPixelCount || LineCount <VertActiveReg))? ColorIn:8'd0;
			end
		end
	end
	
 
endmodule



// Interpretation of a Line
/*
 *
 *   Visible Area | Front Porch | Sync Pulse | BackPorch 
 *
 */