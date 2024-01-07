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
// Description: A module that takes three values and dynamically showcases them on the 7-segment display. It updates its value every 0.5 seconds through a timer,
//						seamlessly switching between the three 7-segment displays in a rapid and repetitive manner.

//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module S_segment_displayer(en,svn_conf,DP,integer_data,float1_data,float2_data,clk,flag
    );
	
output reg [3:0]en;					// 7-seg enables
output reg [6:0]svn_conf;			// 7-seg number configs
output reg DP;							// Decimal point config
output reg flag;						// a flag to tell the voltage calculater to update its value every 0.5 seconds

input wire clk;						// 12 mg clock
input wire [3:0] integer_data;	// integer value of ADC to show on the first 7-seg
input wire [3:0] float1_data;		// first float number after point to show on the second 7-seg
input wire [3:0] float2_data;		// second float number after point to show on the third 7-seg

reg [15:0] count=16'b0;				// a counter to switch between the 7-seg
reg [1:0] count2=3'b0;				// 7-seg number to update value
reg [3:0] data_in=4'b0;

reg [22:0] timer = 0;				// a timer to display data every 0.5 seconds
reg [3:0] integer_data_reg;		// registering integer_data_reg
reg [3:0] float1_data_reg;			// registering float1_data_reg
reg [3:0] float2_data_reg;			// registering float2_data_reg




// the block of code that is reponsable to switch between the 7-segs to update its values  
always @ (posedge clk)
begin
	// wait some time to switch between 7-segs
	if(count<16'hbb80)
		count<=count+16'b1;
	
	//switch the 7-seg
	else
		begin
		count<=16'b0;
		if(count2<2'b10)
			count2<=count2+2'b1;
		else
			count2<=2'b0;
		end
	end


//the block of code responsable to update 7-seg every 0.5 seconds so we can see the values easly
always @(posedge clk)
begin

	// update the timer until it reaches 6000000 (that takes 0.5 seconds on 12 mg clock)
	if(timer<23'h5B8D80) 
		timer <= timer + 1; 
		
	// update 7-seg values
	else
		begin
			integer_data_reg <= integer_data;
			float1_data_reg <= float1_data;
			float2_data_reg <= float2_data;
			timer <= 0;
			flag <=1;
		end


end

	
// enabling and updating 7-seg individually every counter overflow
always @ (count2)
begin
 	{en,data_in}<=(count2==2'b0)?{4'b1110,integer_data_reg}:(count2==2'b01)?{4'b1101,float1_data_reg}
	:(count2==2'b10)?{4'b1011,float2_data_reg}:{4'b1111,4'b0};
end
	


// setting the decimal point when updating the first 7-seg	
always @(count2)
begin
	if(count2==2'b00)
	begin
		DP = 0;
	end
	else
	begin
		DP = 1;
	end
end


// setting 7-seg cong based on the integer that we want to show
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
