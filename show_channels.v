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
// Description: 
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
	
	reg [2:0] channel_addr_reg; 

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
        channel_addr_to_SPI <= channel_addr_reg;
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
