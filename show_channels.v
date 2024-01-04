`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    input [7:0] channel_addr, //from DIP switch PIN
    // input [2:0] channel_addr;
    output reg [7:0] led    //Output to LED PIN
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

    assign led[0] = channel_addr[0:0];
    assign led[1] = channel_addr[1:1];
    assign led[2] = channel_addr[2:2];
    assign led[3] = channel_addr[3:3];
    assign led[4] = channel_addr[4:4];
    assign led[5] = channel_addr[5:5];
    assign led[6] = channel_addr[6:6];
    assign led[7] = channel_addr[7:7];
	
    // assign led[0] = (channel_addr_reg == 3'b000) ? 1:0;
    // assign led[1] = (channel_addr_reg == 3'b001) ? 1:0;
    // assign led[2] = (channel_addr_reg == 3'b010) ? 1:0;
    // assign led[3] = (channel_addr_reg == 3'b011) ? 1:0;
    // assign led[4] = (channel_addr_reg == 3'b100) ? 1:0;
    // assign led[5] = (channel_addr_reg == 3'b101) ? 1:0;
    // assign led[6] = (channel_addr_reg == 3'b110) ? 1:0;
    // assign led[7] = (channel_addr_reg == 3'b111) ? 1:0;

endmodule