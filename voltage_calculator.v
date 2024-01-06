`timescale 1ns / 1ps
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
// Description: 	A module to caclculate the value of the 3 7-segment from ADC register
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module voltage_calculater(
	input [11:0] ADC_data,						// the data that we get from the ADC register
	input clk,										// 12 mg clock
	input flag,										// a flag that comes from sseg_displayer to tell the voltage calculater to update its value every 0.5 seconds
														
	output reg [3:0] integer_data,			// integer value of ADC to show on the first 7-seg
	output reg [3:0] float1_data,				// first float number after point to show on the second 7-seg
	output reg [3:0] float2_data				// second float number after point to show on the third 7-seg
    );

	
	reg [15:0] voltage;
	
	
	always @(posedge clk) begin
		if(flag)
		begin
        
		  //check if the input voltage is more than 5 volts
		  if(ADC_data > 2000)
				voltage = 5000; //if so show 5 on 7-segments
		  else
				voltage = (ADC_data*5000) >> 11;  // else calculate the real value

		  
		  integer_data = voltage/1000;
		  float1_data = voltage %1000 / 100;
		  float2_data = voltage %100 / 10;
		  
		 // To use less component of the chip use the following three commands instead:
	  
	  /*	integer_data = voltage >> 10; // voltage / 1000
		*
		*  float1_data = voltage & (10'b1111111111) >> 7; // voltage % 1000 / 100
		*  
		*  float2_data = voltage & (4'b1111) >> 3; //voltage % 100 / 10;
		*/
		end
		
	 end
	

endmodule

