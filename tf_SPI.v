`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:43:04 01/04/2024
// Design Name:   SPI
// Module Name:   C:/Users/vboxuser/FPGA/Project_1/tf_spi.v
// Project Name:  Project_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SPI
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tf_spi;

	// Inputs
	reg clk;
	reg [2:0] ADD;
	reg ADC2SPI;

	// Outputs
	wire sclk;
	wire din;
	wire cs;
	wire [11:0] ADC2Sseg;


	reg [3:0] i = 0;
	reg [11:0] word = 12'b101011000101;
	// Instantiate the Unit Under Test (UUT)
	SPI uut (
		.clk(clk), 
		.sclk(sclk), 
		.din(din), 
		.cs(cs), 
		.ADD(ADD), 
		.ADC2SPI(ADC2SPI), 
		.ADC2Sseg(ADC2Sseg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		ADD = 0;
		ADC2SPI = 0;

		// Wait 100 ns for global reset to finish
		#100;
      repeat(160)
		begin
		ADD[0] = 1;
		ADD[1] = 0;
		ADD[2] = 1;
			repeat(16)
			begin
				
				if(i<4)
				begin
					ADC2SPI<=0;
				end
				
				else
				begin
					ADC2SPI<=word[15-i];
				end
				i <= i+1;
				
				#100;
			end
		end
		  
		
		// Add stimulus here

	end
      
	
	always #(50) clk<=~clk;

endmodule

