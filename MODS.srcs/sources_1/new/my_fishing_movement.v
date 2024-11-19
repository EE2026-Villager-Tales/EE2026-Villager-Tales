`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 11:55:48
// Design Name: 
// Module Name: my_fishing_movement
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


module my_fishing_movement(
    input basys_clk,
    input btnU, btnD, btnL, btnR, 
    input oled_sig,
    input fishing_view,
    output reg [6:0] char_x = 1, 
    output reg [5:0] char_y = 22,
    output reg facing_up = 0, 
    output reg facing_down = 1, 
    output reg facing_left = 0, 
    output reg facing_right = 0,
    output reg farming_view = 0,
    output reg fishing_start_pbC = 0,
    
    input fish,
    input btnC,
    output reg gobackFarmFromFish = 0
    );
    
    wire clk30;
    flexible_clock THIRTYHZ_CLK(.basys_clock(basys_clk), .count(1666666), .SLOW_CLOCK(clk30));
    
    always @(posedge clk30) 
        begin
        if (fish == 0) gobackFarmFromFish <= 0;
        if (btnC && char_x < 5) gobackFarmFromFish <= 1;
            if (btnU && fishing_view && oled_sig !=1) 
                begin
                    if (char_x >= 0 && char_x < 46)
                        char_y <= (char_y > 2) ? char_y - 1 : char_y;
                    else if (char_x >= 45 && char_x < 64)
                        char_y <= (char_y > 22) ? char_y - 1 : char_y;
                    else
                        char_y <= char_y;

                    facing_up <= 1;
                    facing_down <= 0;
                    facing_left <= 0;
                    facing_right <= 0;
                end
            else if (btnD && fishing_view && oled_sig !=1) 
                begin
                    if (char_x >= 0 && char_x < 46)
                        char_y <= (char_y < 47) ? char_y + 1 : char_y;
                    else if (char_x >= 45 && char_x < 64)
                        char_y <= (char_y < 24) ? char_y + 1 : char_y;
                    else
                        char_y <= char_y;
                    facing_up <= 0;
                    facing_down <= 1;
                    facing_left <= 0;
                    facing_right <= 0;
                end
            else if (btnL && fishing_view && oled_sig !=1) 
                begin
                    if (char_x > 0)
                        begin
                        char_x <= char_x - 1;
                        fishing_start_pbC <= 0;
                        end
                    else
                        begin
                        farming_view <= 1;
                        end
                    facing_up <= 0;
                    facing_down <= 0;
                    facing_left <= 1;
                    facing_right <= 0;
                end
            else if (btnR && fishing_view && oled_sig !=1) 
                begin
                    if ((char_y >= 0 && char_y < 22) || (char_y >= 25 && char_y < 49))
                        char_x <= (char_x < 45) ? char_x + 1 : char_x;
                    else if (char_y >= 22 && char_y < 25)
                        begin
                        if (char_x < 64)
                            begin
                            char_x <= char_x +1;
                            end
                        else
                            begin
                            char_x <= char_x;
                            fishing_start_pbC <= 1;
                            end
                        end
                    else
                        char_x <= char_x;
                    facing_up <= 0;
                    facing_down <= 0;
                    facing_left <= 0;
                    facing_right <= 1;
                end
        
        end
endmodule
