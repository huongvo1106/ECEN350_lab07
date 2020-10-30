`timescale 1ns / 1ps
module SignExtender_tb;
	reg [31:0] inst;
	wire[63:0] extended;
	reg[63:0] expected_out;
	SignExtender uut(.BusImm(extended), .Imm32(inst));
	
	task passTest;
		input[63:0] actualOut, expectedOut;
		if (actualOut == expectedOut)
			begin
				$display ("%0t - Test Passed.", $time);
			
			end
		else
			begin
				$display ("%0t - Test Failed.", $time);
				$display ("Actual Out - %H", actualOut);
				$display ("Expected Out - %H", expectedOut);
			end
	endtask
	
	initial
	begin
		inst = 0;
		expected_out = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
		
		//CB type
		#1 inst = {8'b0101_0100, 19'b010_0101_0101_0101_0101, 5'b0_0000};
		expected_out = {{45{1'b0}}, 19'b010_0101_0101_0101_0101};
		#1 passTest(extended, expected_out);
		
		#1 inst = {8'b10110101, 19'b101_0101_0101_0101_0101, 5'b0_0000};
		expected_out = {{45{1'b1}}, 19'b101_0101_0101_0101_0101};
		#1 passTest(extended, expected_out);
		
		//D type
		#1 inst = {11'b111_1100_0000, 9'b0_1010_1010, 2'b00, 5'b0_0000, 5'b0_0000};
		expected_out = {{55{1'b0}}, 9'b0_1010_1010};
		#1 passTest(extended, expected_out);
		
		#1 inst = {11'b111_1100_0010, 9'b1_0101_0101, 2'b00, 5'b0_0000, 5'b0_0000};
		expected_out = {{55{1'b1}}, 9'b1_0101_0101};
		#1 passTest(extended, expected_out);
		
		//B type
		#1 inst = {6'b00_0101, 26'b01_0101_0101_0101_0101_0101_0101};
		expected_out = {{38{1'b0}}, 26'b01_0101_0101_0101_0101_0101_0101};
		#1 passTest(extended, expected_out);
		
		#1 inst = {6'b10_0101, 26'b10_1010_1010_1010_1010_1010_1010};
		expected_out = {{38{1'b1}}, 26'b10_1010_1010_1010_1010_1010_1010};
		#1 passTest(extended, expected_out);
		
		//I type
		#1 inst = {10'b10_0100_0100, 12'b0101_1010_1010, 5'b0_0000, 5'b0_0000};
		expected_out = {{52{1'b0}}, 12'b0101_1010_1010};
		#1 passTest(extended, expected_out);
		
		#1 inst = {10'b11_0100_0100, 12'b1010_1010_1010, 5'b0_0000, 5'b0_0000};
		expected_out = {{52{1'b0}}, 12'b1010_1010_1010};
		#1 passTest(extended, expected_out);
		
		$finish;
	end
endmodule
		
