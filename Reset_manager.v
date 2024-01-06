`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:11 01/05/2024 
// Design Name: 
// Module Name:    Reset_manager 
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
module Reset_manager(
	input clk_i,       // 12MHZ buffg
	input resetn_i,    // Reset from PushButton
	input dcm_locked,  // Locked from DCM
	
	output reg Resetn      // System stable synchronous Reset 
    );

// Generate the internal reset - it is asserted whenever the reset pin
// is asserted, or the DCM is not locked
wire internal_rst_En ;
assign internal_rst_En = !resetn_i || !dcm_locked ;
 
 
reg     rst_meta;        // After sampling the async rst, this has
                         // a high probability of being metastable.
                         // The second sampling (rst_dst) has
                         // a much lower probability of being
                         // metastable

always @(posedge  clk_i )
  begin
    if (internal_rst_En == 0)
    begin
      rst_meta <= 1'b1;
      Resetn  <= 1'b1;
    end
    else
    begin
      rst_meta <= 1'b0;
      Resetn  <= rst_meta;
    end 
  end 

endmodule
