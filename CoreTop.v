`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:42 10/26/2016 
// Design Name: 
// Module Name:    CoreTop 
// Project Name: 
// Target Devices: 
// Tool versions: 
//////////////////////////////////////////////////////////////////////////////////
module CoreTop(clk,ReadData, Address,WriteData,WriteEnable
//,R1Out,R2Out
);
    input clk;
	 input [15:0] ReadData;
	 output reg [23:0] Address;
    output reg [15:0] WriteData;
    output reg WriteEnable;
	// output [15:0] R1Out,R2Out;
	 
	 reg [14:0] PC,NextPC;
	 reg [31:16] Instruction,NextInstruction;
	 reg [1:0] PS, NS;
	 
	 initial NextPC = 16'd1;  
	 initial PC = 16'd0; // Start reading instructions from address 0
	 initial PS = 2'd2; // Start in Execute stage
	 
	 // Register File Wires
	 wire [3:0] ARegSelect, BRegSelect, RFWriteReg;
	 wire [15:0] RFWriteData;
	 reg RFWriteEnable;
	 wire [15:0] RFAout,RFBout;
	 wire [15:0] ALUOutput;
	 
	 parameter Fetch = 2'd0, Receive = 2'd1,Execute = 2'd2;
	 
	 parameter [3:0] add = 4'b0000, addi = 4'b0001, sub = 4'b0010, load = 4'b0011, store = 4'b0100, 
						  seq = 4'b0101, slt = 4'b0110, beq = 4'b0111, j = 4'b1000, jal = 4'b1010, 
						  shr = 4'b1010, shl = 4'b1011, nan = 4'b1100, loadi = 4'b1101, wr = 4'b1110;
// Core Controller 	 
	 // Latch State
	 always @(posedge clk)
	 begin
		PC <=NextPC;
		PS <= NS;
		Instruction<=NextInstruction;
	 end
	 
	 
	 // NextState Assignment - Always cycles through 3 stages
	 always @(*)
	 begin
		case(PS)
			 Fetch:   NS <=Receive;
			 Receive: NS <= Execute;
			 Execute: NS <=Fetch;
			 default: NS <=Fetch;
		 endcase
	 end
	 
	 
	 //NextReg Value Assignment 
	 always @(*)
	 begin
		case(PS)
			 Fetch: 
			 begin 
				NextInstruction[31:16] <= ReadData;
				//NextInstruction[15:0]  <=Instruction[15:0];
				NextPC                 <= PC;
			 end 
			 Receive:
			 begin
				//NextInstruction[31:16] <=Instruction[31:16]; // Instruction latched in by receive
				NextInstruction<=Instruction; // Instruction latched in by receive
				NextPC <= PC+1'b1;
				// Check for Load
				if(Instruction[31:28] == load ||Instruction[31:28] == store || Instruction[31:28] == beq) // if load or store instruction
				begin
					//NextInstruction[15:0] <= ReadData; // Latch in second half of the instruction
					NextPC <= PC+2'd2; // Jump to the next instruction, skipping the second word of the load/store instruction
				end
				else
				begin
				//	NextInstruction[15:0] <= 16'd0;
				end
				
				// beq instruction - set PC in the case of two registers being equal
				if (Instruction[31:28] == beq)
				begin
					if(eqFlag) // if equal
						NextPC <= ReadData[14:0]; // set NextPC to the label
					else // otherwise
						NextPC <= PC + 2'd2; // PC Increments to the next instruction
				end
				// Jump instruction - setting PC for latching
				if (Instruction[31:28] == j)
				begin
					NextInstruction <=Instruction;
					NextPC <= {7'b0000_000,Instruction[27:16]}; // Assign next instruction;
				end
				//TODO: add jal instruction
//				if(Instruction[31:28] == jal)
//				begin
//					
//				end
			end 
			 Execute:
			 begin
				NextInstruction <=Instruction;
				NextPC <= PC;
			 end
			 default: 			 
			 begin
				NextInstruction <=Instruction;
				NextPC <=PC;
			 end

		 endcase
	 end
	 
	 
	 
	 
	 // IO Assignment - TODO:
	 // 						Fix what each state is taking as input/output
	 always @(*)
	begin
		case(PS)
		
			Fetch: // Entire clock cycle to receive next instruction
			begin
				Address <= {8'd0,PC}; // 24'b address using bank 0
				WriteData <= 16'bx;
				WriteEnable <= 1'b0;
				if(ReadData[15:12]  == load ||ReadData[15:12]  == store || ReadData[15:12] ==beq) // If incoming load, store or beq instruction
				begin
					Address <= {8'd0,PC+1'b1}; // Start trying to read Next word in memory
				end
			end
			
			Receive:
			begin
				Address <= {8'd0,PC}; // 24'b address using bank 0
				WriteData <= 16'bx;
				WriteEnable <= 1'b0;
				if(Instruction[31:28]  == load) // If incoming load instruction
				begin
					Address <= {Instruction[23:16],ReadData}; // Read From Load Address
				end
				if(Instruction[31:28]  == store) // Change outputs for store instruction
				begin
					WriteEnable<=1'b1;
					WriteData <= RFAout;
					Address <= {Instruction[23:16],ReadData}; // Read From store Address
				end
				if(Instruction[31:28] == wr)
				begin
					WriteEnable <=1'b1;
					WriteData <=RFAout;
					Address <= RFBout;
				end
			end
			Execute: 
			begin
				Address <= {8'd0,PC}; // 24'b address using bank 0
				WriteData <= 16'bx;
				WriteEnable <= 1'b0;
			end
			default: 
			begin
				Address <= {8'd0,PC}; // 24'b address using bank 0
				WriteData <= 16'bx;
				WriteEnable <= 1'b0;
			end
		endcase
	end
	
	
	// Assign Select Lines to where they can be found in the instruction
	assign RFWriteReg = Instruction[27:24];
	assign ARegSelect = (Instruction[31:28] == store || Instruction[31:28] == beq || Instruction [31:28] == wr)?Instruction[27:24]:Instruction[23:20];
	assign BRegSelect = (Instruction[31:28] == beq || Instruction [31:28] == wr)?    Instruction[23:20]:Instruction[19:16];
	// When to write to register file
	always @(*)
	begin
		if(PS == Execute)
		begin
			case(Instruction[31:28])
				add:		RFWriteEnable <=1'b1;
				addi:		RFWriteEnable <=1'b1;
				sub:		RFWriteEnable <=1'b1;
				load:		RFWriteEnable <= (Instruction[23:16] == 8'd0) ? 1'b1:1'b0; // Changed from load:		RFWriteEnable <=1'b1;
				store:	RFWriteEnable <=1'b0;
				seq:		RFWriteEnable <=1'b1;
				slt:		RFWriteEnable <=1'b1;
				beq:		RFWriteEnable <=1'b0;
				j:			RFWriteEnable <=1'b0;
				jal:		RFWriteEnable <=1'b0;
				shr:		RFWriteEnable <=1'b1;
				shl: 		RFWriteEnable <=1'b1;
				nan:		RFWriteEnable <=1'b1;
				loadi:	RFWriteEnable <=1'b1;
				wr: 		RFWriteEnable <=1'b0;
				default:	RFWriteEnable <=1'b0;
			endcase
		end
		else if(PS == Receive &&Instruction[31:28] == load&& Instruction[23:16] != 8'd0)
			RFWriteEnable <= 1'b1;
		else
			RFWriteEnable <=1'b0;
	end
	// assign RFWriteEnable =(PS == Execute); // TODO: Fix when the register file is written to so it 
															// isnt every execute stage -- DONE
	
	
	// Register File
	 RegisterFile RF(clk,ARegSelect,BRegSelect,RFWriteData,RFWriteReg,RFWriteEnable,RFAout,RFBout
	 //,R1Out,R2Out
	 );

	// ALU
		ALU alu(RFAout,RFBout,Instruction[31:16],ALUOutput,eqFlag);

	// Assign where the register file gets its write data from
		// Currently writes from alu as long as instruction is not a load
	assign RFWriteData = (Instruction[31:28] == load)? ReadData[15:0]: ALUOutput;
	 
endmodule
