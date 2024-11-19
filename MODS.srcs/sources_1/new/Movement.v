`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 00:56:08
// Design Name: 
// Module Name: Movement
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


module Movement(input basys_clock, input btnU, btnD, btnL, btnR, input gobackFarm, input gobackFarmFromFish, input gobackFarmFromHome, output reg [6:0] char_x = 45, output reg [5:0] char_y = 28 ,
output reg facing_up = 0, output reg facing_down = 1, output reg facing_left = 0, output reg facing_right = 0);

    wire clk30;
    flexible_clock THIRTYHZ_CLK(.basys_clock(basys_clock), .count(1666666), .SLOW_CLOCK(clk30));
    
    always @(posedge clk30) begin
    if (gobackFarmFromHome == 1) begin
    char_x <= 47;
    char_y <= 25;
    end
    if (gobackFarmFromFish == 1) begin
    char_x <= 65;
    char_y <= 27;
    end
    if (gobackFarm == 1) begin
    char_x <= 47;
    char_y <= 45;
    end
    if (btnU) begin
    char_y <= (char_y > 3) ? char_y - 1 : char_y;
    facing_up <= 1;
    facing_down <= 0;
    facing_left <= 0;
    facing_right <= 0;
    end
    else if (btnD) begin
    char_y <= (char_y < 49) ? char_y + 1 : char_y;
    facing_up <= 0;
    facing_down <= 1;
    facing_left <= 0;
    facing_right <= 0;
    end
    else if (btnL) begin
    char_x <= (char_x > 0) ? char_x - 1 : char_x;
    facing_up <= 0;
    facing_down <= 0;
    facing_left <= 1;
    facing_right <= 0;
    end
    else if (btnR) begin
    char_x <= (char_x < 85) ? char_x + 1 : char_x;
    facing_up <= 0;
    facing_down <= 0;
    facing_left <= 0;
    facing_right <= 1;
    end
    
    end
endmodule
