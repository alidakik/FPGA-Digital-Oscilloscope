`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IUT_FPGA_Class
// Engineer: A.Dakik - M.Azarbayejani
// 
// Create Date:    16:14:19 01/04/2024 
// Design Name: 
// Module Name:    SPI 
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
module SPI(clk, clk_noBuff, Resetn, sclk, din,cs,ADD,ADC2SPI,ADC2Sseg);

input clk;
input clk_noBuff;
input Resetn;
input ADC2SPI;
input wire [2:0] ADD;

output reg din;
output wire sclk;
output reg cs;
output reg [11:0] ADC2Sseg;


reg [11:0] data_temp;
reg clock_out;



reg [4:0] count;

always @(posedge clk)
begin
	if (Resetn == 0)
	begin
		count <= 4'd0;
		cs <= 1;
		clock_out <= 0;
		ADC2Sseg <= 12'd0;
		data_temp <= 12'd0;
		din <= 0;
	end
end

always@(negedge clk)
begin
	if (count == 1)
	begin
		cs <= 0;
	end
end

assign sclk = cs ? 1 : clk_noBuff;  //hardwire SCLK to clk;

always@(posedge clk)
begin
	if (count == 16)
	begin
		count <= 0;
	end
	else
	begin
		count <= count + 4'd1;
	end
end


always @(negedge clk)
begin
	case (count)
		3: begin
			din <= ADD[2];
		end
		4: begin
			din <= ADD[1];
		end
		5: begin
			din <= ADD[0];
		end
endcase
end


always @(posedge clk)
begin
	case(count)
		4:		ADC2Sseg<=data_temp;
		5:		data_temp[11:11] <=  ADC2SPI;
		6:		data_temp[10:10] <=  ADC2SPI;
		7:		data_temp[9:9]   <=  ADC2SPI;
		8:		data_temp[8:8]   <=  ADC2SPI;
		9:		data_temp[7:7]   <=  ADC2SPI;
		10:		data_temp[6:6]   <=  ADC2SPI;
		11:		data_temp[5:5]   <=  ADC2SPI;
		12:		data_temp[4:4]   <=  ADC2SPI;
		13:		data_temp[3:3]   <=  ADC2SPI;
		14:		data_temp[2:2]   <=  ADC2SPI;
		15:		data_temp[1:1]   <=  ADC2SPI;
		16:		data_temp[0:0]   <=  ADC2SPI;
		
	endcase

end


endmodule
