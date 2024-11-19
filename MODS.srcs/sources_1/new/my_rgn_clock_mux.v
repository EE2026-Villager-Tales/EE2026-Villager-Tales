`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 11:57:38
// Design Name: 
// Module Name: my_rgn_clock_mux
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


module my_rgn_clock_mux(
    input basys_clk,
    input debounced_sigC,
    input debounced_sigU,
    output reg output_clock = 0
    );
    
    wire clk_1kHz;
    flexible_clock fc_1kHz (.basys_clock(basys_clk),.count(49_999),.SLOW_CLOCK(clk_1kHz));

    
    wire clk_10Hz;
    flexible_clock fc_10Hz (.basys_clock(basys_clk),.count(4_999_999),.SLOW_CLOCK(clk_10Hz));
    
    always @ (posedge clk_1kHz)
    begin
        if (debounced_sigC == 0)
            output_clock <= clk_10Hz;
        else
            output_clock <= 0;
    end
    
    
    
endmodule
