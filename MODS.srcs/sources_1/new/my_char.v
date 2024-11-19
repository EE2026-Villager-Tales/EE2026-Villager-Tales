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


module my_char(
    input basys_clk,
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
    oled_data <= 0;        

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

