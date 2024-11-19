`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2024 11:29:21
// Design Name: 
// Module Name: my_fishing_sequence_counter
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


module my_fishing_sequence_counter(
    input basys_clk,
    input fishing_start_pbC,
    input oled_sig,
    output reg [4:0] my_sequence = 0);
    
    wire clk_250ms;
    flexible_clock fc_250ms (.basys_clock(basys_clk),.count(12_499_999),.SLOW_CLOCK(clk_250ms));
    
    always @ (posedge clk_250ms)
        begin
            if(oled_sig == 0 || fishing_start_pbC == 0)
                begin
                    my_sequence <= 5'b00000;
                end
            else if (oled_sig == 1 && fishing_start_pbC == 1)
                begin
                    if (my_sequence[4:0] < 5'b11000)
                        my_sequence <= my_sequence+1;
                    else
                        my_sequence <= 5'b11000;
                end
        end
    
    
endmodule
