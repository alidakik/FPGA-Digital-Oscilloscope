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
		
		//--- 7-segment --- 
		output [7:0] sseg,
		output [3:0] sseg_En,

		//  --- LED ---
		output [7:0] LED,
		input  [7:0] DipSwitch,

		output led_dcm_locked
    );
	
	wire [2:0] ADDR;
	wire [11:0] ADC2Sseg;
		
	wire Clk_24;
	wire Clk_12;
	wire Clk_12_noBuff;
	
	wire locked_wire;
	wire Resetn;
	
	assign led_dcm_locked = locked_wire;
	
	
	//DONE
	clk_generator clk_generator
   (
    .CLK_IN1(Clk_pin),           // IN
    
    .CLK_OUT1(Clk_24),           // OUT noBuffer
    .CLK_OUT2(Clk_12),           // OUT BUFG
    .CLK_OUT3(Clk_12_noBuff),
	 
    .RESET( ! Resetn_pin),       // IN 
    .LOCKED(locked_wire),        // OUT
    .CLK_VALID(CLK_VALID)        // OUT
	 );
	 
	 //DONE
	 Reset_manager Reset_ins (
    .clk_i(Clk_12),              // IN
    .resetn_i(Resetn_pin),       // IN
    .dcm_locked(locked_wire),    // IN
    .Resetn(Resetn)              // OUT
    );

	 //DONE
	 SPI spi (
    .clk(Clk_12),               // IN
    .clk_noBuff(Clk_12_noBuff), // IN
	 .Resetn(Resetn),           // IN
	 .sclk(Fpga2Adc_sclk), 	    // OUT
    .din(Fpga2Adc_data),        // OUT
    .cs(Fpga2Adc_Csn),          // OUT
    .ADD(ADDR),                 // IN
    .ADC2SPI(Adc2Fpga_data),    // IN
    .ADC2Sseg(ADC2Sseg)         // OUT
    );

	//DONE
	S_segment_displayer sseg_displayer (
    .en(sseg_En),           // OUT
    .svn_conf(sseg[7:1]),   // OUT
    .DP(sseg[0]),           // OUT
    .data(ADC2Sseg), 	    // IN
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
// Reset MAnager

endmodule
