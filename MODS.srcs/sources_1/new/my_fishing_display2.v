`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2024 15:04:14
// Design Name: 
// Module Name: my_fishing_display2
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


module my_fishing_display2(
    input basys_clk,
    input [15:0] sw,
    input [6:0] x,
    input [5:0] y,
    input [1:0] fish_num,
    input [1:0] rod_num,
    
    input [1:0] man_frame,
    input [3:0] rod_frame,
    input bait_frame,
    input fish_frame,
    input submerged,
    
    input [6:0] x_zichar,
    input [5:0] y_zichar,
    input [6:0] x_bait,
    input [6:0] y_bait,
    input [6:0] x_fish,
    input [5:0] y_fish,
    
    input bait_ripple,
    input [1:0]rod_ripple,
    
    output reg [15:0] oled_data = 0
    );
    
    wire clk_25MHz;
    flexible_clock fc_25MHz (.basys_clock(basys_clk),.count(2),.SLOW_CLOCK(clk_25MHz));
    
    
    always @ (posedge clk_25MHz)
        begin
        
            // Background
            // Brown Bridge Outline
            if ( ( ((y == 16) || (y == 47)) && ( x >= 19 && x <= 55) ) ||
               ( ((x == 19) || (x == 23) || (x == 27) || (x == 34) || (x == 37) || (x == 44) || (x == 47) || (x == 55) ) && ( y >= 16 && y <= 47) ) ||
               ( ((x >= 35 && x <= 36) || (x >= 45 && x <=46)) && (y == 18 || y ==45) ) )
                begin
                oled_data <= 16'b00111_001001_00011; // Border brown
                end
            // Brown Bridge first staircase
                else if ( (x >= 20 && x <= 22) && (y >= 17 && y <= 46) )
                begin
                oled_data <= 16'b01101_001111_00101; // 1st dark brown
                end
            // Brown Bridge second staircase
                else if ( (x >= 24 && x <= 26) && (y >= 17 && y <= 46) )
                begin
                oled_data <= 16'b01110_010001_00110; // 2nd dark brown
                end
            // Brown Bridge platform
                else if ( ((x >= 28 && x <= 33) || (x >= 38 && x <= 43) || (x >= 48 && x <= 54)) && (y >= 17 && y <= 46) ||
                ( ((x >= 35 && x <= 36) || (x >= 45 && x <=46)) && (y == 17 || y ==46) ) )
                begin
                oled_data <= 16'b10001_010100_00111; // 3rd dark brown
                end
            // Yellow Sand Outline
            else if ( ((x==18) && (y >=16 && y <= 47)) ||
                ( ((y == (65 - x)) || (y == (66 - x))) && (x>=2 && x<=18) ) ||
                ( ((y == (x - 2)) || (y == (x - 3))) && (x>=2 && x<=18) ) )
                begin
                oled_data <= 16'b11111_110000_00010; // Border Yellow
                end
            // Yellow Sand
            else if ( ( (x >= 0 && x<=2) && (y >=0 && y <= 63) ) ||
                ( (x >= 2 && x<=18) && (y >=17 && y <= 46) ) ||
                ( (y <= (65 - x)) && (x>=2 && x<=18) && (y>=47 && y<=63) )||
                ( (y >= (x - 2)) && (x>=2 && x<=18) && (y>=0 && y<=16) ) )
                begin
                oled_data <= 16'b11110_111000_10011; // Light Yellow
                end
            // Light Blue Outline
            else if ( (((y >= (67 - x)) && (y <= (70 - x))) && (x>=4 && x<=23) ) ||
                ( ((y <= (x - 4)) && (y >= (x - 7))) && (x>=4 && x<=23) ) ||
                ( (x >= 19 && x <= 56) && ((y==15) || (y==48)) ) ||
                ( (x == 56) && (y>=15 && y<=48) ) )
                begin
                oled_data <= 16'b10001_100111_11101; // Light Blue Border
                end
            // Blue Sea
            else
                begin
                oled_data <= 16'b01001_011011_11110; // Normal Blue
                end
            
            
            //Front View Character
            if(man_frame == 1)
                begin
                // Black outline
                    if ( ((y == y_zichar) && ((x >= x_zichar+6) && (x <= x_zichar+14))) || // Face
                         ((y == y_zichar+1) && (((x >= x_zichar+5) && (x <= x_zichar+6)) || ((x >= x_zichar+14) && (x <= x_zichar+15)))) || // Face
                         ((y == y_zichar+2) && ((x == x_zichar+4) || (x == x_zichar+16))) || // Face
                         ((y == y_zichar+3) && (((x >= x_zichar+5) && (x <= x_zichar+6)) || ((x >= x_zichar+14) && (x <= x_zichar+15)))) || // Face
                         ((y == y_zichar+4) && ((x == x_zichar+5) || (x == x_zichar+15))) || // Face
                         ((y == y_zichar+5) && ((x == x_zichar+5) || (x == x_zichar+8) || (x == x_zichar+12) || (x == x_zichar+15))) || // Face
                         ((y == y_zichar+6) && ((x == x_zichar+5) || (x == x_zichar+8) || (x == x_zichar+12) || (x == x_zichar+15))) || // Face
                         ((y == y_zichar+7) && ((x == x_zichar+5) || (x == x_zichar+15))) || // Face
                         ((y == y_zichar+8) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Face
                         ((y == y_zichar+9) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Shirt
                         ((y == y_zichar+10) && ((x == x_zichar+5) || (x == x_zichar+15))) || // Shirt
                         ((y == y_zichar+11) && ((x == x_zichar+2) ||(x == x_zichar+4) || (x == x_zichar+16) || (x == x_zichar+18))) || // Shirt
                         ((y == y_zichar+12) && ((x == x_zichar+1) ||(x == x_zichar+3) || (x == x_zichar+17) || (x == x_zichar+19))) || // Shirt
                         ((y == y_zichar+13) && ((x == x_zichar) || (x == x_zichar+6) || (x == x_zichar+14) || (x == x_zichar+20))) || // Shirt
                         ((y == y_zichar+14) && ((x == x_zichar) || (x == x_zichar+5) || (x == x_zichar+6) || (x == x_zichar+14) || (x == x_zichar+15) || (x == x_zichar+20))) || // Shirt
                         ((y == y_zichar+15) && (((x >= x_zichar+1) && (x <= x_zichar+6)) || ((x >= x_zichar+14) && (x <= x_zichar+19)))) || // Pants
                         ((y == y_zichar+16) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Pants
                         ((y == y_zichar+17) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Pants
                         ((y == y_zichar+18) && ((x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+14))) || // Pants
                         ((y == y_zichar+19) && ((x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+14))) || // Pants
                         ((y == y_zichar+20) && ((x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+14))) || // Pants
                         ((y == y_zichar+21) && ((x == x_zichar+5) || (x == x_zichar+9) || (x == x_zichar+11) || (x == x_zichar+15))) || // Shoes
                         ((y == y_zichar+22) && ((x == x_zichar+4) || (x == x_zichar+9) || (x == x_zichar+11) || (x == x_zichar+16))) || // Shoes
                         ((y == y_zichar+23) && ((x >= x_zichar+5) && (x <= x_zichar+15))) ) // Shoes
                        begin
                            oled_data <= 16'b00000_000000_00000; // Black
                        end
                    // Mouth
                    else if ((y == y_zichar+7) && (x == x_zichar+10))
                        begin
                            oled_data <= 16'b11111_000000_00000; // Red
                        end
                    // Hat
                    else if ( ((y == y_zichar+1) && ((x >= x_zichar+7) && (x <= x_zichar+13))) ||
                        ((y == y_zichar+2) && ((x >= x_zichar+5) && (x <= x_zichar+15))) )
                        begin
                        oled_data <= 16'b11111_110000_00010; // Dark yellow
                        end
                    // Hair and Shoes
                    else if ( ((y == y_zichar+3) && ((x >= x_zichar+7) && (x <= x_zichar+13))) || // Hair
                              ((y == y_zichar+4) && (((x >= x_zichar+6) && (x <= x_zichar+7)) || ((x >= x_zichar+13) && (x <= x_zichar+14)))) || // Hair
                              ((y == y_zichar+5) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Hair
                              ((y == y_zichar+6) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Hair
                              ((y == y_zichar+21) && (((x >= x_zichar+6) && (x <= x_zichar+8)) || ((x >= x_zichar+12) && (x <= x_zichar+14)))) || // Shoes
                              ((y == y_zichar+22) && (((x >= x_zichar+5) && (x <= x_zichar+8)) || ((x >= x_zichar+12) && (x <= x_zichar+15)))) ) // Shoes
                        begin
                        oled_data <= 16'b10001_010100_00111; // Brown
                        end
                    // Face and Hands
                    else if ( (((y >= y_zichar+4) && (y <= y_zichar+8)) && ((x >= x_zichar+6) && (x <= x_zichar+14))) || //Face
                          (((y >= y_zichar+12) && (y <= y_zichar+14)) && ((x >= x_zichar+1) && (x <= x_zichar+2))) || //Left hand
                          (((y >= y_zichar+12) && (y <= y_zichar+14)) && ((x >= x_zichar+18) && (x <= x_zichar+19))) ) //Left hand
                        begin
                        oled_data <= 16'b11110_111000_10011; // Light Yellow 2
                        end
                    // Shirt
                    else if ( (((y >= y_zichar+10) && (y <= y_zichar+13)) && ((x >= x_zichar+5) && (x <= x_zichar+6))) || //Left Arm 1
                              (((y >= y_zichar+12) && (y <= y_zichar+14)) && ((x >= x_zichar+3) && (x <= x_zichar+4))) || //Left Arm 2
                              (((y >= y_zichar+9) && (y <= y_zichar+14)) && ((x >= x_zichar+7) && (x <= x_zichar+13))) || //Main
                              (((y >= y_zichar+10) && (y <= y_zichar+13)) && ((x >= x_zichar+14) && (x <= x_zichar+15))) || //Right Arm 1
                              (((y >= y_zichar+12) && (y <= y_zichar+14)) && ((x >= x_zichar+16) && (x <= x_zichar+17))) ) //Right Arm 2
                        begin
                        oled_data <= 16'b00100_101100_01001; // Green
                        end
                    // Dark Blue Pants
                    else if ( (((y >= y_zichar+15) && (y <= y_zichar+20)) && ((x >= x_zichar+7) && (x <= x_zichar+13))))
                        begin
                        oled_data <= 16'b00110_001101_10011; // Dark Blue
                        end
                end
            
            // Side View Character
            if(man_frame == 2)
                begin
                // Black outline and Eyes
                if ( ((y == y_zichar) && ((x >= x_zichar+6) && (x <= x_zichar+14))) || // Face
                     ((y == y_zichar+1) && (((x >= x_zichar+5) && (x <= x_zichar+6)) || ((x >= x_zichar+14) && (x <= x_zichar+15)))) || // Face
                     ((y == y_zichar+2) && ((x == x_zichar+4) || (x == x_zichar+16))) || // Face
                     ((y == y_zichar+3) && ((x == x_zichar+5) || ((x >= x_zichar+14) && (x <= x_zichar+15)))) || // Face
                     ((y == y_zichar+4) && ((x == x_zichar+5) || (x == x_zichar+14))) || // Face
                     ((y == y_zichar+5) && ((x == x_zichar+5) || (x == x_zichar+12) || (x == x_zichar+14))) || // Face
                     ((y == y_zichar+6) && ((x == x_zichar+5) || (x == x_zichar+12) || (x == x_zichar+15))) || // Face
                     ((y == y_zichar+7) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Face
                     ((y == y_zichar+8) && ((x == x_zichar+7) || (x == x_zichar+14))) || // Face
                     ((y == y_zichar+9) && ((x == x_zichar+6) || (x == x_zichar+14))) || // Shirt
                     ((y == y_zichar+10) && ((x == x_zichar+5) || (x == x_zichar+15))) || // Shirt
                     ((y == y_zichar+11) && ((x == x_zichar+4) || (x == x_zichar+16) || (x == x_zichar+18))) || // Shirt
                     ((y == y_zichar+12) && ((x == x_zichar+4) || (x == x_zichar+17) || (x == x_zichar+19))) || // Shirt
                     ((y == y_zichar+13) && ((x == x_zichar+4) || (x == x_zichar+14) || (x == x_zichar+20))) || // Shirt
                     ((y == y_zichar+14) && ((x == x_zichar+4) || (x == x_zichar+14) || (x == x_zichar+15) || (x == x_zichar+20))) || // Shirt
                     ((y == y_zichar+15) && ((x == x_zichar+4) || ((x >= x_zichar+14) && (x <= x_zichar+19)))) || // Pants
                     ((y == y_zichar+16) && ((x == x_zichar+3) || (x == x_zichar+14))) || // Pants
                     ((y == y_zichar+17) && ((x == x_zichar+4) || (x == x_zichar+14))) || // Pants
                     ((y == y_zichar+18) && ((x == x_zichar+5) || (x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+14))) || // Pants
                     ((y == y_zichar+19) && ((x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+14))) || // Pants
                     ((y == y_zichar+20) && ((x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+14))) || // Pants
                     ((y == y_zichar+21) && ((x == x_zichar+6) || (x == x_zichar+10) || (x == x_zichar+11) || (x == x_zichar+15))) || // Shoes
                     ((y == y_zichar+22) && ((x == x_zichar+6) || (x == x_zichar+11) || (x == x_zichar+16))) || // Shoes
                     ((y == y_zichar+23) && ((x >= x_zichar+7) && (x <= x_zichar+15))) ) // Shoes
                    begin
                    oled_data <= 16'b00000_000000_00000; // Black
                    end
                // Mouth
                else if ((y == y_zichar+8) && (x == x_zichar+13))
                    begin
                    oled_data <= 16'b11111_000000_00000; // Red
                    end
                // Hat
                else if ( ((y == y_zichar+1) && ((x >= x_zichar+7) && (x <= x_zichar+13))) ||
                    ((y == y_zichar+2) && ((x >= x_zichar+5) && (x <= x_zichar+15))) )
                    begin
                    oled_data <= 16'b11111_110000_00010; // Dark yellow
                    end
                // Hair and Shoes
                else if ( ((y == y_zichar+3) && ((x >= x_zichar+6) && (x <= x_zichar+13))) || // Hair
                          ((y == y_zichar+4) && ((x >= x_zichar+6) && (x <= x_zichar+8))) || // Hair
                          ((y == y_zichar+5) && ((x == x_zichar+6) || (x == x_zichar+8))) || // Hair
                          ((y == y_zichar+6) && ((x == x_zichar+6) || (x == x_zichar+8) || (x == x_zichar+9))) || // Hair
                          ((y == y_zichar+7) && (x == x_zichar+7)) || // Hair
                          ((y == y_zichar+21) && (((x >= x_zichar+7) && (x <= x_zichar+9)) || ((x >= x_zichar+12) && (x <= x_zichar+14)))) || // Shoes
                          ((y == y_zichar+22) && (((x >= x_zichar+7) && (x <= x_zichar+10)) || ((x >= x_zichar+12) && (x <= x_zichar+15)))) ) // Shoes
                    begin
                    oled_data <= 16'b10001_010100_00111; // Brown
                    end
                // Face and Hands
                else if ( (((y >= y_zichar+4) && (y <= y_zichar+8)) && ((x >= x_zichar+7) && (x <= x_zichar+14))) || //Face
                      (((y >= y_zichar+16) && (y <= y_zichar+17)) && ((x >= x_zichar+4) && (x <= x_zichar+6))) || //Left hand
                      (((y >= y_zichar+12) && (y <= y_zichar+14)) && ((x >= x_zichar+18) && (x <= x_zichar+19))) ) //Left hand
                    begin
                    oled_data <= 16'b11110_111000_10011; // Light Yellow 2
                    end
                // Shirt
                else if ( (((y >= y_zichar+10) && (y <= y_zichar+15)) && ((x >= x_zichar+5) && (x <= x_zichar+6))) || //Left Arm
                      (((y >= y_zichar+9) && (y <= y_zichar+14)) && ((x >= x_zichar+7) && (x <= x_zichar+13))) || //Main
                      (((y >= y_zichar+10) && (y <= y_zichar+13)) && ((x >= x_zichar+14) && (x <= x_zichar+15))) || //Right Arm 1
                          (((y >= y_zichar+12) && (y <= y_zichar+14)) && ((x >= x_zichar+16) && (x <= x_zichar+17))) ) //Right Arm 2
                    begin
                    oled_data <= 16'b00100_101100_01001; // Green
                    end
                // Darker Blue Pants
                else if ( (((x == x_zichar+7) && ((y >= y_zichar+16) && (y <= y_zichar+20)))) ||
                      (((x == x_zichar+8) && ((y >= y_zichar+17) && (y <= y_zichar+20)))) ||
                      (((x == x_zichar+9) && ((y >= y_zichar+18) && (y <= y_zichar+20)))))  
                    begin
                    oled_data <= 16'b00010_000101_01001; // Darker Blue
                    end
                // Dark Blue Pants
                else if ( (((y >= y_zichar+15) && (y <= y_zichar+20)) && ((x >= x_zichar+7) && (x <= x_zichar+13))))
                    begin
                    oled_data <= 16'b00110_001101_10011; // Dark Blue
                    end
            end
            
            // Bait
            if (bait_frame == 1)
                begin
                    if ( ((y >= y_bait+1) && (y <= y_bait+2)) && ((x >= x_bait+1) && (x <= x_bait+2)) )
                        begin
                            oled_data <= 16'b11111_101000_10110; // Pink
                        end
                    if ( (((y >= y_bait) && (y <= y_bait+3)) && ((x >= x_bait+1) && (x <= x_bait+2))) ||
                         (((y >= y_bait+1) && (y <= y_bait+2)) && ((x >= x_bait) && (x <= x_bait+3))) )
                        begin
                            oled_data <= 16'b10011_010100_01011; // Dark Pink
                        end
                end
            
            // Bait ripple
            if (bait_ripple ==1)
                begin
                    if ( ((y == 40) && ((x >= 68) && (x <= 73))) ||
                         ((y == 41) && ((x >= 70) && (x <= 71))) )
                        begin
                        oled_data <= 16'b10001_100111_11101;
                        end
                end
                
            
            
            // Fishing Rod Frame 1 - Original Pos
            if (rod_frame[3:0] == 1) 
                begin
                    if ( (x >=54 && x<=55) && ((y >= 32 && y <= 34) || (y >= 13 && y <= 14)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ((x >=54 && x<=55) && (y == 23))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ((x >=54 && x<=55) && (y >= 12 && y <= 31))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x >= 56 && x <= 59) && (y == 13)) || ((y >= 13 && y <= 16) && (x == 59)) || ((x >= 58 && x <= 60) && (y == 16)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 58 && x <= 60) && (y == 17))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((x >= 58 && x <= 60) && (y == 18)) || (x == 59 && y == 19) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
                
            // Fishing Rod Frame 2 - Casting 1
            if (rod_frame[3:0] == 2)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=45 && x<=46) && (y >= 14 && y <= 15)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if (((x >=49 && x<=50) && (y == 23)) || (x==50 && y==22))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=53 && x<=54) && (y >= 30 && y <= 31)) || ((x >=52 && x<=53) && (y >= 28 && y <= 29)) ||
                              ((x >=51 && x<=52) && (y >= 26 && y <= 27)) || ((x >=50 && x<=51) && (y >= 24 && y <= 25)) ||
                              (x ==49 && y == 22) || ((x >=48 && x<=47) && (y >= 20 && y <= 21)) ||
                              ((x >=47 && x<=48) && (y >= 18 && y <= 19)) || ((x >=46 && x<=47) && (y >= 16 && y <= 17)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x >= 34 && x <= 44) && (y == 14)) || ((y >= 13 && y <= 15) && (x == 34)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((y >= 13 && y <= 15) && (x == 33))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((y >= 13 && y <= 15) && (x == 32)) || (x == 31 && y == 14) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
                
            // Fishing Rod Frame 3 - Casting 2
            if (rod_frame[3:0] == 3)
                begin
                    if ( (x >=54 && x<=55) && ((y >= 32 && y <= 34) || (y >= 14 && y <= 15)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ((x >=54 && x<=55) && (y == 23))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ((x >=54 && x<=55) && (y >= 16 && y <= 31))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x >= 56 && x <= 65) && (y == 14)) || ((y >= 13 && y <= 15) && (x == 65)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((y >= 13 && y <= 15) && (x == 66))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((y >= 13 && y <= 15) && (x == 67)) || (x == 68 && y == 14) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
                
            // Fishing Rod Frame 4 - Casting 3
            if (rod_frame[3:0] == 4)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=60 && x<=61) && (y >= 14 && y <= 15)) )
                        begin
                        if (rod_num == 2'b01)
                            oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                        else if (rod_num == 2'b10)
                            oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                        else if (rod_num == 2'b11)
                            oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ((x >=57 && x<=58) && (y == 23))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=55 && x<=56) && (y >= 29 && y <= 31)) || ((x >=56 && x<=57) && (y >= 26 && y <= 28)) ||
                              ((x >=57 && x<=58) && (y >= 23 && y <= 25)) || ((x >=58 && x<=59) && (y >= 20 && y <= 22)) ||
                              ((x >=59 && x<=60) && (y >= 17 && y <= 18)) || ((x >=60 && x<=61) && (y == 16)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( (((y == x-48 ) && (x>=62 && x<=72)) || ((y == x-49 ) && (x>=63 && x<=72))) || ((x >= 71 && x <= 73) && (y == 25)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 71 && x <= 73) && (y == 26))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((x >= 71 && x <= 73) && (y == 27)) || (x == 72 && y == 28) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
                
            // Fishing Rod Frame 5 - Waiting for fish
            if (rod_frame[3:0] == 5)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=67 && x<= 68) && (y >= 15 && y <= 16)) || (x == 66 && y == 15) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ( ((x >=61 && x<=62) && (y == 23)) || (x == 62 && y == 24) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=56 && x<=57) && (y >= 31 && y <= 32)) || ((x >=57 && x<=58) && (y >= 29 && y <= 30)) ||
                              ((x >=58 && x<=60) && (y >= 27 && y <= 28)) || ((x >=60 && x<=61) && (y >= 25 && y <= 26)) ||
                              (x ==61 && y==24) || ((x >=62 && x<=64) && (y >= 21 && y <= 22)) || 
                              ((x >=64 && x<=65) && (y >= 19 && y <= 20)) || ((x >=65 && x<=66) && (y >= 17 && y <= 18)) || (x ==66 && y==16) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x == 68) && (y >= 17 && y <= 33)) || ((x >= 67 && x <= 69) && (y == 33)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 67 && x <= 69) && (y == 34))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if (x == 68 && y == 35)
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end        
    
            // Fishing Rod Frame 6 // Ripple 1
            if (rod_frame[3:0] == 6)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=67 && x<= 68) && (y >= 15 && y <= 16)) || (x == 66 && y == 15) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ( ((x >=61 && x<=62) && (y == 23)) || (x == 62 && y == 24) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=56 && x<=57) && (y >= 31 && y <= 32)) || ((x >=57 && x<=58) && (y >= 29 && y <= 30)) ||
                              ((x >=58 && x<=60) && (y >= 27 && y <= 28)) || ((x >=60 && x<=61) && (y >= 25 && y <= 26)) ||
                              (x ==61 && y==24) || ((x >=62 && x<=64) && (y >= 21 && y <= 22)) || 
                              ((x >=64 && x<=65) && (y >= 19 && y <= 20)) || ((x >=65 && x<=66) && (y >= 17 && y <= 18)) || (x ==66 && y==16) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x == 68) && (y >= 17 && y <= 34)) || ((x >= 67 && x <= 69) && (y == 34)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 67 && x <= 69) && (y == 35))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                end
    
            // Fishing Rod Frame 7 // Reeling 1
            if (rod_frame[3:0] == 7)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=67 && x<= 68) && (y >= 15 && y <= 16)) || (x == 66 && y == 15) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ( ((x >=61 && x<=62) && (y == 23)) || (x == 62 && y == 24) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=56 && x<=57) && (y >= 31 && y <= 32)) || ((x >=57 && x<=58) && (y >= 29 && y <= 30)) ||
                              ((x >=58 && x<=60) && (y >= 27 && y <= 28)) || ((x >=60 && x<=61) && (y >= 25 && y <= 26)) ||
                              (x ==61 && y==24) || ((x >=62 && x<=64) && (y >= 21 && y <= 22)) || 
                              ((x >=64 && x<=65) && (y >= 19 && y <= 20)) || ((x >=65 && x<=66) && (y >= 17 && y <= 18)) || (x ==66 && y==16) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x == 68) && (y >= 17 && y <= 28)) || ((x >= 67 && x <= 69) && (y == 28)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 67 && x <= 69) && (y == 29))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((x >= 67 && x <= 69) && (y == 30)) || (x == 68 && y == 31))
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
    
            // Fishing Rod Frame 8 // Reeling 2
            if (rod_frame[3:0] == 8)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=67 && x<= 68) && (y >= 15 && y <= 16)) || (x == 66 && y == 15) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ( ((x >=61 && x<=62) && (y == 23)) || (x == 62 && y == 24) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=56 && x<=57) && (y >= 31 && y <= 32)) || ((x >=57 && x<=58) && (y >= 29 && y <= 30)) ||
                              ((x >=58 && x<=60) && (y >= 27 && y <= 28)) || ((x >=60 && x<=61) && (y >= 25 && y <= 26)) ||
                              (x ==61 && y==24) || ((x >=62 && x<=64) && (y >= 21 && y <= 22)) || 
                              ((x >=64 && x<=65) && (y >= 19 && y <= 20)) || ((x >=65 && x<=66) && (y >= 17 && y <= 18)) || (x ==66 && y==16) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x == 68) && (y >= 17 && y <= 22)) || ((x >= 67 && x <= 69) && (y == 22)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 67 && x <= 69) && (y == 23))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((x >= 67 && x <= 69) && (y == 24)) || (x == 68 && y == 25) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
            
            // Fishing Rod Frame 9 // Reeling 3
            if (rod_frame[3:0] == 9)
                begin
                    if ( ((x >=54 && x<=55) && (y >= 32 && y <= 34)) || ((x >=60 && x<=61) && (y >= 14 && y <= 15)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ((x >=57 && x<=58) && (y == 23))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ( ((x >=55 && x<=56) && (y >= 29 && y <= 31)) || ((x >=56 && x<=57) && (y >= 26 && y <= 28)) ||
                              ((x >=57 && x<=58) && (y >= 23 && y <= 25)) || ((x >=58 && x<=59) && (y >= 20 && y <= 22)) ||
                              ((x >=59 && x<=60) && (y >= 17 && y <= 18)) || ((x >=60 && x<=61) && (y == 16)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((y == 14) && (x>=62 && x<=63)) || ((y >= 14 && y <= 19) && (x == 63)) || ((x >= 62 && x <= 64) && (y == 19)))
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 62 && x <= 64) && (y == 20))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((x >= 62 && x <= 64) && (y == 21)) || (x == 63 && y == 22) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
    
            // Fishing Rod Frame 10 // Reeling 4
            if (rod_frame[3:0] == 10)
                begin
                    if ( (x >=54 && x<=55) && ((y >= 32 && y <= 34) || (y >= 13 && y <= 14)) )
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b10011_110110_11100; //Fishing rod 1 light blue
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
                        end
                    else if ((x >=54 && x<=55) && (y == 23))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_111111_11111; //Fishing rod 1 white
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 2 orange
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10011_000000_00110; //Fishing rod 3 dark red
                        end
                    else if ((x >=54 && x<=55) && (y >= 15 && y <= 31))
                        begin
                            if (rod_num == 2'b01)
                                oled_data <= 16'b11111_011111_00000; //Fishing rod 1 orange
                            else if (rod_num == 2'b10)
                                oled_data <= 16'b11111_111100_00000; //Fishing rod 2 yellow
                            else if (rod_num == 2'b11)
                                oled_data <= 16'b10110_101100_10110; //Fishing rod 3 grey
                        end
                    else if ( ((x >= 56 && x <= 59) && (y == 13)) || ((y >= 13 && y <= 16) && (x == 59)) || ((x >= 58 && x <= 60) && (y == 16)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Fishing line dark red
                        end
                    else if ((x >= 58 && x <= 60) && (y == 17))
                        begin
                            oled_data <= 16'b11111_111111_11111; //Fishing line white
                        end
                    else if ( ((x >= 58 && x <= 60) && (y == 18)) || (x == 59 && y == 19) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Fishing line dark blue
                        end
                end
                
            // rod ripple small
            if (rod_ripple == 1)
                begin
                    if ( ((y == 36) && ((x == 66) || (x == 70))) ||
                         ((y == 37) && ((x >= 67) && (x <= 69))) )
                        begin
                        oled_data <= 16'b10001_100111_11101;
                        end
                end
                
            // rod ripple medium
            if (rod_ripple == 2)
                begin
                    if ( ((y == 36) && ((x == 64) || (x == 72))) ||
                         ((y == 37) && ((x == 63) || (x == 71))) ||
                         ((y == 38) && ((x >= 66) && (x <= 70))) )
                        begin
                        oled_data <= 16'b10001_100111_11101;
                        end
                end
                
            // rod ripple large
            if (rod_ripple == 3)
                begin
                    if ( ((y == 36) && ((x == 62) || (x == 74))) ||
                         ((y == 37) && ((x == 63) || (x == 73))) ||
                         ((y == 38) && ((x == 64) || (x == 72))) ||
                         ((y == 39) && ((x >= 65) && (x <= 71))) )
                        begin
                        oled_data <= 16'b10001_100111_11101;
                        end
                end
            
            
            // Full Carp
            if ((fish_frame == 1) && (fish_num == 1))
                begin
                    // Black outline
                    if ( ((y == y_fish) && ((x >= x_fish+3) && (x <= x_fish+7))) ||
                         ((y == y_fish+1) && ((x == x_fish+3) || (x == x_fish+7))) ||
                         (((x == x_fish+2) || (x == x_fish+8)) && ((y >= y_fish+1) && (y <= y_fish+3))) ||
                         (((x == x_fish+1) || (x == x_fish+9)) && ((y >= y_fish+3) && (y <= y_fish+4))) ||
                         (((x == x_fish) || (x == x_fish+10)) && ((y >= y_fish+4) && (y <= y_fish+6))) ||
                         (((x == x_fish+1) || (x == x_fish+9)) && ((y >= y_fish+6) && (y <= y_fish+7))) ||
                         (((x == x_fish+2) || (x == x_fish+8)) && ((y >= y_fish+7) && (y <= y_fish+8))) ||
                         ((y == y_fish+8) && ((x == x_fish+3) || (x == x_fish+7))) ||
                         ((y == y_fish+9) && (((x >= x_fish+3) && (x <= x_fish+4)) || ((x >= x_fish+6) && (x <= x_fish+7)))) ||
                         ((y == y_fish+10) && (((x >= x_fish+2) && (x <= x_fish+3)) || ((x >= x_fish+7) && (x <= x_fish+8)))) ||
                         ((y == y_fish+11) && (((x >= x_fish+1) && (x <= x_fish+2)) || ((x >= x_fish+8) && (x <= x_fish+9)))) ||
                         ((y == y_fish+12) && ((x == x_fish+1) || (x == x_fish+5) || (x == x_fish+9))) ||
                         ((y == y_fish+13) && ((x >= x_fish+1) && (x <= x_fish+9))) )
                        begin
                            oled_data <= 16'b00000_000000_00000; //Black
                        end
                    // Eyes
                    else if ((y == y_fish+2) && ((x == x_fish+4) || (x == x_fish+6)))
                        begin
                            oled_data <=16'b01001_010001_01001; //Dark grey
                        end
                    //Brown Parts
                    else if ( (((y >= y_fish+3) && (y <= y_fish+6)) && ( ((x >= x_fish+1) && (x <= x_fish+3)) || (x == x_fish+5) || ((x >= x_fish+7) && (x <= x_fish+9)))) ||
                              (((y >= y_fish+9) && (y <= y_fish+10)) && ((x >= x_fish+4) && (x <= x_fish+6))) || 
                              (((y >= y_fish+11) && (y <= y_fish+12)) && ((x >= x_fish+2) && (x <= x_fish+8))) )
                        begin
                            oled_data <= 16'b10011_010110_00111; //Brown
                        end
                    //Light Grey Parts
                    else if (((y >= y_fish+2) && (y <= y_fish+7)) && ((x >= x_fish+4) && (x <= x_fish+6)))
                        begin
                            oled_data <= 16'b10110_101100_10110; //Light grey
                        end
                    //White Parts
                    else if (((y >= y_fish+1) && (y <= y_fish+8)) && ((x >= x_fish+3) && (x <= x_fish+7)))
                        begin
                            oled_data <= 16'b11111_111111_11111; //White
                        end
                end
        
            // Blue Tang
            if ((fish_frame == 1) &&(fish_num == 2 && (rod_num == 2 || rod_num == 3)))
                begin
                    // Black outline and black fin
                    if ( ((y == y_fish) && ((x >= x_fish+3) && (x <= x_fish+7))) ||
                         ((y == y_fish+1) && ((x == x_fish+3) || (x == x_fish+7))) ||
                         (((x == x_fish+2) || (x == x_fish+8)) && ((y >= y_fish+1) && (y <= y_fish+3))) ||
                         (((x == x_fish+1) || (x == x_fish+9)) && ((y >= y_fish+3) && (y <= y_fish+4))) ||
                         (((x == x_fish) || (x == x_fish+10)) && ((y >= y_fish+4) && (y <= y_fish+6))) ||
                         (((x == x_fish+1) || (x == x_fish+9)) && ((y >= y_fish+6) && (y <= y_fish+7))) ||
                         (((x == x_fish+2) || (x == x_fish+8)) && ((y >= y_fish+7) && (y <= y_fish+8))) ||
                         ((y == y_fish+8) && ((x == x_fish+3) || (x == x_fish+7))) ||
                         ((y == y_fish+9) && (((x >= x_fish+3) && (x <= x_fish+4)) || ((x >= x_fish+6) && (x <= x_fish+7)))) ||
                         ((y == y_fish+10) && (((x >= x_fish+2) && (x <= x_fish+3)) || ((x >= x_fish+7) && (x <= x_fish+8)))) ||
                         ((y == y_fish+11) && (((x >= x_fish+1) && (x <= x_fish+2)) || ((x >= x_fish+8) && (x <= x_fish+9)))) ||
                         ((y == y_fish+12) && ((x == x_fish+1) || (x == x_fish+5) || (x == x_fish+9))) ||
                         ((y == y_fish+13) && ((x >= x_fish+1) && (x <= x_fish+9))) ||
                         ((x == x_fish+5) && ((y >= y_fish+3) && (y <= y_fish+7))) )   // Black fin
                        begin
                            oled_data <= 16'b00000_000000_00000; //Black
                        end
                    // Eyes
                    else if ((y == y_fish+2) && ((x == x_fish+4) || (x == x_fish+6)))
                        begin
                            oled_data <=16'b01001_010001_01001; //Dark grey
                        end
                    //Darker Dark Blue Parts
                    else if ( (((y >= y_fish+4) && (y <= y_fish+6)) && ((x == x_fish+4) || (x == x_fish+6))) ||
                              (( y == y_fish+9) && (x == x_fish+5)) ||
                              (( y == y_fish+10) && ((x == x_fish+4) || (x == x_fish+6))) )
                        begin
                            oled_data <= 16'b00001_000100_01100; //Darker Dark Blue 
                        end
                    //Dark Blue Parts
                    else if ( ((y >= y_fish+1) && (y <= y_fish+8)) && ((x >= x_fish+3) && (x <= x_fish+7)) ||
                              ((y == y_fish+11) && (((x >= x_fish+3) && (x <= x_fish+4)) || ((x >= x_fish+7) && (x <= x_fish+8)))) ||
                              ((y == y_fish+12) && (((x >= x_fish+2) && (x <= x_fish+3)) || ((x >= x_fish+8) && (x <= x_fish+9)))) )
                        begin
                            oled_data <= 16'b00110_001101_10011; //Dark Blue
                        end
                    //Dark Yellow Parts
                    else if ( ((y == y_fish+5) && ((x == x_fish+2) || (x == x_fish+8))) || ((y == y_fish+10) && (x == x_fish+5)) )
                        begin
                            oled_data <= 16'b11111_110000_00010; //Dark Yellow
                        end
                    //Yellow Parts
                    else if ( (((y >= y_fish+4) && (y <= y_fish+6)) && (((x >= x_fish+1) && (x <= x_fish+2)) || ((x >= x_fish+8) && (x <= x_fish+9)))) ||
                              ((y >= y_fish+11) && (y <= y_fish+12)) && ((x >= x_fish+4) && (x <= x_fish+6)) )
                        begin
                            oled_data <= 16'b11111_111100_00000; //Yellow
                        end
                end
    
            // Koi
            if ((fish_frame == 1) && (fish_num == 3 && (rod_num == 3)))
                begin
                    // Black outline
                    if ( ((y == y_fish) && ((x >= x_fish+3) && (x <= x_fish+7))) ||
                         ((y == y_fish+1) && ((x == x_fish+3) || (x == x_fish+7))) ||
                         (((x == x_fish+2) || (x == x_fish+8)) && ((y >= y_fish+1) && (y <= y_fish+3))) ||
                         (((x == x_fish+1) || (x == x_fish+9)) && ((y >= y_fish+3) && (y <= y_fish+4))) ||
                         (((x == x_fish) || (x == x_fish+10)) && ((y >= y_fish+4) && (y <= y_fish+6))) ||
                         (((x == x_fish+1) || (x == x_fish+9)) && ((y >= y_fish+6) && (y <= y_fish+7))) ||
                         (((x == x_fish+2) || (x == x_fish+8)) && ((y >= y_fish+7) && (y <= y_fish+8))) ||
                         ((y == y_fish+8) && ((x == x_fish+3) || (x == x_fish+7))) ||
                         ((y == y_fish+9) && (((x >= x_fish+3) && (x <= x_fish+4)) || ((x >= x_fish+6) && (x <= x_fish+7)))) ||
                         ((y == y_fish+10) && (((x >= x_fish+2) && (x <= x_fish+3)) || ((x >= x_fish+7) && (x <= x_fish+8)))) ||
                         ((y == y_fish+11) && (((x >= x_fish+1) && (x <= x_fish+2)) || ((x >= x_fish+8) && (x <= x_fish+9)))) ||
                         ((y == y_fish+12) && ((x == x_fish+1) || (x == x_fish+5) || (x == x_fish+9))) ||
                         ((y == y_fish+13) && ((x >= x_fish+1) && (x <= x_fish+9))) )
                        begin
                            oled_data <= 16'b00000_000000_00000; //Black
                        end
                    // Eyes
                    else if ((y == y_fish+2) && ((x == x_fish+4) || (x == x_fish+6)))
                        begin
                            oled_data <=16'b01001_010001_01001; //Dark grey
                        end
                    //Red
                    else if ( (((y >= y_fish+2) && (y <= y_fish+5)) && (x == x_fish+5)) ||
                              (((y >= y_fish+8) && (y <= y_fish+6)) && (x == x_fish+8)) ||
                              (((x >= x_fish+3) && (x <= x_fish+4)) && (y == y_fish+6)) ||
                              (((x >= x_fish+4) && (x <= x_fish+5)) && (y == y_fish+8)) ||
                              (((x >= x_fish+6) && (x <= x_fish+8)) && (y == y_fish+12)) ||
                              ((y == y_fish+5) && ((x == x_fish+4) || (x == x_fish+9))) )
                        begin
                            oled_data <= 16'b11101_000111_00100; //Red
                        end
                    //Dark Red Parts
                    else if ( (((y >= y_fish+3) && (y <= y_fish+6)) && ((x >= x_fish+1) && (x <= x_fish+4))) ||
                              (((y >= y_fish+9) && (y <= y_fish+11)) && ((x >= x_fish+5) && (x <= x_fish+7))) ||
                              ((y == y_fish+3) && (x == x_fish+6)) )
                        begin
                            oled_data <= 16'b10011_000000_00110; //Dark Red
                        end
                    //White Parts
                    else if ( (((y >= y_fish+1) && (y <= y_fish+8)) && ((x >= x_fish+3) && (x <= x_fish+7))) ||
                              (((y >= y_fish+10) && (y <= y_fish+12)) && ((x >= x_fish+2) && (x <= x_fish+4))) )
                        begin
                            oled_data <= 16'b11111_111111_11111; //White
                        end
                end
            
            // submerged scene
            if ((fish_frame == 1) && ((fish_num==1 || fish_num==2 || fish_num==3) && submerged == 1))
               begin
               // Light Blue Boundary
                    if (((y == y_fish+8) && ((x == x_fish+1) || (x == x_fish+9))) ||
                        ((y == y_fish+9) && ((x >= x_fish+2) && (x <= x_fish+8))) ||
                        ((y == y_fish+10) && ((x >= x_fish+3) && (x <= x_fish+7))) )
                       begin
                           oled_data <= 16'b10001_100111_11101; //Light Blue
                       end
                   // Sea
                   else if (((y >= y_fish+10) && (y <= y_fish+13)) && ((x >= x_fish+1) && (x <= x_fish+9)))
                       begin
                           oled_data <=16'b01001_011011_11110; //Normal Blue
                       end
                   
               end
             
        end

endmodule
