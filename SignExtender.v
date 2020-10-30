`timescale 1ns/1ps
module SignExtender(BusImm, Imm32);
	output reg [63:0] BusImm;
	input [31:0] Imm32;
	always @(*)
	begin
		//CB type
		if (Imm32[31:24] == 8'b01010100 || Imm32[31:24] == 8'b10110101)
			begin
				BusImm = {{43{Imm32[23]}}, Imm32[23:5]};
			end
		//D type
		else if(Imm32[31:21] == 11'b11111000010 || Imm32[31:21] == 11'b11111000000)
			begin
				BusImm = {{55{Imm32[20]}}, Imm32[20:12]};
			end
		//B type
		else if (Imm32[31:26] == 6'b000101 || Imm32[31:26] == 6'b100101)
			begin
				BusImm = {{36{Imm32[25]}}, Imm32[25:0]};
			end  
		//I type
		else if (Imm32[31:22] == 10'b1001000100 || Imm32[31:22] == 10'b1101000100)
			begin
				BusImm = {52'b0, Imm32[21:10]};
			end
		else
			begin
				BusImm = 64'b0;
			end
	end
endmodule
     
