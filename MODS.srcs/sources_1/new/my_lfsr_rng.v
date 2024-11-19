`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 11:58:19
// Design Name: 
// Module Name: my_lfsr_rng
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module my_lfsr_rng(
    input input_clk,
    output reg [3:0] output_num = 0
    );
        
    always @ (posedge input_clk)
    begin
            output_num[3] <= output_num[2];
            output_num[2] <= output_num[1];
            output_num[1] <= output_num[0];
            output_num[0] <= ~(output_num[2]^ output_num[3]);
    end
endmodule
