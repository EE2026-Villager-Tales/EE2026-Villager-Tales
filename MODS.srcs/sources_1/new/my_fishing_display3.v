`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2024 16:14:30
// Design Name: 
// Module Name: my_fishing_display3
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


module my_fishing_display3(
    input basys_clk,
    input [15:0] sw,
    input [6:0] x,
    input [5:0] y,
    input [6:0] char_x, 
    input [5:0] char_y,
    input facing_down,
    input facing_up,
    input facing_left,
    input facing_right,
    output reg [15:0] oled_data = 0
    );
    
    wire clk_25MHz;
    flexible_clock fc_25MHz (.basys_clock(basys_clk),.count(2),.SLOW_CLOCK(clk_25MHz));
    
    always @ (posedge clk_25MHz)
        begin
            // Background
            // Brown Bridge Outline
            if ( (((y == 22) || (y == 38)) && ( x >= 54 && x <= 70)) || 
                ( ((x == 54) || (x == 56) || (x == 58) || (x == 62) || (x == 66) || (x == 70) ) && ( y >= 22 && y <= 38) ) )
                begin
                oled_data <= 16'b00111_001001_00011; // Border brown
                end
            
            // Brown Bridge first staircase
                else if ( (x == 55) && (y >= 23 && y <= 37) )
                begin
                oled_data <= 16'b01101_001111_00101; // 1st dark brown
                end
        
            // Brown Bridge second staircase
                else if ( (x == 57) && (y >= 23 && y <= 37) )
                begin
                oled_data <= 16'b01110_010001_00110; // 2nd dark brown
                end
        
            // Brown Bridge platform
                else if ( ((x >= 59 && x <= 61) || (x >= 63 && x <= 65) || (x >= 67 && x <= 69)) && (y >= 23 && y <= 37) )
                begin
                oled_data <= 16'b10001_010100_00111; // 3rd dark brown
                end
        
            // Yellow Sand Outline
            else if ( ( (x==52) && ((y >=0 && y <= 19) || (y >=41 && y <= 63)) ) ||
                ( (x==53) && (y ==20 || y == 40) ) ||
                ( (x==54) && (y ==21 || y == 39) ) )
                begin
                oled_data <= 16'b11111_110000_00010; // Border Yellow
                end
        
            // Yellow Sand
            else if ( ( (x >= 0 && x<=51) && (y >=0 && y <= 63)) ||
                ( (x >= 52 && x<=53) && (y >=20 && y <= 40) ) )
                begin
                oled_data <= 16'b11110_111000_10011; // Light Yellow
                end
        
            // Light Blue Outline
            else if ( ( (x==53) && ((y >=0 && y <= 19) || (y >=41 && y <= 63)) ) ||
                      ( (x==54) && (y ==20 || y == 40) ) ||
                      ( (x >= 55 && x <= 71) && (y >=21 && y <= 39) ) )
                begin
                oled_data <= 16'b10001_100111_11101; // Light Blue Border
                end
        
            // Blue Sea
            else
                begin
                oled_data <= 16'b01001_011011_11110; // Normal Blue
                end

    //Front View Character
    if (facing_down)
        begin
        
        // Hat outline
        if ( ((y == char_y) && ((x >= char_x + 3) && (x <= char_x + 4))) ||
             ((y == char_y+1) && ((x == char_x + 2) || (x == char_x + 5))) )
            begin
                oled_data <= 16'b11000_100101_00010; // Dark Yellow
            end
            
        // Hat colour
        else if ( (y == char_y+1) && ((x >= char_x + 3) && (x <= char_x + 4)) )
            begin
                oled_data <= 16'b11111_110000_00010; // Yellow
            end
            
        // Face and Hands
        else if ( (((y >= char_y+2) && (y<= char_y+4)) && ((x >= char_x + 3) && (x <= char_x + 4))) || //Face
                  ((y == char_y+9) && ((x == char_x + 1) || (x == char_x + 6))) ) //Hands
            begin
                oled_data <= 16'b11100_101010_01111; // Beige
            end
            
        // Green shirt outline
        else if ( (y == char_y+4) && ((x == char_x + 1) || (x == char_x + 2) || (x == char_x + 5)) ||
                  (y == char_y+5) && ((x == char_x) || (x == char_x + 6)) ||
                  ((y >= char_y+6) && (y <= char_y+8) ) && ((x == char_x) || (x == char_x + 2) || (x == char_x + 5)) )
            begin
                oled_data <= 16'b00010_010100_00100; // Dark Green
            end
            
        // Green shirt colour
        else if ( ((y >= char_y+5) && (y <= char_y+8)) && ((x >= char_x + 1) && (x <= char_x + 6)) )
            begin
                oled_data <= 16'b00100_101100_01001; // Green Shirt
            end
            
        //Blue pants outline
        else if ( ((x == char_x+1) && ((y >= char_y + 10) && (y <= char_y + 13))) ||
                  ((x == char_x+5) && ((y >= char_y + 9) && (y <= char_y + 13))) )
            begin
                oled_data <= 16'b00100_001010_00101; // Dark Blue
            end
            
        // Blue pants colour
        else if ( (((x == char_x+2) || (x == char_x+4)) && ((y >= char_y + 9) && (y <= char_y + 13))) ||
                  ((x == char_x+3) && (y == char_y + 9)) )
            begin
                oled_data <= 16'b00110_001101_10011; // Blue Pants
            end
            
        // Shoes
        else if ( (y == char_y+14) && (((x >= char_x + 0) && (x <= char_x + 2)) || ((x >= char_x + 4) && (x <= char_x + 6))) )
            begin
                oled_data <= 16'b01111_010000_00101; // Brown shoes
            end
        end
            
    
    //Back View Character
    if (facing_up)
        begin
        
        // Hat outline
        if ( ((y == char_y) && ((x >= char_x + 2) && (x <= char_x + 3))) ||
             ((y == char_y+1) && ((x == char_x + 1) || (x == char_x + 4))) )
            begin
                oled_data <= 16'b11000_100101_00010; // Dark Yellow
            end
            
        // Hat colour
        else if ( (y == char_y+1) && ((x >= char_x + 2) && (x <= char_x + 3)) )
            begin
                oled_data <= 16'b11111_110000_00010; // Yellow
            end
            
        // Hair
        else if ( ((y >= char_y+2) && (y<= char_y+3)) && ((x >= char_x + 2) && (x <= char_x + 3)) )
            begin
                oled_data <= 16'b00111_000000_00010; // Hair
            end
            
        // Face and Hands
        else if ( ((y == char_y+4) && ((x >= char_x + 2) && (x <= char_x + 3))) || //Face
                  ((y == char_y+9) && (x == char_x)) ) //Hands
            begin
                oled_data <= 16'b11100_101010_01111; // Beige
            end
            
        // Green shirt outline
        else if ( (y == char_y+4) && ((x == char_x + 1) || (x == char_x + 4) || (x == char_x + 5)) ||
                  (y == char_y+5) && ((x == char_x) || (x == char_x + 6)) ||
                  ((y >= char_y+6) && (y <= char_y+7) ) && ((x == char_x + 1) || (x == char_x + 4) || (x == char_x + 6)) ||
                  (y == char_y+8) && ((x == char_x+1) || (x == char_x + 5)) )
            begin
                oled_data <= 16'b00010_010100_00100; // Dark Green
            end
            
        // Green shirt colour
        else if ( ((y >= char_y+5) && (y<= char_y+8)) && ((x >= char_x) && (x <= char_x + 5)) )
            begin
                oled_data <= 16'b00100_101100_01001; // Green Shirt
            end
            
        //Blue pants outline
        else if ( ((x == char_x+1) && ((y >= char_y + 9) && (y <= char_y + 13))) ||
                  ((x == char_x+5) && ((y >= char_y + 9) && (y <= char_y + 13))) )
            begin
                oled_data <= 16'b00100_001010_00101; // Dark Blue
            end
            
        // Blue pants colour
        else if ( (((x == char_x+2) || (x == char_x+4)) && ((y >= char_y + 9) && (y <= char_y + 13))) ||
                  ((x == char_x+3) && (y == char_y + 9)) )
            begin
                oled_data <= 16'b00110_001101_10011; // Blue Pants
            end
            
        // Shoes
        else if ( (y == char_y+14) && (((x >= char_x + 0) && (x <= char_x + 2)) || ((x >= char_x + 4) && (x <= char_x + 6))) )
            begin
                oled_data <= 16'b01111_010000_00101; // Brown shoes
            end
        end
    
    //Left View Character
    if (facing_left)
        begin
        
        // Hat outline
        if ( ((y == char_y) && ((x >= char_x + 2) && (x <= char_x + 4))) ||
             ((y == char_y+1) && ((x == char_x + 1) || (x == char_x + 5))) )
            begin
                oled_data <= 16'b11000_100101_00010; // Dark Yellow
            end
            
        // Hat colour
        else if ( (y == char_y+1) && ((x >= char_x + 2) && (x <= char_x + 4)) )
            begin
                oled_data <= 16'b11111_110000_00010; // Yellow
            end
            
        // Hair
        else if ( ((y >= char_y+2) && (y<= char_y+3)) && (x == char_x + 4) )
            begin
                oled_data <= 16'b00111_000000_00010; // Hair
            end
            
        // Face and Hands
        else if ( (((y >= char_y+2) && (y<= char_y+4)) && ((x >= char_x + 2) && (x <= char_x + 3))) ||
                  ((y == char_y+7) && (x == char_x+1)) ) //Hands
            begin
                oled_data <= 16'b11100_101010_01111; // Beige
            end
            
        // Green shirt outline
        else if ( ((y == char_y+5) && ((x == char_x + 2) || (x == char_x + 4)))  ||
                  ((y == char_y+6) && ((x == char_x + 2) || (x == char_x + 4)))  ||
                  ((y == char_y+7) && (x == char_x + 4)) ||
                  ((y == char_y+8) && ((x >= char_x + 2) && (x <= char_x + 4)) ) )
            begin
                oled_data <= 16'b00010_010100_00100; // Dark Green
            end
            
        // Green shirt colour
        else if ( (x == char_x+3) && ((y>= char_y+5) && (y<= char_y+7)) ||
                  ((x == char_x+2) && (y== char_y+7)) )
            begin
                oled_data <= 16'b00100_101100_01001; // Green Shirt
            end
            
        //Blue pants outline
        else if ( ((x == char_x+2) && ((y >= char_y + 9) && (y <= char_y + 13))) ||
                  ((x == char_x+4) && ((y >= char_y + 9) && (y <= char_y + 13))) )
            begin
                oled_data <= 16'b00100_001010_00101; // Dark Blue
            end
            
        // Blue pants colour
        else if ( (x == char_x+3) && ((y >= char_y + 9) && (y <= char_y + 13)) )
            begin
                oled_data <= 16'b00110_001101_10011; // Blue Pants
            end
            
        // Shoes
        else if ( (y == char_y+14) && ((x >= char_x + 1) && (x <= char_x + 4)) )
            begin
                oled_data <= 16'b01111_010000_00101; // Brown shoes
            end
        end

    //Right View Character
    if (facing_right)
        begin
        // Hat outline
        if ( ((y == char_y) && ((x >= char_x + 2) && (x <= char_x + 4))) ||
             ((y == char_y+1) && ((x == char_x + 1) || (x == char_x + 5))) )
            begin
                oled_data <= 16'b11000_100101_00010; // Dark Yellow
            end
            
        // Hat colour
        else if ( (y == char_y+1) && ((x >= char_x + 2) && (x <= char_x + 4)) )
            begin
                oled_data <= 16'b11111_110000_00010; // Yellow
            end
            
        // Hair
        else if ( ((y >= char_y+2) && (y<= char_y+3)) && (x == char_x + 2) )
            begin
                oled_data <= 16'b00111_000000_00010; // Hair
            end
            
        // Face and Hands
        else if ( (((y >= char_y+2) && (y<= char_y+4)) && ((x >= char_x + 3) && (x <= char_x + 4))) ||
                  ((y == char_y+7) && (x == char_x+5)) ) //Hands
            begin
                oled_data <= 16'b11100_101010_01111; // Beige
            end
            
        // Green shirt outline
        else if ( ((y == char_y+5) && ((x == char_x + 2) || (x == char_x + 4)))  ||
                  ((y == char_y+6) && ((x == char_x + 2) || (x == char_x + 4)))  ||
                  ((y == char_y+7) && (x == char_x + 2))  ||
                  ((y == char_y+8) && ((x >= char_x + 2) && (x <= char_x + 4))) )
            begin
                oled_data <= 16'b00010_010100_00100; // Dark Green
            end
            
        // Green shirt colour
        else if ( ((x == char_x+3) && ((y>= char_y+5) && (y<= char_y+7))) ||
                  ((x == char_x+4) && (y== char_y+7)) )
            begin
                oled_data <= 16'b00100_101100_01001; // Green Shirt
            end
            
        //Blue pants outline
        else if ( ((x == char_x+2) && ((y >= char_y + 9) && (y <= char_y + 13))) ||
                  ((x == char_x+4) && ((y >= char_y + 9) && (y <= char_y + 13))) )
            begin
                oled_data <= 16'b00100_001010_00101; // Dark Blue
            end
            
        // Blue pants colour
        else if ( (x == char_x+3) && ((y >= char_y + 9) && (y <= char_y + 13)) )
            begin
                oled_data <= 16'b00110_001101_10011; // Blue Pants
            end
            
        // Shoes
        else if ( (y == char_y+14) && ((x >= char_x + 1) && (x <= char_x + 4)) )
            begin
                oled_data <= 16'b01111_010000_00101; // Brown shoes
            end
        end
    
    end
            
endmodule
