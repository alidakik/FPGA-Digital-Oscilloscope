`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:21:21 01/03/2024 
// Design Name: 
// Module Name:    spi 
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


module SPI(clk, sclk, din,dout,cs,dataout);

input clk;
output reg din;
output wire sclk;
input dout;
output reg cs;
output reg [11:0] dataout;


reg [11:0] data_temp;
reg clock_out;

reg ADD2,ADD1,ADDO;

reg [4:0] count;

initial
begin
	count = 4'd0;
	cs = 1;
	ADD2 = 1;
	ADD1 = 0;
	ADDO = 1;
	clock_out = 0;
	dataout = 12'd0;
	data_temp = 12'd0;
end

always@(negedge clk)
begin
	if (count == 1)
	begin
		cs <= 0;
	end
	

end

always@(posedge clk)
begin
	if (count ==16)
	begin
		count <= 0;
	end

end

assign sclk = cs?1:clk; //hardwire SCLK to clk;



always@(posedge clk)
begin
	count <= count + 4'd1;
end

always @(negedge clk)
begin
	case (count)
		3: begin
			din <= ADD2;
		end
		4: begin
			din <= ADD1;
		end
		5: begin
			din <= ADDO;
		end
endcase
end

always @(posedge clk)
begin
	case(count)
		4:		dataout<=data_temp;
		5:		data_temp[11]<=dout;
		6:		data_temp[10]<=dout;
		7:		data_temp[9]<=dout;
		8:		data_temp[8]<=dout;
		9:		data_temp[7]<=dout;
		10:		data_temp[6]<=dout;
		11:		data_temp[5]<=dout;
		12:		data_temp[4]<=dout;
		13:		data_temp[3]<=dout;
		14:		data_temp[2]<=dout;
		15:		data_temp[1]<=dout;
		16:		data_temp[0]<=dout;
		
	endcase

end


endmodule
