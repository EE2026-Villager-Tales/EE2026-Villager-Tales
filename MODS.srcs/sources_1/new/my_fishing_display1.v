`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2024 14:44:47
// Design Name: 
// Module Name: my_fishing_display1
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


module my_fishing_display1(
    input basys_clk,
    input [15:0] sw,
    input [6:0] x,
    input [5:0] y,
    output reg [15:0] oled_data = 0
    );
    
    wire clk_25MHz;
    flexible_clock fc_25MHz (.basys_clock(basys_clk),.count(2),.SLOW_CLOCK(clk_25MHz));
    
    always @ (posedge clk_25MHz)
        begin
            // Background
            // Brown Bridge Outline
            if ( (((y == 20) || (y == 40)) && ( x >= 45 && x <= 75)) || 
                ( ((x == 45) || (x == 49) || (x == 53) || (x == 59) || (x == 61) || (x == 67) || (x == 69) || (x == 75) ) && ( y >= 20 && y <= 40) ) ||
               ( (x == 61 || x == 69) && (y == 22 || y ==40) ) )
                begin
                oled_data <= 16'b00111_001001_00011; // Border brown
                end
            
            // Brown Bridge first staircase
                else if ( (x >= 46 && x <= 48) && (y >= 21 && y <= 39) )
                begin
                oled_data <= 16'b01101_001111_00101; // 1st dark brown
                end
        
            // Brown Bridge second staircase
                else if ( (x >= 50 && x <= 52) && (y >= 21 && y <= 39) )
                begin
                oled_data <= 16'b01110_010001_00110; // 2nd dark brown
                end
        
            // Brown Bridge platform
                else if ( ((x >= 54 && x <= 58) || (x >= 62 && x <= 66) || (x >= 70 && x <= 74)) && (y >= 21 && y <= 39) )
                begin
                oled_data <= 16'b10001_010100_00111; // 3rd dark brown
                end
        
            // Yellow Sand Outline
            else if ( ( (x==37) && ((y >=0 && y <= 13) || (y >=47 && y <= 63)) ) ||
                ( (x==44) && (y >=20 && y <= 40) ) ||
                ( (y == (84 - x)) && (x>=37 && x<=44) ) ||
                ( (y == (x - 24)) && (x>=37 && x<=44) ) )
                begin
                oled_data <= 16'b11111_110000_00010; // Border Yellow
                end
        
            // Yellow Sand
            else if ( ( (x >= 0 && x<=36) && ((y >=0 && y <= 20) || (y >=40 && y <= 63)) ) ||
                ( (x >= 0 && x<=43) && (y >=20 && y <= 40) ) ||
                ( (y <= (83 - x)) && (x>=36 && x<=43) && (y >= 21)) ||
                ( (y >= (x - 23)) && (x>=36 && x<=43) && (y <= 39)) )
                begin
                oled_data <= 16'b11110_111000_10011; // Light Yellow
                end
        
            // Light Blue Outline
            else if ( ( (x==38) && ((y >=0 && y <= 13) || (y >=47 && y <= 63)) ) ||
                ( (y == (85 - x)) && (x>=38 && x<=44) ) ||
                ( (y == (x - 25)) && (x>=38 && x<=44) ) ||
                ( (x >= 44 && x <= 76) && ((y==19) || (y==41)) ) ||
                ( (x == 76) && (y>=19 && y<=41) ) )
                begin
                oled_data <= 16'b10001_100111_11101; // Light Blue Border
                end
        
            // Blue Sea
            else
                begin
                oled_data <= 16'b01001_011011_11110; // Normal Blue
                end

            // Character front view
            // Black outline
            if ( ((y == 20) && ((x >= 63) && (x <= 69))) || // Face
                 ((y == 21) && (((x >= 61) && (x <= 62)) || ((x >= 70) && (x <= 71)))) || // Face
                 ((y == 22) && ((x == 60) || (x == 72))) || // Face
                 ((y == 23) && (((x >= 61) && (x <= 62)) || ((x >= 70) && (x <= 71)))) || // Face
                 ((y == 24) && ((x == 61) || (x == 70))) || // Face
                 ((y == 25) && ((x == 61) || (x == 64) || (x == 67) || (x == 70))) || // Face
                 ((y == 26) && ((x == 61) || (x == 70))) || // Face
                 ((y == 27) && ((x == 62) || (x == 69))) || // Face
                 ((y == 28) && ((x == 62) || (x == 69))) || // Shirt
                 ((y == 29) && ((x >= 59 && x <= 61) || (x >= 70 && x<= 72))) || // Shirt
                 ((y == 30) && ((x == 58) || (x == 73))) || // Shirt
                 ((y == 31) && ((x == 58) ||(x == 62) || (x == 69) || (x == 73))) || // Shirt
                 ((y == 32) && ((x >= 59 && x <= 62) || (x >= 69 && x<= 72))) || // Shirt
                 ((y == 33) && ((x == 62) || (x == 69))) || // Pants
                 ((y == 34) && ((x == 62) || (x == 69))) || // Pants
                 ((y == 35) && ((x == 62) ||(x == 65) || (x == 66) || (x == 69))) || // Shirt
                 ((y == 36) && ((x == 62) ||(x == 65) || (x == 66) || (x == 69))) || // Shirt
                 ((y == 37) && ((x == 61) ||(x == 65) || (x == 66) || (x == 70))) || // Shoes
                 ((y == 38) && ((x == 61) ||(x == 65) || (x == 66) || (x == 70))) || // Shoes
                 ((y == 39) && ((x >= 62) && (x <= 69))) ) // Shoes
                    begin
                        oled_data <= 16'b00000_000000_00000; // Black
                    end
            // Hat
            else if ( ((y >= 21 && y <= 22) && ((x >= 61) && (x <= 70))) )
                begin
                oled_data <= 16'b11111_110000_00010; // Dark yellow
                end
            // Hair and Shoes
            else if ( ((y == 23) && ((x >= 63) && (x <= 68))) || // Hair
                      ((y == 24) && ((x == 62) || (x == 69))) || // Hair
                      ((y == 25) && ((x == 62) || (x == 69))) || // Hair
                      ((y >= 37 && y <= 38) && (x >= 62 && x <= 69)) ) // Shoes
                begin
                oled_data <= 16'b10001_010100_00111; // Brown
                end
            // Face and Hands
            else if ( ((y >= 24 && y <= 27) && (x >= 62 && x <= 69)) || //Face
                  (((y >= 30) && (y <= 31)) && ((x == 59) || (x == 72))) ) //Hand
                begin
                oled_data <= 16'b11110_111000_10011; // Light Yellow 2
                end
            // Shirt
            else if ( (((y >= 29) && (y <= 32)) && ((x >= 60) && (x <= 71))) || 
                      ((y == 28) && ((x >= 63) && (x <= 68))) )
                begin
                oled_data <= 16'b00100_101100_01001; // Green
                end
            // Dark Blue Pants
            else if ( (((y >= 32) && (y <= 36)) && ((x >= 63) && (x <= 68))))
                begin
                oled_data <= 16'b00110_001101_10011; // Dark Blue
                end
        
        end
            
endmodule
