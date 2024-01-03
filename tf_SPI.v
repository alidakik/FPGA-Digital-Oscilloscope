mescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:34:09 01/03/2024
// Design Name:   SPI
// Module Name:   C:/Users/vboxuser/FPGA/Project_1/tf_SPI.v
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

module tf_SPI;

	// Inputs
	reg clk;
	reg dout;

	// Outputs
	wire sclk;
	wire din;
	wire cs;
	wire [11:0] dataout;

	reg [3:0] i = 0;
	reg [11:0] word = 12'b101011000101;
	// Instantiate the Unit Under Test (UUT)
	SPI uut (
		.clk(clk), 
		.sclk(sclk), 
		.din(din), 
		.dout(dout), 
		.cs(cs), 
		.dataout(dataout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		dout = 0;

		// Wait 100 ns for global reset to finish
		#100;
		repeat(160)
		begin
		//i<=0;
		repeat(16)
		//always @(posedge clk)
		begin
			//if(i==16)
		//	begin
				//	i<=0;
			//end
			
			if(i<4)
			begin
				dout<=0;
			end
			
			else
			begin
				dout<=word[15-i];
			end
			i <= i+1;
			
			#100;
		end
		end
       
		// Add stimulus here

	end
	
	always #(50) clk<=~clk;
	
      
endmodule


