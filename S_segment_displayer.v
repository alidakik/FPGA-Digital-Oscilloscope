`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IUT_FPGA_Class
// Engineer: A.Dakik
// 
// Create Date:    16:15:22 01/04/2024 
// Design Name: 
// Module Name:    S_segment_displayer 
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
module S_segment_displayer(en,svn_conf,DP,intege_data,float1_data,float2_data,clk
    );
	
output reg [3:0]en;
output reg [6:0]svn_conf;
output reg DP;
 
input wire clk;

input wire [3:0] integer_data;
input wire [3:0] float1_data;
input wire [3:0] float2_data;

reg [15:0] count=16'b0;
reg [1:0] count2=3'b0;
reg [3:0] data_in=4'b0;

reg [22:0] timer = 0;	// to display data every 0.5 seconds
reg [3:0] integer_data_reg;
reg [3:0] float1_data_reg;
reg [3:0] float2_data_reg;



always @ (posedge clk)
begin
	if(count<16'hbb80)
		count<=count+16'b1;
	else
		begin
		count<=16'b0;
		if(count2<2'b10)
			count2<=count2+2'b1;
		else
			count2<=2'b0;
		end
	end


always @(posedge clk)
begin
	if(timer<23'h5B8D80)
		timer <= timer + 1;
	else
		begin
			integer_data_reg <= integer_data;
			float1_data_reg <= float1_data;
			float2_data_reg <= float2_data;
		end


end

	
always @ (count2 or timer)
begin
 	{en,data_in}<=(count2==2'b0)?{4'b1110,float2_data_reg}:(count2==2'b01)?{4'b1101,float1_data_reg}
	:(count2==2'b10)?{4'b1011,integer_data_reg}:{4'b1111,4'b0};
	end
	
always @(count2)
begin
	if(count2==2'b10)
	begin
		DP = 1;
	end
	else
	begin
		DP = 0;
	end
end


always @ ( data_in )
begin
	case ( data_in )
		4'b0000 : svn_conf <= 7'b1000000 ;
		4'b0001 : svn_conf <= 7'b1111001 ;
		4'b0010 : svn_conf <= 7'b0100100 ;
		4'b0011 : svn_conf <= 7'b0110000 ;
		4'b0100 : svn_conf <= 7'b0011001 ;
		4'b0101 : svn_conf <= 7'b0010010 ;
		4'b0110 : svn_conf <= 7'b0000010 ;
		4'b0111 : svn_conf <= 7'b1111000 ;
		4'b1000 : svn_conf <= 7'b0000000 ;
		4'b1001 : svn_conf <= 7'b0010000 ;
		4'b1010 : svn_conf <= 7'b0001000 ;
		4'b1011 : svn_conf <= 7'b0000011 ;
		4'b1100 : svn_conf <= 7'b1000110 ;
		4'b1101 : svn_conf <= 7'b0100001 ;
		4'b1110 : svn_conf <= 7'b0000110 ;
		4'b1111 : svn_conf <= 7'b0001110 ;
		default : svn_conf <= 7'b1000000 ;
	endcase
end
 

endmodule
