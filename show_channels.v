`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IUT_FPGA_Class
// Engineer: M.Azarbayejani
// 
// Create Date:    10:54:11 01/04/2024 
// Design Name: 
// Module Name:    show_channels 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:  A module designed to read the DIP switch values from the MEGAWING and display them on the board's LEDs.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module show_channels(
    input clk,
    input resetn,
    input [7:0] channel_addr,              //from DIP switch PIN
    // input [2:0] channel_addr,
    output reg  [7:0] led,                 //Output to LED PIN
    output reg [2:0] channel_addr_to_SPI       //Output to SPI
    );
	
	reg [7:0] channel_addr_reg; 

	always@(posedge clk)
	begin
		if(!resetn)
		begin
			channel_addr_reg <= 0;
		end
		else
		begin
			channel_addr_reg <= channel_addr;
		end
	end

    // ----- Send channel address to SPI -----
    always @(posedge clk)
    begin
         case(channel_addr_reg)
            8'b00000001: channel_addr_to_SPI <= 3'b000;
            8'b00000010: channel_addr_to_SPI <= 3'b001;
            8'b00000100: channel_addr_to_SPI <= 3'b010;
            8'b00001000: channel_addr_to_SPI <= 3'b011;
            8'b00010000: channel_addr_to_SPI <= 3'b100;
            8'b00100000: channel_addr_to_SPI <= 3'b101;
            8'b01000000: channel_addr_to_SPI <= 3'b110;
            8'b10000000: channel_addr_to_SPI <= 3'b111;
            default: channel_addr_to_SPI <= 3'b000;
    endcase
    end

    // ----- Send channel address to LED -----
	 
	 
	always@(posedge clk)
	begin 
        led <= channel_addr_reg;
	end 
    // assign led[0] = (channel_addr_reg == 3'b000) ? 1:0;
    // assign led[1] = (channel_addr_reg == 3'b001) ? 1:0;
    // assign led[2] = (channel_addr_reg == 3'b010) ? 1:0;
    // assign led[3] = (channel_addr_reg == 3'b011) ? 1:0;
    // assign led[4] = (channel_addr_reg == 3'b100) ? 1:0;
    // assign led[5] = (channel_addr_reg == 3'b101) ? 1:0;
    // assign led[6] = (channel_addr_reg == 3'b110) ? 1:0;
    // assign led[7] = (channel_addr_reg == 3'b111) ? 1:0;

endmodule
