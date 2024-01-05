`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:54 01/04/2024 
// Design Name: 
// Module Name:    Top 
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
module Top(
		input Clk_pin,
		input Resetn_pin,

		//-- Adc interfaces ---
		input Adc2Fpga_data,
		output reg Fpga2Adc_data,
		output reg Fpga2Adc_Csn,
		output reg Fpga2Adc_sclk,
		output reg sclk,
		//--- 7-segment --- 
		output reg [7:0] sseg,
		output reg [3:0] sseg_En,

		//  --- LED ---
		output reg [7:0] LED,
		input [7:0] DipSwitch,

		output dcm_locked
    );
	
	reg Adc2Fpga_data_reg = Adc2Fpga_data;
	reg [7:0] DipSwitch_reg = DipSwitch;
	wire [2:0] ADDR;
	wire [11:0] ADC2Sseg;
	
	wire Clk_12;
	wire Clk_24;
	
	
	
	//DONE
	clk_generator clk_generator
   (// Clock in ports
    .CLK_IN1(Clk_pin),      // IN
    // Clock out ports
    .CLK_OUT1(Clk_12),     // OUT
    .CLK_OUT2(Clk_24),     // OUT
    // Status and control signals
    .RESET(Resetn_pin),// IN
    .LOCKED(LOCKED),       // OUT
    .CLK_VALID(CLK_VALID));   // OUT
	 
	 
	 //DONE
	 SPI spi (
    .clk(Clk_12), 
    .sclk(Fpga2Adc_sclk), 
    .din(Fpga2Adc_data), 
    .cs(Fpga2Adc_Csn), 
    .ADD(ADDR), 
    .ADC2SPI(Adc2Fpga_data), 
    .ADC2Sseg(ADC2Sseg), 
    //.ready(ready)
    );

	//DONE
	S_segment_displayer sseg_displayer (
    .en(en), 
    .svn_conf(sseg[7:1]), 
    .DP(sseg[0]), 
    .data(ADC2Sseg), 
    .clk(Clk_12)
    );
	
	//DONE
	show_channels led_displayer (
    .clk(Clk_12), 
    .resetn(Resetn_pin), 
    .channel_addr(DipSwitch_reg), 
    .led(LED), 
    .channel_addr_to_SPI(ADDR) //vasl she
    );

endmodule
