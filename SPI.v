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
// Description: A module that is responsable to communicate with the ADC hardware using SPI protocol
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SPI(clk, clk_noBuff, Resetn, sclk, din,cs,ADD,ADC2SPI,ADC2Sseg, start);

input clk;								// 12 mg clk
input clk_noBuff;						// 12 mg clk without a buffer
input Resetn;							// reset flag
input ADC2SPI;							// data comming from ADC hardware
input  [2:0] ADD;						// data to be send to the ADC to controll the input channel
input  start;							// start the communication when the clock is locked and ready

output reg din;						// the bridge to send data to ADC hardware
output wire sclk;						// the clk to sync the communaction betwee the this module and the ADC hardware
output reg cs;							// active low chip select to start sending and recieving data
output reg [11:0] ADC2Sseg;		// outputing the the seriel data that we got from the ADC parrarelly


reg [11:0] data_temp;				// a temp to latch the data so we update the output every 16 clock
reg start_reg;							// registering the start


reg [4:0] count;						// a counter to keep track of the timing of the communication


// initializing the data
initial begin
	cs<=1;
	count <= 4'd0;
	ADC2Sseg <= 12'd0;
	data_temp <= 12'd0;
end


// starting the protocol
always @(posedge clk)
begin
	if(start==1)
	begin
		start_reg<=1;
	end
end




// reseting
always @(posedge clk, posedge Resetn)
begin
	if (Resetn)
	begin
		//count <= 4'd0;
		//cs <= 1;
		//ADC2Sseg <= 12'd0;
		//data_temp <= 12'd0;
		//din <= 0;
	end
end


// starting the communcation with the ADC hardware
always@(posedge clk)
begin
	if (count == 1)
	begin
		cs <= 0;
	end
end

// creating the clock to sync the ADC hardware when the cs is ready
assign sclk = cs ? 1 : clk_noBuff;  //hardwire SCLK to clk;


// updating the count to keep track of time
always@(posedge clk)
begin
	if (count == 16)
	begin
		count <= 1;
	end
	else
	begin
		count <= count + 4'd1;
	end
end

// sending data serially at the clock we found according to the ADC datasheet
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


// recieving data serially at the clock we found according to the ADC datasheet
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
