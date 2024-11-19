`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 07:53:46 PM
// Design Name: 
// Module Name: Inventory
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


module Inventory(
input [12:0] pixel_index2,   // Pixel index (0-8191 for 96x64 screen)
input start_task,
input [6:0] x,              // x-coordinate (0-95)
input [5:0] y,              // y-coordinate (0-63)
input [7:0] selector,
input basys_clock,
input display_clock,
input [1:0] rod_num, 
input sell_mode,  
input buy_mode,   
output reg [15:0] oled_data2,
input signed [4:0] carp_count,
input signed [4:0] bluetang_count,
input signed [4:0] koi_count,
input signed [4:0] pumpkin_count,
input signed [4:0] wheat_count,
input signed [4:0] pumpkinseed_count,
input signed [4:0] wheatseed_count,
input signed [4:0] bait_count
    );
    
    // inverter
    wire [6:0] x_pos = 96 - (pixel_index2 % 96); // x-coordinate
    wire [5:0] y_pos = 64 - (pixel_index2 / 96); // y-coordinate
    
    //inverter
    wire [6:0] x_char = 96 - (pixel_index2 % 96); // x-coordinate
    wire [5:0] y_char = 64 - (pixel_index2 / 96); // y-coordinate
    wire [12:0] pixel_index = x_pos + y_pos*96;
    wire [15:0] char_output1;    
    wire [15:0] char_output2;    
    wire [15:0] char_output3;    
    wire [15:0] char_output4;    
    wire [15:0] char_output5;    
    wire [15:0] char_output6;    
    wire [15:0] char_output7;      
    wire [15:0] char_output0;    

    seven_seg test1(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(10), 
    .char_y(25),
    .numbervalue(bait_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output0)
);
    seven_seg test2(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(35), 
    .char_y(25),
    .numbervalue(wheatseed_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output1)
);
    seven_seg test3(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(58), 
    .char_y(25),
    .numbervalue(pumpkinseed_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output2)
);
    seven_seg test4(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(82), 
    .char_y(25),
    .numbervalue(carp_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output3)
);
    seven_seg test5(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(10), 
    .char_y(58),
    .numbervalue(bluetang_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output4)
);
    seven_seg test6(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(35), 
    .char_y(58),
    .numbervalue(koi_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output5)
);
    seven_seg test7(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(58), 
    .char_y(58),
    .numbervalue(wheat_count),   
     .pixel_index(pixel_index), 
    .oled_data(char_output6)
);
    seven_seg test8(    
    .display_clock(display_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(82), 
    .char_y(58),
    .numbervalue(pumpkin_count),
    .pixel_index(pixel_index), 
    .oled_data(char_output7)
);

    // Define coordinates for each fish
    wire [6:0] x_fish1 = 77;  
    wire [5:0] y_fish1 = 8;  
    wire [6:0] x_fish2 = 5;  
    wire [5:0] y_fish2 = 40;  
    wire [6:0] x_fish3 = 31;  
    wire [5:0] y_fish3 = 40;
    reg [6:0] checkbox_x = 0;  
    reg [5:0] checkbox_y = 0;  
    wire [6:0] bait_x = 33; 
    wire [5:0] bait_y = 8;    
    wire [6:0] bait2_x = 55; 
    wire [5:0] bait2_y = 8; 
    wire [6:0] fish_bait_x = 5; 
    wire [5:0] fish_bait_y = 8; 

 always @(posedge display_clock) begin
    oled_data2 <= 16'b0000000000000000;  


    
    if(((x_pos >= 1 && x_pos <= 22) || (x_pos >= 25 && x_pos <= 46) || (x_pos >= 49 && x_pos <= 70) || (x_pos >= 73 && x_pos <= 94))
    &&((y_pos >= 1 && y_pos <= 30) || (y_pos >= 33 && y_pos <= 62)))
    oled_data2 <= 16'b1000001110010101;  
    
    if ((x_pos >= 73 && x_pos <= 94) && (y_pos >= 33 && y_pos <= 62) && selector[7] == 1)
        oled_data2 <= 16'b11111_101000_10110;  
    if ((x_pos >= 49 && x_pos <= 70) && (y_pos >= 33 && y_pos <= 62) && selector[6] == 1)
        oled_data2 <= 16'b11111_101000_10110;  
    if ((x_pos >= 25 && x_pos <= 46) && (y_pos >= 33 && y_pos <= 62) && selector[5] == 1)
        oled_data2 <= 16'b11111_101000_10110; 
         
    if ((x_pos >= 1 && x_pos <= 22)  && (y_pos >= 33 && y_pos <= 62) && selector[4] == 1)
            oled_data2 <= 16'b11111_101000_10110;          
    if ((x_pos >= 73 && x_pos <= 94) && (y_pos >= 1 && y_pos <= 30)  && selector[3] == 1)
       oled_data2 <= 16'b11111_101000_10110;  
    if ((x_pos >= 49 && x_pos <= 70) && (y_pos >= 1 && y_pos <= 30)  && selector[2] == 1)
       oled_data2 <= 16'b11111_101000_10110;  
    if ((x_pos >= 25 && x_pos <= 46) && (y_pos >= 1 && y_pos <= 30)  && selector[1] == 1)
       oled_data2 <= 16'b11111_101000_10110;  
    if ((x_pos >= 1 && x_pos <= 22)  && (y_pos >= 1 && y_pos <= 30) && selector[0] == 1)
       oled_data2 <= 16'b11111_101000_10110;  
    
    //counter   
    if (char_output0 != 0)
           oled_data2 <= char_output0;     
       if (char_output1 != 0)
           oled_data2 <= char_output1;  
       if (char_output2 != 0)
           oled_data2 <= char_output2;  
       if (char_output3 != 0)
           oled_data2 <= char_output3;  
       if (char_output4 != 0)
           oled_data2 <= char_output4;  
       if (char_output5 != 0)
           oled_data2 <= char_output5;  
       if (char_output6 != 0)
           oled_data2 <= char_output6;  
       if (char_output7 != 0)
           oled_data2 <= char_output7;      
           
           // Full Carp
               // Black outline
               if (((y_pos == y_fish1) && ((x_pos >= x_fish1+3) && (x_pos <= x_fish1+7))) ||
                   ((y_pos == y_fish1+1) && ((x_pos == x_fish1+3) || (x_pos == x_fish1+7))) ||
                   (((x_pos == x_fish1+2) || (x_pos == x_fish1+8)) && ((y_pos >= y_fish1+1) && (y_pos <= y_fish1+3))) ||
                   (((x_pos == x_fish1+1) || (x_pos == x_fish1+9)) && ((y_pos >= y_fish1+3) && (y_pos <= y_fish1+4))) ||
                   (((x_pos == x_fish1) || (x_pos == x_fish1+10)) && ((y_pos >= y_fish1+4) && (y_pos <= y_fish1+6))) ||
                   (((x_pos == x_fish1+1) || (x_pos == x_fish1+9)) && ((y_pos >= y_fish1+6) && (y_pos <= y_fish1+7))) ||
                   (((x_pos == x_fish1+2) || (x_pos == x_fish1+8)) && ((y_pos >= y_fish1+7) && (y_pos <= y_fish1+8))) ||
                   ((y_pos == y_fish1+8) && ((x_pos == x_fish1+3) || (x_pos == x_fish1+7))) ||
                   ((y_pos == y_fish1+9) && (((x_pos >= x_fish1+3) && (x_pos <= x_fish1+4)) || ((x_pos >= x_fish1+6) && (x_pos <= x_fish1+7)))) ||
                   ((y_pos == y_fish1+10) && (((x_pos >= x_fish1+2) && (x_pos <= x_fish1+3)) || ((x_pos >= x_fish1+7) && (x_pos <= x_fish1+8)))) ||
                   ((y_pos == y_fish1+11) && (((x_pos >= x_fish1+1) && (x_pos <= x_fish1+2)) || ((x_pos >= x_fish1+8) && (x_pos <= x_fish1+9)))) ||
                   ((y_pos == y_fish1+12) && ((x_pos == x_fish1+1) || (x_pos == x_fish1+5) || (x_pos == x_fish1+9))) ||
                   ((y_pos == y_fish1+13) && ((x_pos >= x_fish1+1) && (x_pos <= x_fish1+9)))) begin
                   oled_data2 <= 16'b00000_000000_00000; // Black
               // Eyes
               end
               else if ((y_pos == y_fish1 + 2) && ((x_pos == x_fish1 + 4) || (x_pos == x_fish1 + 6))) begin
                   oled_data2 <= 16'b01001_010001_01001; // Dark grey
               end
               // Brown Parts
               else if ((((y_pos >= y_fish1+3) && (y_pos <= y_fish1+6)) && (((x_pos >= x_fish1+1) && (x_pos <= x_fish1+3)) || (x_pos == x_fish1+5) || ((x_pos >= x_fish1+7) && (x_pos <= x_fish1+9)))) ||
                        (((y_pos >= y_fish1+9) && (y_pos <= y_fish1+10)) && ((x_pos >= x_fish1+4) && (x_pos <= x_fish1+6))) ||
                        (((y_pos >= y_fish1+11) && (y_pos <= y_fish1+12)) && ((x_pos >= x_fish1+2) && (x_pos <= x_fish1+8)))) begin
                   oled_data2 <= 16'b10011_010110_00111; // Brown
               end
               // Light Grey Parts
               else if (((y_pos >= y_fish1+2) && (y_pos <= y_fish1+7)) && ((x_pos >= x_fish1+4) && (x_pos <= x_fish1+6))) begin
                   oled_data2 <= 16'b10110_101100_10110; // Light grey
               end
               // White Parts
               else if (((y_pos >= y_fish1+1) && (y_pos <= y_fish1+8)) && ((x_pos >= x_fish1+3) && (x_pos <= x_fish1+7))) begin
                   oled_data2 <= 16'b11111_111111_11111; // White
               end   
               
// Blue Tang
                   // Black outline and black fin
                   if (((y_pos == y_fish2) && ((x_pos >= x_fish2+3) && (x_pos <= x_fish2+7))) ||
                       ((y_pos == y_fish2+1) && ((x_pos == x_fish2+3) || (x_pos == x_fish2+7))) ||
                       (((x_pos == x_fish2+2) || (x_pos == x_fish2+8)) && ((y_pos >= y_fish2+1) && (y_pos <= y_fish2+3))) ||
                       (((x_pos == x_fish2+1) || (x_pos == x_fish2+9)) && ((y_pos >= y_fish2+3) && (y_pos <= y_fish2+4))) ||
                       (((x_pos == x_fish2) || (x_pos == x_fish2+10)) && ((y_pos >= y_fish2+4) && (y_pos <= y_fish2+6))) ||
                       (((x_pos == x_fish2+1) || (x_pos == x_fish2+9)) && ((y_pos >= y_fish2+6) && (y_pos <= y_fish2+7))) ||
                       (((x_pos == x_fish2+2) || (x_pos == x_fish2+8)) && ((y_pos >= y_fish2+7) && (y_pos <= y_fish2+8))) ||
                       ((y_pos == y_fish2+8) && ((x_pos == x_fish2+3) || (x_pos == x_fish2+7))) ||
                       ((y_pos == y_fish2+9) && (((x_pos >= x_fish2+3) && (x_pos <= x_fish2+4)) || ((x_pos >= x_fish2+6) && (x_pos <= x_fish2+7)))) ||
                       ((y_pos == y_fish2+10) && (((x_pos >= x_fish2+2) && (x_pos <= x_fish2+3)) || ((x_pos >= x_fish2+7) && (x_pos <= x_fish2+8)))) ||
                       ((y_pos == y_fish2+11) && (((x_pos >= x_fish2+1) && (x_pos <= x_fish2+2)) || ((x_pos >= x_fish2+8) && (x_pos <= x_fish2+9)))) ||
                       ((y_pos == y_fish2+12) && ((x_pos == x_fish2+1) || (x_pos == x_fish2+5) || (x_pos == x_fish2+9))) ||
                       ((y_pos == y_fish2+13) && ((x_pos >= x_fish2+1) && (x_pos <= x_fish2+9))) ||
                       ((x_pos == x_fish2+5) && ((y_pos >= y_fish2+3) && (y_pos <= y_fish2+7)))) begin  // Black fin
                       oled_data2 <= 16'b00000_000000_00000; // Black
                   end
                   // Eyes
                   else if ((y_pos == y_fish2+2) && ((x_pos == x_fish2+4) || (x_pos == x_fish2+6))) begin
                       oled_data2 <= 16'b01001_010001_01001; // Dark grey
                   end
                   // Darker Dark Blue Parts
                   else if ((((y_pos >= y_fish2+4) && (y_pos <= y_fish2+6)) && ((x_pos == x_fish2+4) || (x_pos == x_fish2+6))) ||
                            ((y_pos == y_fish2+9) && (x_pos == x_fish2+5)) ||
                            ((y_pos == y_fish2+10) && ((x_pos == x_fish2+4) || (x_pos == x_fish2+6)))) begin
                       oled_data2 <= 16'b00001_000100_01100; // Darker Dark Blue
                   end
                   // Dark Blue Parts
                   else if ((((y_pos >= y_fish2+1) && (y_pos <= y_fish2+8)) && ((x_pos >= x_fish2+3) && (x_pos <= x_fish2+7))) ||
                            ((y_pos == y_fish2+11) && (((x_pos >= x_fish2+3) && (x_pos <= x_fish2+4)) || ((x_pos >= x_fish2+7) && (x_pos <= x_fish2+8)))) ||
                            ((y_pos == y_fish2+12) && (((x_pos >= x_fish2+2) && (x_pos <= x_fish2+3)) || ((x_pos >= x_fish2+8) && (x_pos <= x_fish2+9))))) begin
                       oled_data2 <= 16'b00110_001101_10011; // Dark Blue
                   end
                   // Dark Yellow Parts
                   else if (((y_pos == y_fish2+5) && ((x_pos == x_fish2+2) || (x_pos == x_fish2+8))) ||
                            ((y_pos == y_fish2+10) && (x_pos == x_fish2+5))) begin
                       oled_data2 <= 16'b11111_110000_00010; // Dark Yellow
                   end
                   // Yellow Parts
                   else if ((((y_pos >= y_fish2+4) && (y_pos <= y_fish2+6)) && (((x_pos >= x_fish2+1) && (x_pos <= x_fish2+2)) || ((x_pos >= x_fish2+8) && (x_pos <= x_fish2+9)))) ||
                            ((y_pos >= y_fish2+11) && (y_pos <= y_fish2+12) && ((x_pos >= x_fish2+4) && (x_pos <= x_fish2+6)))) begin
                       oled_data2 <= 16'b11111_111100_00000; // Yellow
                   end
               
               // Koi
                   // Black outline
                   if (((y_pos == y_fish3) && ((x_pos >= x_fish3+3) && (x_pos <= x_fish3+7))) ||
                       ((y_pos == y_fish3+1) && ((x_pos == x_fish3+3) || (x_pos == x_fish3+7))) ||
                       (((x_pos == x_fish3+2) || (x_pos == x_fish3+8)) && ((y_pos >= y_fish3+1) && (y_pos <= y_fish3+3))) ||
                       (((x_pos == x_fish3+1) || (x_pos == x_fish3+9)) && ((y_pos >= y_fish3+3) && (y_pos <= y_fish3+4))) ||
                       (((x_pos == x_fish3) || (x_pos == x_fish3+10)) && ((y_pos >= y_fish3+4) && (y_pos <= y_fish3+6))) ||
                       (((x_pos == x_fish3+1) || (x_pos == x_fish3+9)) && ((y_pos >= y_fish3+6) && (y_pos <= y_fish3+7))) ||
                       (((x_pos == x_fish3+2) || (x_pos == x_fish3+8)) && ((y_pos >= y_fish3+7) && (y_pos <= y_fish3+8))) ||
                       ((y_pos == y_fish3+8) && ((x_pos == x_fish3+3) || (x_pos == x_fish3+7))) ||
                       ((y_pos == y_fish3+9) && (((x_pos >= x_fish3+3) && (x_pos <= x_fish3+4)) || ((x_pos >= x_fish3+6) && (x_pos <= x_fish3+7)))) ||
                       ((y_pos == y_fish3+10) && (((x_pos >= x_fish3+2) && (x_pos <= x_fish3+3)) || ((x_pos >= x_fish3+7) && (x_pos <= x_fish3+8)))) ||
                       ((y_pos == y_fish3+11) && (((x_pos >= x_fish3+1) && (x_pos <= x_fish3+2)) || ((x_pos >= x_fish3+8) && (x_pos <= x_fish3+9)))) ||
                       ((y_pos == y_fish3+12) && ((x_pos == x_fish3+1) || (x_pos == x_fish3+5) || (x_pos == x_fish3+9))) ||
                       ((y_pos == y_fish3+13) && ((x_pos >= x_fish3+1) && (x_pos <= x_fish3+9)))) begin
                       oled_data2 <= 16'b00000_000000_00000; // Black
                   end
                   // Eyes
                   else if ((y_pos == y_fish3+2) && ((x_pos == x_fish3+4) || (x_pos == x_fish3+6))) begin
                       oled_data2 <= 16'b01001_010001_01001; // Dark grey
                   end
                   // Red
                   else if ((((y_pos >= y_fish3+2) && (y_pos <= y_fish3+5)) && (x_pos == x_fish3+5)) ||
                            (((y_pos >= y_fish3+8) && (y_pos <= y_fish3+6)) && (x_pos == x_fish3+8)) ||
                            (((x_pos >= x_fish3+3) && (x_pos <= x_fish3+4)) && (y_pos == y_fish3+6)) ||
                            (((x_pos >= x_fish3+4) && (x_pos <= x_fish3+5)) && (y_pos == y_fish3+8)) ||
                            (((x_pos >= x_fish3+6) && (x_pos <= x_fish3+8)) && (y_pos == y_fish3+12)) ||
                            ((y_pos == y_fish3+5) && ((x_pos == x_fish3+4) || (x_pos == x_fish3+9)))) begin
                       oled_data2 <= 16'b11101_000111_00100; // Red
                   end
                   // Dark Red Parts
                   else if ((((y_pos >= y_fish3+3) && (y_pos <= y_fish3+6)) && ((x_pos >= x_fish3+1) && (x_pos <= x_fish3+4))) ||
                            (((y_pos >= y_fish3+9) && (y_pos <= y_fish3+11)) && ((x_pos >= x_fish3+5) && (x_pos <= x_fish3+7))) ||
                            ((y_pos == y_fish3+3) && (x_pos == x_fish3+6))) begin
                       oled_data2 <= 16'b10011_000000_00110; // Dark Red
                   end
                   // White Parts
                   else if ((((y_pos >= y_fish3+1) && (y_pos <= y_fish3+8)) && ((x_pos >= x_fish3+3) && (x_pos <= x_fish3+7))) ||
                            (((y_pos >= y_fish3+10) && (y_pos <= y_fish3+12)) && ((x_pos >= x_fish3+2) && (x_pos <= x_fish3+4)))) begin
                       oled_data2 <= 16'b11111_111111_11111; // White
                   end

// seed 1
if ((pixel_index == (bait_y * 96 + bait_x) + 1) || 
    ((pixel_index >= (bait_y * 96 + bait_x) + 96) && (pixel_index <= (bait_y * 96 + bait_x) + 97)) || 
    ((pixel_index >= (bait_y * 96 + bait_x) + 99) && (pixel_index <= (bait_y * 96 + bait_x) + 100)) || 
    pixel_index == (bait_y * 96 + bait_x) + 198 || 
    pixel_index == (bait_y * 96 + bait_x) + 289 || 
    pixel_index == (bait_y * 96 + bait_x) + 293 || 
    pixel_index == (bait_y * 96 + bait_x) + 384 || 
    pixel_index == (bait_y * 96 + bait_x) + 388 || 
    pixel_index == (bait_y * 96 + bait_x) + 483 || 
    pixel_index == (bait_y * 96 + bait_x) + 577 || 
    pixel_index == (bait_y * 96 + bait_x) + 582 || 
    ((pixel_index >= (bait_y * 96 + bait_x) + 672) && (pixel_index <= (bait_y * 96 + bait_x) + 673)) || 
    ((pixel_index >= (bait_y * 96 + bait_x) + 677) && (pixel_index <= (bait_y * 96 + bait_x) + 678)) || 
    pixel_index == (bait_y * 96 + bait_x) + 195 || 
    pixel_index == (bait_y * 96 + bait_x) + 294 || 
    pixel_index == (bait_y * 96 + bait_x) + 385 || 
    pixel_index == (bait_y * 96 + bait_x) + 484) begin
    oled_data2 <= 16'b1111111110100000;
end
//seed 2
if ((pixel_index == (bait2_y * 96 + bait2_x) + 1) || 
    ((pixel_index >= (bait2_y * 96 + bait2_x) + 96) && (pixel_index <= (bait2_y * 96 + bait2_x) + 97)) || 
    ((pixel_index >= (bait2_y * 96 + bait2_x) + 99) && (pixel_index <= (bait2_y * 96 + bait2_x) + 100)) || 
    pixel_index == (bait2_y * 96 + bait2_x) + 198 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 289 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 293 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 384 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 388 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 483 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 577 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 582 || 
    ((pixel_index >= (bait2_y * 96 + bait2_x) + 672) && (pixel_index <= (bait2_y * 96 + bait2_x) + 673)) || 
    ((pixel_index >= (bait2_y * 96 + bait2_x) + 677) && (pixel_index <= (bait2_y * 96 + bait2_x) + 678)) || 
    pixel_index == (bait2_y * 96 + bait2_x) + 195 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 294 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 385 || 
    pixel_index == (bait2_y * 96 + bait2_x) + 484) begin
    oled_data2 <= 16'b1111110000000000;
end

if (pixel_index == 873 || pixel_index == 878 || pixel_index == 1158 || pixel_index == 1255 || pixel_index == 1260 || pixel_index == 1264 || pixel_index == 1357 || pixel_index == 1361 || pixel_index == 1456 || pixel_index == 1545 || pixel_index == 1640 || pixel_index == 1647 || pixel_index == 1742) oled_data2 <= 16'b0111101000001011;
else if (pixel_index == 968 || pixel_index == 970 || pixel_index == 973 || pixel_index == 975 || pixel_index == 1253 || pixel_index == 1355 || pixel_index == 1448 || pixel_index == 1543 || pixel_index == 1550 || pixel_index == 1645) oled_data2 <= 16'b1000001000001011;
else if (pixel_index == 969 || pixel_index == 1360 || pixel_index == 1544) oled_data2 <= 16'b1111111100101111;
else if (pixel_index == 974 || pixel_index == 1254 || pixel_index == 1356 || pixel_index == 1646) oled_data2 <= 16'b1111111100110000;
else if (pixel_index == 1065 || pixel_index == 1070 || pixel_index == 1350 || pixel_index == 1452) oled_data2 <= 16'b0111100111001011;
else if (pixel_index == 1359) oled_data2 <= 16'b1000000111001011;
else if (((pixel_index >= 4181) && (pixel_index <= 4182)) || ((pixel_index >= 4184) && (pixel_index <= 4185)) || ((pixel_index >= 4187) && (pixel_index <= 4188)) || ((pixel_index >= 4190) && (pixel_index <= 4191)) || pixel_index == 4277 || pixel_index == 4280 || pixel_index == 4283 || pixel_index == 4286 || pixel_index == 4374 || pixel_index == 4377 || pixel_index == 4380 || pixel_index == 4383 || pixel_index == 4662 || pixel_index == 4665 || pixel_index == 4668 || pixel_index == 4671 || pixel_index == 4758 || pixel_index == 4761 || pixel_index == 4764 || pixel_index == 4767) oled_data2 <= 16'b1111111010100000;
else if (pixel_index == 4278 || pixel_index == 4281 || pixel_index == 4284 || pixel_index == 4287) oled_data2 <= 16'b1111111011100000;
else if (((pixel_index >= 4402) && (pixel_index <= 4403)) || pixel_index == 4498 || pixel_index == 4500 || pixel_index == 4594 || pixel_index == 4690) oled_data2 <= 16'b0000001001000000;
else if (pixel_index == 4469 || pixel_index == 4472 || pixel_index == 4475 || pixel_index == 4478 || pixel_index == 4566 || pixel_index == 4569 || pixel_index == 4572 || ((pixel_index >= 4575) && (pixel_index <= 4576)) || pixel_index == 4663 || pixel_index == 4666 || pixel_index == 4669 || pixel_index == 4768 || pixel_index == 4855 || pixel_index == 4858 || pixel_index == 4861 || pixel_index == 4957 || pixel_index == 4960 || pixel_index == 5047 || pixel_index == 5050 || pixel_index == 5146 || pixel_index == 5149 || pixel_index == 5152) oled_data2 <= 16'b0111101101000000;
else if (pixel_index == 4470 || pixel_index == 4473 || pixel_index == 4476 || pixel_index == 4479 || pixel_index == 4567 || pixel_index == 4570 || pixel_index == 4573 || pixel_index == 4672 || pixel_index == 4759 || pixel_index == 4762 || pixel_index == 4765 || pixel_index == 4864 || pixel_index == 4951 || pixel_index == 4954 || pixel_index == 5053 || pixel_index == 5056 || pixel_index == 5143) oled_data2 <= 16'b1000001101000000;
else if (((pixel_index >= 4687) && (pixel_index <= 4689)) || ((pixel_index >= 4691) && (pixel_index <= 4694)) || ((pixel_index >= 4783) && (pixel_index <= 4790)) || ((pixel_index >= 4877) && (pixel_index <= 4881)) || ((pixel_index >= 4883) && (pixel_index <= 4885)) || ((pixel_index >= 4887) && (pixel_index <= 4888)) || ((pixel_index >= 4973) && (pixel_index <= 4975)) || ((pixel_index >= 4977) && (pixel_index <= 4984)) || ((pixel_index >= 5069) && (pixel_index <= 5080)) || ((pixel_index >= 5165) && (pixel_index <= 5170)) || ((pixel_index >= 5172) && (pixel_index <= 5173)) || ((pixel_index >= 5175) && (pixel_index <= 5176)) || pixel_index == 5261 || ((pixel_index >= 5263) && (pixel_index <= 5264)) || (pixel_index >= 5266) && (pixel_index <= 5272)) oled_data2 <= 16'b1111101101000000;
else if (pixel_index == 4882 || pixel_index == 4886 || pixel_index == 4976 || pixel_index == 5171 || pixel_index == 5174 || pixel_index == 5262 || pixel_index == 5265) oled_data2 <= 16'b1111101100000000;
 
           
       if((x_pos >= 1 && x_pos <= 70) && (y_pos >= 1 && y_pos <= 30) && sell_mode == 1)begin
       oled_data2 <= 16'b1000001000010101;
        checkbox_x <= 9;
        checkbox_y <= 19;
        if (((pixel_index >= 410) && (pixel_index <= 411)) || ((pixel_index >= 415) && (pixel_index <= 418)) || pixel_index == 421 || pixel_index == 427 || pixel_index == 434 || pixel_index == 505 || pixel_index == 508 || pixel_index == 511 || pixel_index == 517 || pixel_index == 523 || pixel_index == 529 || pixel_index == 531 || pixel_index == 601 || pixel_index == 607 || pixel_index == 613 || pixel_index == 619 || pixel_index == 624 || pixel_index == 628 || pixel_index == 698 || ((pixel_index >= 703) && (pixel_index <= 706)) || pixel_index == 709 || pixel_index == 715 || pixel_index == 723 || pixel_index == 795 || ((pixel_index >= 799) && (pixel_index <= 802)) || pixel_index == 805 || pixel_index == 811 || pixel_index == 818 || pixel_index == 892 || pixel_index == 895 || pixel_index == 901 || pixel_index == 907 || pixel_index == 914 || pixel_index == 985 || pixel_index == 988 || pixel_index == 991 || ((pixel_index >= 997) && (pixel_index <= 1000)) || ((pixel_index >= 1003) && (pixel_index <= 1006)) || ((pixel_index >= 1082) && (pixel_index <= 1083)) || ((pixel_index >= 1087) && (pixel_index <= 1090)) || ((pixel_index >= 1093) && (pixel_index <= 1096)) || ((pixel_index >= 1099) && (pixel_index <= 1102)) || pixel_index == 1106)
         oled_data2 <= 0; 
        //yes or no
           if ((pixel_index >= (checkbox_y * 96 + checkbox_x) + 0 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 21) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 31 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 52) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 96 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 117 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 127 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 148 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 192 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 198 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 200 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 202 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 204) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 206 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 208) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 213 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 223 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 230 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 233 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 235 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 238) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 244 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 288 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 294 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 296 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 298 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 302 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 309 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 319 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 326 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 327) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 329 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 331 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 334 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 340 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 384 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 390 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 392) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 394 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 396) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 398 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 400) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 405 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 415 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 422 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 425) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 427 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 430 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 436 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 480 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 487 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 490 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 496 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 501 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 511 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 518 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 520 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 521) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 523 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 526 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 532 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 576 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 583 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 586 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 588) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 590 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 592) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 597 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 607 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 614 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 617 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 619 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 622) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 628 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 672 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 693 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 703 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 724 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 768 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 789) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 799 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 820)
       ) oled_data2 <= 0; 

  
       end
    if((x_pos >= 1 && x_pos <= 94) && (y_pos >= 33 && y_pos <= 62) && buy_mode == 1)begin
       oled_data2 <= 16'b1000001000010101;  
              oled_data2 <= 16'b1000001000010101;
        //buy question mark
        if (((pixel_index >= 3681) && (pixel_index <= 3684)) || pixel_index == 3688 || pixel_index == 3693 || pixel_index == 3696 || pixel_index == 3700 || pixel_index == 3705 || pixel_index == 3777 || pixel_index == 3781 || pixel_index == 3784 || pixel_index == 3789 || pixel_index == 3792 || pixel_index == 3796 || pixel_index == 3800 || pixel_index == 3802 || pixel_index == 3873 || pixel_index == 3877 || pixel_index == 3880 || pixel_index == 3885 || pixel_index == 3888 || pixel_index == 3892 || pixel_index == 3895 || pixel_index == 3899 || ((pixel_index >= 3969) && (pixel_index <= 3972)) || pixel_index == 3976 || pixel_index == 3981 || pixel_index == 3984 || pixel_index == 3988 || pixel_index == 3994 || ((pixel_index >= 4065) && (pixel_index <= 4068)) || pixel_index == 4072 || pixel_index == 4077 || ((pixel_index >= 4081) && (pixel_index <= 4083)) || pixel_index == 4089 || pixel_index == 4161 || pixel_index == 4165 || pixel_index == 4168 || pixel_index == 4173 || pixel_index == 4178 || pixel_index == 4185 || pixel_index == 4257 || pixel_index == 4261 || pixel_index == 4265 || pixel_index == 4268 || pixel_index == 4274 || ((pixel_index >= 4353) && (pixel_index <= 4356)) || ((pixel_index >= 4362) && (pixel_index <= 4363)) || pixel_index == 4370 || pixel_index == 4377)
        oled_data2 <= 0; 
        checkbox_x <= 22;
        checkbox_y <= 54;
        //yes or no
           if ((pixel_index >= (checkbox_y * 96 + checkbox_x) + 0 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 21) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 31 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 52) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 96 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 117 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 127 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 148 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 192 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 198 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 200 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 202 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 204) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 206 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 208) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 213 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 223 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 230 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 233 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 235 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 238) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 244 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 288 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 294 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 296 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 298 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 302 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 309 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 319 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 326 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 327) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 329 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 331 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 334 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 340 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 384 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 390 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 392) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 394 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 396) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 398 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 400) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 405 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 415 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 422 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 425) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 427 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 430 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 436 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 480 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 487 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 490 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 496 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 501 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 511 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 518 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 520 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 521) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 523 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 526 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 532 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 576 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 583 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 586 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 588) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 590 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 592) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 597 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 607 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 614 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 617 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 619 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 622) ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 628 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 672 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 693 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 703 ||
           pixel_index == (checkbox_y * 96 + checkbox_x) + 724 ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 768 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 789) ||
           (pixel_index >= (checkbox_y * 96 + checkbox_x) + 799 && pixel_index <= (checkbox_y * 96 + checkbox_x) + 820)
       ) oled_data2 <= 0; 
       end
       


 end   
    
endmodule
