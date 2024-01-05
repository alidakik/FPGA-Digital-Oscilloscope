mescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: A.Dakik
// 
// Create Date:    23:08:15 01/05/2024 
// Design Name: 
// Module Name:    voltage_calculater 
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
module voltage_calculater(
	input [11:0] ADC_data,
	input clk,
	output reg [7:0] integer_data,
	output reg [7:0] float1_data,
	output reg [7:0] float2_data
    );

	
	reg [15:0] voltage;
	

	
	always @(posedge clk) begin
        voltage = (ADC_data*5000) >> 12; 
		  
		  integer_data = voltage >> 10; // voltage / 1000
		  float1_data = voltage & (10'b1111111111) >> 7; // voltage % 1000 / 100
		  float2_data = voltage & (4'b1111) >> 3; //voltage % 100 / 10;
    end
	
	

endmodule

