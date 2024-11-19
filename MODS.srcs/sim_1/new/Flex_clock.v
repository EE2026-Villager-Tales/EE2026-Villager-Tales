`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 02:18:32 PM
// Design Name: 
// Module Name: Flex_clock
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


module Flex_clock(
    );
    
    reg MAIN_CLK; //100MHZ
    reg [31:0] count = 7;
    wire CLK_6p25MHZ;
    
    
    flexible_clock flexible_clock(.basys_clock(MAIN_CLK),.count(count),.SLOW_CLOCK(CLK_6p25MHZ));
    
    initial 
    begin
        MAIN_CLK = 0;
    end
    
    always 
    begin
         #5 MAIN_CLK = ~MAIN_CLK;
    end

endmodule
