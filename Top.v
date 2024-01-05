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
		input  Clk_pin,
		input  Resetn_pin,

		//-- Adc interfaces ---
		input  Adc2Fpga_data,
		output Fpga2Adc_data,
		output Fpga2Adc_Csn,
		output Fpga2Adc_sclk,
		output sclk,
		
		//--- 7-segment --- 
		output [7:0] sseg,
		output [3:0] sseg_En,

		//  --- LED ---
		output [7:0] LED,
		input  [7:0] DipSwitch,

		output dcm_locked
    );
	
	wire [2:0] ADDR;
	wire [11:0] ADC2Sseg;
	
	wire Clk_12;
	wire Clk_24;
	
	
	
	//DONE
	clk_generator clk_generator
   (// Clock in portsS
    .CLK_IN1(Clk_pin),       // IN
    // Clock out ports
    .CLK_OUT1(Clk_12),       // OUT
    .CLK_OUT2(Clk_24),       // OUT
    // Status and control signals
    .RESET(Resetn_pin),      // IN
    .LOCKED(LOCKED),         // OUT
    .CLK_VALID(CLK_VALID));  // OUT
	 
	 
	 //DONE
	 SPI spi (
    .clk(Clk_12),           // IN
    .sclk(Fpga2Adc_sclk), 	 // OUT
    .din(Fpga2Adc_data),    // OUT
    .cs(Fpga2Adc_Csn),      // OUT
    .ADD(ADDR),             // IN
    .ADC2SPI(Adc2Fpga_data),// IN
    .ADC2Sseg(ADC2Sseg)     // OUT
    );

	//DONE
	S_segment_displayer sseg_displayer (
    .en(sseg_En),           // OUT
    .svn_conf(sseg[7:1]),   // OUT
    .DP(sseg[0]),           // OUT
    .data(ADC2Sseg), 		 // IN
    .clk(Clk_12)            // IN
    );
	
	//DONE
	show_channels led_displayer (
    .clk(Clk_12),                // IN
    .resetn(Resetn_pin),         // IN
    .channel_addr(DipSwitch),    // IN
    .led(LED),                   // OUT
    .channel_addr_to_SPI(ADDR)   // OUT
    );

endmodule
