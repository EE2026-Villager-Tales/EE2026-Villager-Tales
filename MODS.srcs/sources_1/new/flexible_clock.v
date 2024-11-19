`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 02:11:05 PM
// Design Name: 
// Module Name: flexible_clock
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
module flexible_clock(
    input basys_clock,
    input [31:0]count,
    output reg SLOW_CLOCK = 0
    );
    
    reg [31:0] COUNT = 0;  // 31-bit counter for COUNT_MAX = 33,499,999

always @ (posedge basys_clock)
begin
    COUNT <= (COUNT == count) ? 0 : COUNT + 1;
    SLOW_CLOCK <= (COUNT == 0) ? ~SLOW_CLOCK : SLOW_CLOCK;
end

endmodule