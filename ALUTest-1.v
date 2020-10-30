`timescale 1ns / 1ps

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	initial
		begin
			$dumpfile("ALUTest_v.vcd");
			$dumpvars(0,ALUTest_v);
		end

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
	    {BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h2}; #40; passTest({Zero, BusW}, 65'h0D91AC578, "ADD1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E373, 4'h2}; #40; passTest({Zero, BusW}, 65'h097ECAC0A0D, "ADD2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h2}; #40; passTest({Zero, BusW}, 65'h01C6174D719B3, "ADD3", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h0}; #40; passTest({Zero, BusW}, 65'h05A0C4A39, "AND1", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h0}; #40; passTest({Zero, BusW}, 65'h0CA495201A00, "AND2", passed);
		{BusA, BusB, ALUCtrl} = {64'h9C212C90E109EF50, 64'hAF93053C8CA68455, 4'h0}; #40; passTest({Zero, BusW}, 65'h08C01041080008450, "AND3", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h1}; #40; passTest({Zero, BusW}, 65'h07F0E7B3F, "ORR1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E373, 4'h1}; #40; passTest({Zero, BusW}, 65'h97E67BE7FB, "ORR2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h1}; #40; passTest({Zero, BusW}, 65'h0FBCDFB6FFB3, "ORR3", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'b0110}; #40; passTest({Zero, BusW}, 65'h024FDD106, "SUB1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E373, 4'b0110}; #40; passTest({Zero, BusW}, 65'h06D9FC64327, "SUB2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'b0110}; #40; passTest({Zero, BusW}, 65'h02E7C595E3B1, "SUB3", passed);
		
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h7}; #40; passTest({Zero, BusW}, 65'h5A0E7A39, "PASS1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E373, 4'h7}; #40; passTest({Zero, BusW}, 65'h152672E373, "PASS2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h7}; #40; passTest({Zero, BusW}, 65'hCBCD7A09B01, "PASS3", passed);
		allPassed(passed, 22);
	end
      
endmodule

