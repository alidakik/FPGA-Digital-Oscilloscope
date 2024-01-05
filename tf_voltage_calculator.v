mescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: A.Dakik
//
// Create Date:   23:22:11 01/05/2024
// Design Name:   voltage_calculater
// Module Name:   C:/Users/vboxuser/FPGA/Project_1/tf_voltage_calculater.v
// Project Name:  Project_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: voltage_calculater
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tf_voltage_calculater;

	// Inputs
	reg [11:0] ADC_data;
	reg clk;
	// Outputs
	wire [7:0] integer_data;
	wire [7:0] float1_data;
	wire [7:0] float2_data;

	// Instantiate the Unit Under Test (UUT)
	voltage_calculater uut (
		.clk(clk),
		.ADC_data(ADC_data), 
		.integer_data(integer_data), 
		.float1_data(float1_data), 
		.float2_data(float2_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		ADC_data = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      		ADC_data = 4095;  
		// Add stimulus here

	end
      
	always #(21) clk<=~clk;

endmodule


