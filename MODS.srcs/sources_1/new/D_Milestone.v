`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 03:34:16 AM
// Design Name: 
// Module Name: D_Milestone
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


/*module D_Milestone(
    input [12:0] pixel_index,   // Pixel index (0-8191 for 96x64 screen)
    input start_task,
    input [6:0] x,              // x-coordinate (0-95)
    input [5:0] y,              // y-coordinate (0-63)
    input basys_clock,
    input display_clock,
    input [1:0] rod_num,
   // input [2:0] inputcurrentTaskB,    
    output reg sell_mode = 0,
    output reg [1:0] rod_num_out,
    input btnU, btnD, btnC, btnL, btnR,
    output reg [15:0] oled_data,
    
    input shop,
    output reg gobackFarm = 0
   // output reg [2:0] outputcurrentTaskB = 0
);

// Calculate x and y positions based on pixel index
wire [6:0] x_pos = pixel_index % 96; // x-coordinate
wire [5:0] y_pos = pixel_index / 96; // y-coordinate


// Offsets for moving the character
reg [6:0] x_offset = 41; // Set this value to move horizontally
reg [5:0] y_offset = 49; // Set this value to move vertically
wire clk20;
reg facing_up = 1;
reg facing_down = 0;
reg facing_left = 0;
reg facing_right = 0;
wire [15:0] char_output;
reg state = 0;
reg item_code = 0;

flexible_clock First_CLK(.basys_clock(basys_clock), .count(2499_999), .SLOW_CLOCK(clk20));

my_char character(
    .basys_clk(basys_clock),
    .x(x_pos),
    .y(y_pos),
    .char_x(x_offset), 
    .char_y(y_offset),
    .facing_down(facing_down),
    .facing_up(facing_up),
    .facing_left(facing_left),
    .facing_right(facing_right),
    .oled_data(char_output)
    );

assign right_logic = ((y_offset <= 49 && y_offset >= 45 && x_offset >= 5 && x_offset < 81) || (x_offset >= 5 && x_offset < 12) || (x_offset >= 71 && x_offset < 81)||(x_offset >= 31 && x_offset < 54));
assign left_logic =  ((y_offset <= 49 && y_offset >= 45 && x_offset > 5 && x_offset <= 81) || (x_offset > 5 && x_offset <= 12) || (x_offset > 71 && x_offset <= 81)||(x_offset > 31 && x_offset <= 54));
assign down_logic =  ((y_offset < 49 && y_offset >= 45 && x_offset >= 5 && x_offset <= 81)|| (((x_offset >= 5 && x_offset <= 12) || (x_offset >= 71 && x_offset <= 81)||(x_offset >= 31 && x_offset <= 54)) && (y_offset < 49 && y_offset >= 31)));
assign up_logic =  ((y_offset <= 49 && y_offset > 45 && x_offset >= 5 && x_offset <= 81)|| (((x_offset >= 5 && x_offset <= 12) || (x_offset >= 71 && x_offset <= 81)||(x_offset >= 31 && x_offset <= 54)) && (y_offset <= 49 && y_offset > 31)));

always @(posedge clk20) begin
if (shop == 0) gobackFarm <= 0;
if (btnC &&  x_offset > 30 && x_offset < 50 && y_offset > 48) gobackFarm <= 1;
    if(sell_mode == 0)begin
    if(right_logic && btnR == 1)begin
        x_offset <= x_offset + 1;  
        facing_up <= 0;
        facing_down <= 0;
        facing_left <= 0;
        facing_right <= 1; 
        end 
    if(left_logic && btnL == 1)begin
        x_offset <= x_offset - 1; 
        facing_up <= 0;
        facing_down <= 0;
        facing_left <= 1;
        facing_right <= 0;   
        end
    if(down_logic && btnD == 1)begin
        y_offset <= y_offset + 1;  
        facing_up <= 0;
        facing_down <= 1;
        facing_left <= 0;
        facing_right <= 0;     
        end 
    if(up_logic && btnU == 1)begin
        y_offset <= y_offset - 1;
        facing_up <= 1;
        facing_down <= 0;
        facing_left <= 0;
        facing_right <= 0;  
        end
    end
end





always @(posedge display_clock) begin
        
        if (pixel_index >= 2688 && pixel_index <= 6143) begin
            //for floor
            oled_data <= 16'b1110110010100111; 
        //for top 
        end else begin
           if ((x_pos == 0 || x_pos == 8 || x_pos == 9 || x_pos == 17 || 
                     x_pos == 18 || x_pos == 26 || x_pos == 27 || x_pos == 35 || 
                     x_pos == 36 || x_pos == 44 || x_pos == 45 || x_pos == 53 || 
                     x_pos == 54 || x_pos == 62 || x_pos == 63 || x_pos == 71 || 
                     x_pos == 72 || x_pos == 80 || x_pos == 81 || x_pos == 89 || 
                     x_pos == 90 || y_pos == 0 || y_pos == 13 || y_pos == 27)) begin
                    oled_data <= 16'b0011100000000100; // Set the desired color
                end
                else if ((y_pos >= 1 && y_pos <= 12) || (y_pos >= 14 && y_pos <= 26)) begin
                    if ((x_pos == 1 || x_pos == 3 || x_pos == 5 || x_pos == 7 || 
                         x_pos == 10 || x_pos == 12 || x_pos == 14 || x_pos == 16 || 
                         x_pos == 19 || x_pos == 21 || x_pos == 23 || x_pos == 25 ||
                         x_pos == 28 || x_pos == 30 || x_pos == 32 || x_pos == 34 || 
                         x_pos == 37 || x_pos == 39 || x_pos == 41 || x_pos == 43 || 
                         x_pos == 46 || x_pos == 48 || x_pos == 50 || x_pos == 52 || 
                         x_pos == 55 || x_pos == 57 || x_pos == 59 || x_pos == 61 || 
                         x_pos == 64 || x_pos == 66 || x_pos == 68 || x_pos == 70 || 
                         x_pos == 73 || x_pos == 75 || x_pos == 77 || x_pos == 79 || 
                         x_pos == 82 || x_pos == 84 || x_pos == 86 || x_pos == 88 || 
                         x_pos == 91 || x_pos == 93 || x_pos == 95)) begin
                        oled_data <= 16'b0110000001000001; // Second color pattern
                    end
                    else if ((x_pos == 2 || x_pos == 4 || x_pos == 6 || x_pos == 11 || 
                              x_pos == 13 || x_pos == 15 || x_pos == 20 || x_pos == 22 || 
                              x_pos == 24 || x_pos == 29 || x_pos == 31 || x_pos == 33 || 
                              x_pos == 38 || x_pos == 40 || x_pos == 42 || x_pos == 47 || 
                              x_pos == 49 || x_pos == 51 || x_pos == 56 || x_pos == 58 || 
                              x_pos == 60 || x_pos == 65 || x_pos == 67 || x_pos == 69 || 
                              x_pos == 74 || x_pos == 76 || x_pos == 78 || x_pos == 83 || 
                              x_pos == 85 || x_pos == 87 || x_pos == 92 || x_pos == 94)) begin
                              oled_data <= 16'b0111000100000101; // Third color pattern
                              end
                end
                else
                    oled_data <= 0;
    end
    
        //shopekeeper
        if (((pixel_index >= 2060) && (pixel_index <= 2063)) || ((pixel_index >= 2153) && (pixel_index <= 2156)) || ((pixel_index >= 2159) && (pixel_index <= 2161)) || pixel_index == 2249 || pixel_index == 2258 || pixel_index == 2345 || pixel_index == 2354 || pixel_index == 2441 || pixel_index == 2450 || pixel_index == 2537 || pixel_index == 2546 || pixel_index == 2633 || pixel_index == 2642 || pixel_index == 2729 || pixel_index == 2738 || pixel_index == 2826 || ((pixel_index >= 2833) && (pixel_index <= 2834)) || pixel_index == 2922 || pixel_index == 2929 || pixel_index == 3017 || pixel_index == 3026 || pixel_index == 3113 || pixel_index == 3122 || pixel_index == 3208 || pixel_index == 3219 || pixel_index == 3303) 
        oled_data <= 16'b1111111111111111;
        else if (pixel_index == 2157) oled_data <= 16'b0101100100000001;
        else if (pixel_index == 2158) oled_data <= 16'b0101000100000001;
        else if (pixel_index == 2250) oled_data <= 16'b0100100111000101;
        else if (pixel_index == 2251) oled_data <= 16'b0110100101000010;
        else if (pixel_index == 2252) oled_data <= 16'b0111000110000010;
        else if (pixel_index == 2253) oled_data <= 16'b1000100110000000;
        else if (pixel_index == 2254) oled_data <= 16'b1000100110000001;
        else if (pixel_index == 2255) oled_data <= 16'b0111100110000001;
        else if (pixel_index == 2256) oled_data <= 16'b0110100110000010;
        else if (pixel_index == 2257) oled_data <= 16'b0100100110000100;
        else if (pixel_index == 2346) oled_data <= 16'b0110100100000001;
        else if (pixel_index == 2347) oled_data <= 16'b0110100101000001;
        else if (pixel_index == 2348) oled_data <= 16'b1011101011000011;
        else if (pixel_index == 2349) oled_data <= 16'b1101101101000011;
        else if (pixel_index == 2350) oled_data <= 16'b1101001101000100;
        else if (pixel_index == 2351) oled_data <= 16'b1100101100000011;
        else if (pixel_index == 2352) oled_data <= 16'b0111000100000000;
        else if (pixel_index == 2353) oled_data <= 16'b0110000101000001;
        else if (pixel_index == 2442) oled_data <= 16'b1000000111000011;
        else if (pixel_index == 2443) oled_data <= 16'b1000000110000001;
        else if (pixel_index == 2444) oled_data <= 16'b1000100111000010;
        else if (pixel_index == 2445) oled_data <= 16'b1011001011001000;
        else if (pixel_index == 2446) oled_data <= 16'b1011001100001001;
        else if (pixel_index == 2447) oled_data <= 16'b1000100111000100;
        else if (pixel_index == 2448) oled_data <= 16'b0111100101000001;
        else if (pixel_index == 2449) oled_data <= 16'b1000000111000100;
        else if (pixel_index == 2538) oled_data <= 16'b0101000011000001;
        else if (pixel_index == 2539 || pixel_index == 2544) oled_data <= 16'b1011101010001001;
        else if (pixel_index == 2540) oled_data <= 16'b1110110001001101;
        else if (pixel_index == 2541) oled_data <= 16'b1111110100101110;
        else if (pixel_index == 2542) oled_data <= 16'b1111010100101101;
        else if (pixel_index == 2543 || pixel_index == 2635) oled_data <= 16'b1110110010101110;
        else if (pixel_index == 2545) oled_data <= 16'b0101000101000001;
        else if (pixel_index == 2634) oled_data <= 16'b0111101100001011;
        else if (pixel_index == 2636) oled_data <= 16'b1001101111001111;
        else if (pixel_index == 2637) oled_data <= 16'b1110110100101110;
        else if (pixel_index == 2638 || pixel_index == 2735) oled_data <= 16'b1111111010110011;
        else if (pixel_index == 2639) oled_data <= 16'b1000101110001111;
        else if (pixel_index == 2640) oled_data <= 16'b1101110001001101;
        else if (pixel_index == 2641) oled_data <= 16'b1000001011001011;
        else if (pixel_index == 2730) oled_data <= 16'b1110001110001100;
        else if (pixel_index == 2731 || pixel_index == 2736 || (pixel_index >= 2925) && (pixel_index <= 2926)) oled_data <= 16'b1111111001110010;
        else if (pixel_index == 2732) oled_data <= 16'b1111111001110100;
        else if (pixel_index == 2733) oled_data <= 16'b1111010101101110;
        else if (pixel_index == 2734) oled_data <= 16'b1111111001110011;
        else if (pixel_index == 2737) oled_data <= 16'b1101101111001101;
        else if (pixel_index == 2827) oled_data <= 16'b1101110010101110;
        else if (pixel_index == 2828) oled_data <= 16'b1011110011101110;
        else if (pixel_index == 2829) oled_data <= 16'b1010001101001101;
        else if (pixel_index == 2830) oled_data <= 16'b1010001110001100;
        else if (pixel_index == 2831) oled_data <= 16'b1011110010110000;
        else if (pixel_index == 2832) oled_data <= 16'b1110010010101101;
        else if (pixel_index == 2923) oled_data <= 16'b1000000101000110;
        else if (pixel_index == 2924) oled_data <= 16'b1110010001001110;
        else if (pixel_index == 2927) oled_data <= 16'b1110110010101111;
        else if (pixel_index == 2928) oled_data <= 16'b1000000101000111;
        else if (pixel_index == 3018) oled_data <= 16'b0011101110000100;
        else if (pixel_index == 3019) oled_data <= 16'b1010101011000001;
        else if (pixel_index == 3020) oled_data <= 16'b0100110001000001;
        else if (pixel_index == 3021) oled_data <= 16'b1010110000001001;
        else if (pixel_index == 3022) oled_data <= 16'b1100010001001011;
        else if (pixel_index == 3023 || pixel_index == 3210) oled_data <= 16'b0011001111000000;
        else if (pixel_index == 3024 || pixel_index == 3120) oled_data <= 16'b1010001011000001;
        else if (pixel_index == 3025 || pixel_index == 3217 || pixel_index == 3305) oled_data <= 16'b0011001111000010;
        else if (pixel_index == 3114) oled_data <= 16'b0101110101100010;
        else if (pixel_index == 3115) oled_data <= 16'b1010101100000010;
        else if (pixel_index == 3116 || pixel_index == 3119) oled_data <= 16'b0010001100000000;
        else if (pixel_index == 3117) oled_data <= 16'b1101011100101110;
        else if (pixel_index == 3118) oled_data <= 16'b1101111100101100;
        else if (pixel_index == 3121) oled_data <= 16'b0101110100100011;
        else if (pixel_index == 3209) oled_data <= 16'b0011101101000001;
        else if (pixel_index == 3211) oled_data <= 16'b1010110100110001;
        else if (pixel_index == 3212) oled_data <= 16'b0011001101000011;
        else if (pixel_index == 3213) oled_data <= 16'b1100010010100011;
        else if (pixel_index == 3214) oled_data <= 16'b1101110001000001;
        else if (pixel_index == 3215) oled_data <= 16'b0010101101000010;
        else if (pixel_index == 3216) oled_data <= 16'b1011010101110010;
        else if (pixel_index == 3218) oled_data <= 16'b0100110000000010;
        else if (pixel_index == 3304) oled_data <= 16'b0101001110000111;
        else if (pixel_index == 3308) oled_data <= 16'b0011001111000011;
        else if (pixel_index == 3309) oled_data <= 16'b1110111100101011;
        else if (pixel_index == 3310) oled_data <= 16'b1111111101101010;
        //for shop area
        if (pixel_index == 3188 || pixel_index == 3190 || pixel_index == 3192 || pixel_index == 3200 || pixel_index == 3202 || pixel_index == 3204 || pixel_index == 3206 || pixel_index == 3214 || pixel_index == 3216 || pixel_index == 3218 || pixel_index == 3220 || pixel_index == 3228 || pixel_index == 3230 || pixel_index == 3232 || pixel_index == 3234 || pixel_index == 3388 || pixel_index == 3424 || pixel_index == 3476 || pixel_index == 3520 || pixel_index == 3528 || pixel_index == 3668 || pixel_index == 3764 || pixel_index == 3816 || pixel_index == 3861 || ((pixel_index >= 3864) && (pixel_index <= 3865)) || pixel_index == 3868 || pixel_index == 3870 || pixel_index == 3874 || pixel_index == 3880 || pixel_index == 3882 || pixel_index == 3886 || pixel_index == 3891 || ((pixel_index >= 3894) && (pixel_index <= 3895)) || pixel_index == 3901 || ((pixel_index >= 3907) && (pixel_index <= 3908)) || pixel_index == 3911 || pixel_index == 3956 || pixel_index == 3999 || pixel_index == 4008 || pixel_index == 4060 || pixel_index == 4062 || pixel_index == 4148 || pixel_index == 4159 || pixel_index == 4244 || pixel_index == 4258 || ((pixel_index >= 4269) && (pixel_index <= 4270)) || pixel_index == 4273 || pixel_index == 4277 || pixel_index == 4280 || pixel_index == 4282 || pixel_index == 4284 || pixel_index == 4341 || pixel_index == 4343 || pixel_index == 4347 || pixel_index == 4384 || pixel_index == 4386 || pixel_index == 4388 || pixel_index == 4390 || pixel_index == 4392 || pixel_index == 4436 || pixel_index == 4444 || pixel_index == 4447 || pixel_index == 4628 || pixel_index == 4672 || pixel_index == 4680 || pixel_index == 4724 || pixel_index == 4735 || pixel_index == 4776 || pixel_index == 4821 || pixel_index == 4829 || pixel_index == 4867 || pixel_index == 4870 || pixel_index == 4916 || pixel_index == 4924 || pixel_index == 4927 || pixel_index == 5116 || pixel_index == 5149 || pixel_index == 5152 || pixel_index == 5204 || pixel_index == 5301 || pixel_index == 5303 || pixel_index == 5308 || pixel_index == 5341 || pixel_index == 5344 || pixel_index == 5348 || pixel_index == 5396 || pixel_index == 5407 || pixel_index == 5501 || pixel_index == 5534 || pixel_index == 5536 || pixel_index == 5544 || pixel_index == 5588 || pixel_index == 5631 || pixel_index == 5685 || pixel_index == 5692 || pixel_index == 5725 || pixel_index == 5727 || pixel_index == 5730 || pixel_index == 3189 || pixel_index == 3191 || pixel_index == 3201 || pixel_index == 3203 || pixel_index == 3205 || pixel_index == 3215 || pixel_index == 3217 || pixel_index == 3219 || pixel_index == 3229 || pixel_index == 3231 || pixel_index == 3233 || pixel_index == 3772 || pixel_index == 3860 || pixel_index == 3873 || pixel_index == 3888 || pixel_index == 3912 || pixel_index == 4000 || pixel_index == 4192 || pixel_index == 4272 || pixel_index == 4340 || pixel_index == 4342 || pixel_index == 4344 || pixel_index == 4346 || pixel_index == 4385 || pixel_index == 4387 || pixel_index == 4488 || pixel_index == 4820 || pixel_index == 4871 || pixel_index == 5012 || pixel_index == 5020 || pixel_index == 5023 || pixel_index == 5248 || pixel_index == 5300 || pixel_index == 5302 || pixel_index == 5311 || pixel_index == 5349 || pixel_index == 5405 || pixel_index == 5492 || pixel_index == 3193 || pixel_index == 3195 || pixel_index == 3197 || pixel_index == 3199 || pixel_index == 3207 || pixel_index == 3209 || pixel_index == 3211 || pixel_index == 3213 || pixel_index == 3221 || pixel_index == 3223 || pixel_index == 3225 || pixel_index == 3227 || pixel_index == 3235 || pixel_index == 3237 || pixel_index == 3239 || pixel_index == 3284 || pixel_index == 3712 || pixel_index == 3720 || pixel_index == 3876 || pixel_index == 3897 || pixel_index == 3903 || pixel_index == 4156 || pixel_index == 4256 || pixel_index == 4260 || pixel_index == 4263 || pixel_index == 4266 || pixel_index == 4275 || pixel_index == 4296 || pixel_index == 4351 || pixel_index == 4477 || pixel_index == 4574 || pixel_index == 4636 || pixel_index == 4669 || pixel_index == 4823 || pixel_index == 4827 || pixel_index == 4831 || pixel_index == 4865 || pixel_index == 4960 || pixel_index == 5053 || pixel_index == 5064 || pixel_index == 5305 || pixel_index == 5307 || pixel_index == 5346 || pixel_index == 5352 || pixel_index == 5437 || pixel_index == 5440 || pixel_index == 5596 || pixel_index == 5598 || pixel_index == 5629 || pixel_index == 5632 || pixel_index == 5689 || pixel_index == 5693 || pixel_index == 5695 || pixel_index == 5729 || pixel_index == 5732 || pixel_index == 5734 || pixel_index == 3194 || pixel_index == 3196 || pixel_index == 3198 || pixel_index == 3208 || pixel_index == 3210 || pixel_index == 3212 || pixel_index == 3222 || pixel_index == 3224 || pixel_index == 3226 || pixel_index == 3236 || pixel_index == 3238 || pixel_index == 3240 || pixel_index == 3380 || pixel_index == 3432 || pixel_index == 3484 || pixel_index == 3676 || pixel_index == 3808 || pixel_index == 3862 || pixel_index == 3866 || pixel_index == 3869 || pixel_index == 3871 || pixel_index == 3877 || pixel_index == 3879 || pixel_index == 3883 || pixel_index == 3885 || pixel_index == 3889 || pixel_index == 3892 || pixel_index == 3898 || pixel_index == 3900 || pixel_index == 3904 || pixel_index == 3906 || pixel_index == 3909 || pixel_index == 3964 || pixel_index == 4094 || pixel_index == 4104 || pixel_index == 4189 || pixel_index == 4252 || pixel_index == 4257 || pixel_index == 4259 || ((pixel_index >= 4261) && (pixel_index <= 4262)) || ((pixel_index >= 4264) && (pixel_index <= 4265)) || ((pixel_index >= 4267) && (pixel_index <= 4268)) || pixel_index == 4271 || pixel_index == 4274 || pixel_index == 4276 || ((pixel_index >= 4278) && (pixel_index <= 4279)) || pixel_index == 4281 || pixel_index == 4283 || pixel_index == 4288 || pixel_index == 4349 || pixel_index == 4381 || pixel_index == 4391 || pixel_index == 4446 || pixel_index == 4479 || pixel_index == 4540 || pixel_index == 4576 || pixel_index == 4639 || pixel_index == 4765 || pixel_index == 4824 || pixel_index == 4826 || pixel_index == 4828 || pixel_index == 4864 || pixel_index == 4866 || pixel_index == 4869 || pixel_index == 4957 || pixel_index == 4959 || pixel_index == 4968 || pixel_index == 5056 || pixel_index == 5119 || pixel_index == 5160 || pixel_index == 5304 || pixel_index == 5306 || pixel_index == 5351 || pixel_index == 5439 || pixel_index == 5448 || pixel_index == 5500 || pixel_index == 5502 || pixel_index == 5599 || pixel_index == 5630 || pixel_index == 5640 || pixel_index == 5687 || pixel_index == 5690 || pixel_index == 5694 || pixel_index == 5731 || pixel_index == 5733 || pixel_index == 5735) 
        oled_data <= 16'b1000001110010101;    
        else if (((pixel_index >= 3285) && (pixel_index <= 3288)) || ((pixel_index >= 3290) && (pixel_index <= 3291)) || ((pixel_index >= 3293) && (pixel_index <= 3295)) || ((pixel_index >= 3297) && (pixel_index <= 3302)) || ((pixel_index >= 3304) && (pixel_index <= 3309)) || ((pixel_index >= 3311) && (pixel_index <= 3316)) || ((pixel_index >= 3318) && (pixel_index <= 3323)) || ((pixel_index >= 3325) && (pixel_index <= 3327)) || ((pixel_index >= 3329) && (pixel_index <= 3330)) || ((pixel_index >= 3332) && (pixel_index <= 3335)) || pixel_index == 3381 || pixel_index == 3383 || ((pixel_index >= 3385) && (pixel_index <= 3386)) || ((pixel_index >= 3390) && (pixel_index <= 3392)) || pixel_index == 3394 || pixel_index == 3396 || ((pixel_index >= 3399) && (pixel_index <= 3400)) || ((pixel_index >= 3403) && (pixel_index <= 3404)) || ((pixel_index >= 3406) && (pixel_index <= 3408)) || ((pixel_index >= 3410) && (pixel_index <= 3411)) || ((pixel_index >= 3414) && (pixel_index <= 3415)) || pixel_index == 3418 || pixel_index == 3420 || pixel_index == 3422 || ((pixel_index >= 3426) && (pixel_index <= 3428)) || pixel_index == 3431 || ((pixel_index >= 3477) && (pixel_index <= 3478)) || pixel_index == 3480 || ((pixel_index >= 3482) && (pixel_index <= 3483)) || ((pixel_index >= 3485) && (pixel_index <= 3486)) || pixel_index == 3488 || ((pixel_index >= 3490) && (pixel_index <= 3492)) || ((pixel_index >= 3494) && (pixel_index <= 3498)) || ((pixel_index >= 3500) && (pixel_index <= 3505)) || ((pixel_index >= 3507) && (pixel_index <= 3512)) || ((pixel_index >= 3514) && (pixel_index <= 3517)) || pixel_index == 3519 || ((pixel_index >= 3521) && (pixel_index <= 3522)) || ((pixel_index >= 3524) && (pixel_index <= 3527)) || ((pixel_index >= 3573) && (pixel_index <= 3574)) || ((pixel_index >= 3576) && (pixel_index <= 3579)) || ((pixel_index >= 3581) && (pixel_index <= 3586)) || ((pixel_index >= 3588) && (pixel_index <= 3590)) || ((pixel_index >= 3593) && (pixel_index <= 3594)) || ((pixel_index >= 3596) && (pixel_index <= 3597)) || ((pixel_index >= 3601) && (pixel_index <= 3602)) || pixel_index == 3604 || pixel_index == 3606 || ((pixel_index >= 3608) && (pixel_index <= 3610)) || ((pixel_index >= 3613) && (pixel_index <= 3615)) || ((pixel_index >= 3617) && (pixel_index <= 3618)) || pixel_index == 3621 || pixel_index == 3623 || pixel_index == 3670 || ((pixel_index >= 3672) && (pixel_index <= 3673)) || pixel_index == 3675 || pixel_index == 3677 || pixel_index == 3679 || ((pixel_index >= 3681) && (pixel_index <= 3684)) || ((pixel_index >= 3686) && (pixel_index <= 3688)) || pixel_index == 3690 || ((pixel_index >= 3692) && (pixel_index <= 3697)) || ((pixel_index >= 3699) && (pixel_index <= 3704)) || ((pixel_index >= 3706) && (pixel_index <= 3709)) || pixel_index == 3711 || ((pixel_index >= 3714) && (pixel_index <= 3717)) || pixel_index == 3719 || ((pixel_index >= 3765) && (pixel_index <= 3768)) || ((pixel_index >= 3770) && (pixel_index <= 3771)) || ((pixel_index >= 3773) && (pixel_index <= 3776)) || ((pixel_index >= 3779) && (pixel_index <= 3780)) || pixel_index == 3782 || pixel_index == 3784 || ((pixel_index >= 3786) && (pixel_index <= 3788)) || pixel_index == 3790 || pixel_index == 3792 || pixel_index == 3794 || pixel_index == 3796 || pixel_index == 3798 || pixel_index == 3800 || pixel_index == 3802 || ((pixel_index >= 3804) && (pixel_index <= 3807)) || ((pixel_index >= 3809) && (pixel_index <= 3810)) || pixel_index == 3812 || pixel_index == 3814 || ((pixel_index >= 3957) && (pixel_index <= 3960)) || ((pixel_index >= 3962) && (pixel_index <= 3963)) || ((pixel_index >= 3966) && (pixel_index <= 3967)) || ((pixel_index >= 3969) && (pixel_index <= 3981)) || ((pixel_index >= 3983) && (pixel_index <= 3989)) || ((pixel_index >= 3991) && (pixel_index <= 3996)) || pixel_index == 3998 || ((pixel_index >= 4001) && (pixel_index <= 4006)) || pixel_index == 4053 || ((pixel_index >= 4063) && (pixel_index <= 4065)) || pixel_index == 4067 || pixel_index == 4069 || pixel_index == 4071 || pixel_index == 4073 || pixel_index == 4075 || ((pixel_index >= 4077) && (pixel_index <= 4080)) || pixel_index == 4082 || ((pixel_index >= 4084) && (pixel_index <= 4086)) || pixel_index == 4088 || pixel_index == 4090 || ((pixel_index >= 4092) && (pixel_index <= 4093)) || pixel_index == 4095 || pixel_index == 4103 || pixel_index == 4157 || ((pixel_index >= 4161) && (pixel_index <= 4163)) || ((pixel_index >= 4165) && (pixel_index <= 4166)) || ((pixel_index >= 4168) && (pixel_index <= 4169)) || ((pixel_index >= 4171) && (pixel_index <= 4173)) || pixel_index == 4175 || ((pixel_index >= 4177) && (pixel_index <= 4178)) || ((pixel_index >= 4181) && (pixel_index <= 4188)) || ((pixel_index >= 4190) && (pixel_index <= 4191)) || pixel_index == 4199 || pixel_index == 4245 || ((pixel_index >= 4253) && (pixel_index <= 4254)) || ((pixel_index >= 4286) && (pixel_index <= 4287)) || pixel_index == 4350 || ((pixel_index >= 4382) && (pixel_index <= 4383)) || ((pixel_index >= 4437) && (pixel_index <= 4442)) || pixel_index == 4445 || ((pixel_index >= 4481) && (pixel_index <= 4487)) || pixel_index == 4533 || ((pixel_index >= 4541) && (pixel_index <= 4542)) || pixel_index == 4575 || pixel_index == 4583 || ((pixel_index >= 4637) && (pixel_index <= 4638)) || ((pixel_index >= 4670) && (pixel_index <= 4671)) || pixel_index == 4679 || pixel_index == 4725 || ((pixel_index >= 4733) && (pixel_index <= 4734)) || pixel_index == 4766 || ((pixel_index >= 4862) && (pixel_index <= 4863)) || ((pixel_index >= 4917) && (pixel_index <= 4920)) || ((pixel_index >= 4922) && (pixel_index <= 4923)) || pixel_index == 4925 || pixel_index == 4958 || ((pixel_index >= 4961) && (pixel_index <= 4962)) || ((pixel_index >= 4964) && (pixel_index <= 4967)) || pixel_index == 5013 || ((pixel_index >= 5021) && (pixel_index <= 5022)) || pixel_index == 5055 || pixel_index == 5063 || ((pixel_index >= 5117) && (pixel_index <= 5118)) || ((pixel_index >= 5150) && (pixel_index <= 5151)) || pixel_index == 5159 || pixel_index == 5205 || ((pixel_index >= 5213) && (pixel_index <= 5214)) || ((pixel_index >= 5246) && (pixel_index <= 5247)) || pixel_index == 5255 || pixel_index == 5310 || pixel_index == 5343 || ((pixel_index >= 5397) && (pixel_index <= 5402)) || pixel_index == 5406 || pixel_index == 5438 || ((pixel_index >= 5441) && (pixel_index <= 5447)) || pixel_index == 5493 || pixel_index == 5495 || ((pixel_index >= 5497) && (pixel_index <= 5499)) || ((pixel_index >= 5538) && (pixel_index <= 5539)) || pixel_index == 5541 || pixel_index == 5543 || ((pixel_index >= 5589) && (pixel_index <= 5590)) || pixel_index == 5592 || pixel_index == 5595 
        || pixel_index == 5633 || ((pixel_index >= 5635) && (pixel_index <= 5636)) || (pixel_index >= 5638) && (pixel_index <= 5639) || pixel_index == 3289 || pixel_index == 3296 || pixel_index == 3303 || pixel_index == 3310 || pixel_index == 3317 || pixel_index == 3324 || pixel_index == 3331 || pixel_index == 3382 || pixel_index == 3387 || pixel_index == 3389 || pixel_index == 3395 || pixel_index == 3398 || pixel_index == 3402 || pixel_index == 3412 || pixel_index == 3416 || pixel_index == 3419 || pixel_index == 3423 || pixel_index == 3425 || pixel_index == 3430 || pixel_index == 3479 || pixel_index == 3481 || pixel_index == 3489 || pixel_index == 3493 || pixel_index == 3499 || pixel_index == 3506 || pixel_index == 3513 || pixel_index == 3518 || pixel_index == 3523 || pixel_index == 3592 || pixel_index == 3598 || pixel_index == 3600 || pixel_index == 3605 || pixel_index == 3612 || pixel_index == 3620 || pixel_index == 3622 || pixel_index == 3669 || pixel_index == 3671 || pixel_index == 3678 || pixel_index == 3680 || pixel_index == 3685 || pixel_index == 3689 || pixel_index == 3691 || pixel_index == 3698 || pixel_index == 3705 || pixel_index == 3713 || pixel_index == 3769 || pixel_index == 3778 || pixel_index == 3783 || pixel_index == 3791 || pixel_index == 3795 || pixel_index == 3799 || pixel_index == 3803 || pixel_index == 3811 || pixel_index == 3813 || pixel_index == 3815 || pixel_index == 3961 || pixel_index == 3968 || pixel_index == 3982 || pixel_index == 3990 || pixel_index == 3997 || pixel_index == 4007 || pixel_index == 4061 || pixel_index == 4066 || pixel_index == 4068 || pixel_index == 4070 || pixel_index == 4072 || pixel_index == 4074 || pixel_index == 4076 || pixel_index == 4081 || pixel_index == 4083 || pixel_index == 4087 || pixel_index == 4089 || pixel_index == 4091 || pixel_index == 4149 || pixel_index == 4158 || pixel_index == 4160 || pixel_index == 4174 || pixel_index == 4180 || pixel_index == 4295 || pixel_index == 4443 || pixel_index == 4478 || pixel_index == 4629 || pixel_index == 4767 || pixel_index == 4775 || pixel_index == 4830 || pixel_index == 4921 || pixel_index == 4963 || pixel_index == 5109 || pixel_index == 5309 || pixel_index == 5342 || pixel_index == 5403 || pixel_index == 5494 || pixel_index == 5496 || pixel_index == 5537 || pixel_index == 5540 || pixel_index == 5542 || pixel_index == 5593
        || pixel_index == 3384 || pixel_index == 3393 || pixel_index == 3397 || pixel_index == 3401 || pixel_index == 3413 || pixel_index == 3417 || pixel_index == 3421 || pixel_index == 3429 || pixel_index == 3575 || pixel_index == 3591 || pixel_index == 3595 || pixel_index == 3599 || pixel_index == 3603 || pixel_index == 3611 || pixel_index == 3619 || pixel_index == 3718 || pixel_index == 3777 || pixel_index == 3781 || pixel_index == 3785 || pixel_index == 3793 || pixel_index == 3801 || pixel_index == 4164 || pixel_index == 4167 || pixel_index == 4170 || pixel_index == 4176 || pixel_index == 4179 || pixel_index == 5591 || pixel_index == 5594 || pixel_index == 5637
        || pixel_index == 3405 || pixel_index == 3409 || pixel_index == 3487 || pixel_index == 3587 || pixel_index == 3607 || pixel_index == 3674 || pixel_index == 3710 || pixel_index == 3789 || pixel_index == 3797 || pixel_index == 5634) oled_data <= 16'b1110011011111110;
        else if (pixel_index == 3292 || pixel_index == 3328 || pixel_index == 3336 || pixel_index == 3580 || pixel_index == 3872 || pixel_index == 3887 || pixel_index == 3899 || pixel_index == 3905 || pixel_index == 4096 || pixel_index == 4200 || pixel_index == 4345 || pixel_index == 4768 || pixel_index == 4825 || pixel_index == 4872 || pixel_index == 5108 || pixel_index == 5215 || pixel_index == 5350 || pixel_index == 5404 || pixel_index == 5688
        || pixel_index == 3572 || pixel_index == 3881 || pixel_index == 4052 || pixel_index == 4389 || pixel_index == 4532 || pixel_index == 4543 || pixel_index == 4868 || pixel_index == 5245 || pixel_index == 5535 || pixel_index == 5686 || pixel_index == 5691 || pixel_index == 5726
        || pixel_index == 3616 || pixel_index == 3624 || pixel_index == 3863 || pixel_index == 3875 || pixel_index == 3896 || pixel_index == 3902 || pixel_index == 4255 || pixel_index == 4573 || pixel_index == 4584 || pixel_index == 4732 || pixel_index == 4822 || pixel_index == 4926 || pixel_index == 5054 || pixel_index == 5212 || pixel_index == 5256 || pixel_index == 5345 || pixel_index == 5347 || pixel_index == 5533 || pixel_index == 5597 || pixel_index == 5684 || pixel_index == 5728 || pixel_index == 3867 || pixel_index == 3878 || pixel_index == 3884 || pixel_index == 3890 || pixel_index == 3893 || pixel_index == 3910 || pixel_index == 3965 || pixel_index == 4285 || pixel_index == 4348 || pixel_index == 4480 || pixel_index == 4861 || pixel_index == 5503 || pixel_index == 5736) oled_data <= 16'b1000001111010101;
        //oled_data <= 16'b1000001111010100;
        else if (  ((pixel_index >= 4150) && (pixel_index <= 4155)) || ((pixel_index >= 4054) && (pixel_index <= 4059)) || ((pixel_index >= 4246) && (pixel_index <= 4251))) oled_data <= 16'b11111_101000_10110; // Pink
        else if ( ((pixel_index >= 4193) && (pixel_index <= 4198)) || ((pixel_index >= 4097) && (pixel_index <= 4102))||  (pixel_index >= 4289) && (pixel_index <= 4294)) oled_data <= 16'b11111_101000_10110; // Pink
        else if (((pixel_index >= 4534) && (pixel_index <= 4539)) || ((pixel_index >= 4577) && (pixel_index <= 4582)) || ((pixel_index >= 4630) && (pixel_index <= 4635)) || ((pixel_index >= 4673) && (pixel_index <= 4678)) || ((pixel_index >= 4726) && (pixel_index <= 4731)) || (pixel_index >= 4769) && (pixel_index <= 4774)) oled_data <= 16'b1111111110100000;
        else if (((pixel_index >= 5014) && (pixel_index <= 5019)) || ((pixel_index >= 5057) && (pixel_index <= 5062)) || ((pixel_index >= 5110) && (pixel_index <= 5115)) || ((pixel_index >= 5153) && (pixel_index <= 5158)) || ((pixel_index >= 5206) && (pixel_index <= 5211)) || (pixel_index >= 5249) && (pixel_index <= 5254)) oled_data <= 16'b1111110000000000;
        
        //shelf
        if((x_pos <= 6 || x_pos >= 89  )&& y_pos >= 33 && pixel_index != 3173 && pixel_index != 3174 && pixel_index != 3270 && pixel_index != 3258 && pixel_index != 3257 && pixel_index != 3353) begin
        oled_data <= 16'b1000001110010101;   
        if(((x_pos >= 0 && x_pos <= 2) || x_pos == 4 || x_pos == 5 || (x_pos >= 93 && x_pos <= 95) || x_pos == 90 || x_pos == 91) && (y_pos >= 34 && y_pos <= 62) && pixel_index != 3354 && pixel_index != 3269 ) 
        oled_data <= 16'b1110011011111110;
        end
        
        //watercan
        if (pixel_index == 3641 || pixel_index == 3739 || pixel_index == 3833 || pixel_index == 3931 || pixel_index == 4409 || pixel_index == 4507 || pixel_index == 4601 || pixel_index == 4794 || pixel_index == 5177 || pixel_index == 5369 || pixel_index == 5467 || pixel_index == 3737 || pixel_index == 4505 || pixel_index == 5273 || pixel_index == 3834 || pixel_index == 4026 || pixel_index == 4699 || pixel_index == 5275 || pixel_index == 5466 || pixel_index == 5563 
        || pixel_index == 3930 || pixel_index == 5370 || pixel_index == 4027 || pixel_index == 4698 || pixel_index == 4795 || pixel_index == 5562 || pixel_index == 4602)
         oled_data <= 16'b11111_000000_01001;
         
        //fishing rod
        if (pixel_index == 2982 || pixel_index == 3078 || pixel_index == 3174 || ((pixel_index >= 3269) && (pixel_index <= 3270)) || ((pixel_index >= 3365) && (pixel_index <= 3366)) || pixel_index == 3461 || ((pixel_index >= 3556) && (pixel_index <= 3557)) || ((pixel_index >= 3652) && (pixel_index <= 3653)) || pixel_index == 3748 || pixel_index == 3844 || pixel_index == 3940 || pixel_index == 4038 || pixel_index == 4134 || ((pixel_index >= 4229) && (pixel_index <= 4230)) || ((pixel_index >= 4325) && (pixel_index <= 4326)) || pixel_index == 4421 || ((pixel_index >= 4516) && (pixel_index <= 4517)) || ((pixel_index >= 4612) && (pixel_index <= 4613)) || pixel_index == 4708 || pixel_index == 4804 || pixel_index == 4900 || pixel_index == 4998 || pixel_index == 5094 || ((pixel_index >= 5189) && (pixel_index <= 5190)) || ((pixel_index >= 5285) && (pixel_index <= 5286)) || pixel_index == 5381 || ((pixel_index >= 5476) && (pixel_index <= 5477)) || ((pixel_index >= 5572) && (pixel_index <= 5573)) || pixel_index == 5668 || pixel_index == 5764 || pixel_index == 5860) 
        begin
        if (rod_num == 2'b01)
         oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
         else if (rod_num == 2'b10)
         oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
        end
       
        
        if(char_output != 16'd0)
            oled_data <= char_output;
            
            
    //sell_mode        
    if ((x_offset >= 39 && x_offset <= 46)&& (y_offset >= 29 && y_offset <= 35) && btnC == 1)
        sell_mode <= 1;
    if(sell_mode == 1)begin
        if(btnL == 1)begin
        end
        if(btnR == 1)begin
            sell_mode <= 0;
        end
    end
    //chat
    if (((x_offset >= 31 && x_offset <= 34) || (x_offset >= 51 && x_offset <= 54)) && (y_offset >= 29 && y_offset <= 45)) begin
        if (((pixel_index >= 824) && (pixel_index <= 841)) || 
            ((pixel_index >= 919) && (pixel_index <= 938)) || 
            ((pixel_index >= 1014) && (pixel_index <= 1034)) || 
            ((pixel_index >= 1110) && (pixel_index <= 1116)) || 
            ((pixel_index >= 1124) && (pixel_index <= 1130)) || 
            ((pixel_index >= 1206) && (pixel_index <= 1212)) || 
            ((pixel_index >= 1220) && (pixel_index <= 1226)) || 
            ((pixel_index >= 1302) && (pixel_index <= 1308)) || 
            ((pixel_index >= 1316) && (pixel_index <= 1322)) || 
            ((pixel_index >= 1398) && (pixel_index <= 1404)) || 
            ((pixel_index >= 1412) && (pixel_index <= 1418)) || 
            ((pixel_index >= 1494) && (pixel_index <= 1500)) || 
            ((pixel_index >= 1508) && (pixel_index <= 1514)) || 
            ((pixel_index >= 1590) && (pixel_index <= 1596)) || 
            ((pixel_index >= 1604) && (pixel_index <= 1610)) || 
            ((pixel_index >= 1686) && (pixel_index <= 1692)) || 
            ((pixel_index >= 1700) && (pixel_index <= 1706)) || 
            ((pixel_index >= 1781) && (pixel_index <= 1802)) || 
            ((pixel_index >= 1876) && (pixel_index <= 1898)) || 
            ((pixel_index >= 1971) && (pixel_index <= 1992)) || 
            (pixel_index == 2072) || 
            (pixel_index == 2454)) 
        begin
            oled_data <= 16'b1111111111111111;
        end
    
    if ((x_pos >= 61 && x_pos <= 67) && (y_pos >= 11 && y_pos <= 17)) begin
            oled_data <= 16'b1111111111111111;
            if (y_offset >= 29 && y_offset <= 35) begin
                if(pixel_index == 1215 || pixel_index == 1599 || pixel_index == 1410)
                oled_data <= 16'b11111_101000_10110;   
                if(pixel_index == 1214 || pixel_index == 1598 || pixel_index == 1409
                || pixel_index == 1216 || pixel_index == 1600 || pixel_index == 1411
                || pixel_index ==  1119 || pixel_index == 1314 || pixel_index == 1503
                || pixel_index == 1311 || pixel_index == 1506 || pixel_index == 1695)
                oled_data <= 16'b10011_010100_01011;
                item_code <= 3'b001;
            end
            if (y_offset > 35 && y_offset <= 40) begin
                if (pixel_index == 1022 || ((pixel_index >= 1117) && (pixel_index <= 1118)) || ((pixel_index >= 1120) && (pixel_index <= 1121)) || pixel_index == 1219 || pixel_index == 1314 || ((pixel_index >= 1405) && (pixel_index <= 1406)) || pixel_index == 1409 || ((pixel_index >= 1504) && (pixel_index <= 1505)) || pixel_index == 1598 || pixel_index == 1603 || pixel_index == 1693 || pixel_index == 1699 || pixel_index == 1216 || pixel_index == 1310 || pixel_index == 1315 || pixel_index == 1694 || pixel_index == 1698) 
                oled_data <= 16'b1111111110100000;
                item_code <= 3'b010;
            end
            if (y_offset > 40 && y_offset <= 45) begin
                if (pixel_index == 1022 || ((pixel_index >= 1117) && (pixel_index <= 1118)) || ((pixel_index >= 1120) && (pixel_index <= 1121)) || pixel_index == 1219 || pixel_index == 1314 || ((pixel_index >= 1405) && (pixel_index <= 1406)) || pixel_index == 1409 || ((pixel_index >= 1504) && (pixel_index <= 1505)) || pixel_index == 1598 || pixel_index == 1603 || pixel_index == 1693 || pixel_index == 1699 || pixel_index == 1216 || pixel_index == 1310 || pixel_index == 1315 || pixel_index == 1694 || pixel_index == 1698) 
                oled_data <= 16'b1111110000000000;
                item_code <= 3'b011;
            end
        end
    
    end
    end
    
    endmodule */
    
    
    module D_Milestone(
        input [12:0] pixel_index,   // Pixel index (0-8191 for 96x64 screen)
        input start_task,
        input [6:0] x,              // x-coordinate (0-95)
        input [5:0] y,              // y-coordinate (0-63)
        input basys_clock,
        input display_clock,
        input [7:0] selector,
        input signed [1:0] rod_num, 
        output reg signed [1:0] rod_num_out,   
        output reg sell_mode = 0,   
        output reg buy_mode = 0,
        input btnU, btnD, btnC, btnL, btnR,
        output reg [15:0] oled_data,
        input signed [16:0] current,
        output reg signed [16:0] current_out = 15'd1000,
        output reg item_code = 0,
         input signed [4:0] carp_count,
         output reg signed [4:0] carp_count_out = 5,
         input signed [4:0] bluetang_count,
         output reg signed [4:0] bluetang_count_out = 5,
         input signed [4:0] koi_count,
         output reg signed [4:0] koi_count_out = 5,
         input signed [4:0] pumpkin_count,
         output reg signed [4:0] pumpkin_count_out = 5,
         input signed [4:0] wheat_count,
         output reg signed [4:0] wheat_count_out = 5,
         input signed [4:0] pumpkinseed_count,
         output reg signed [4:0] pumpkinseed_count_out = 5,
         input signed [4:0] wheatseed_count,
         output reg signed [4:0] wheatseed_count_out = 5,
         input signed [4:0] bait_count ,
         output reg signed [4:0] bait_count_out = 5,
         
         input shop,
         output reg gobackFarm = 0
    );
    
    initial begin
        rod_num_out = 2'b01;  // Initial value for rod_num_out
    end
    
    // Calculate x and y positions based on pixel index
    wire [6:0] x_pos = pixel_index % 96; // x-coordinate
    wire [5:0] y_pos = pixel_index / 96; // y-coordinate
    
    
    // Offsets for moving the character
    reg [6:0] x_offset = 41; // Set this value to move horizontally
    reg [5:0] y_offset = 49; // Set this value to move vertically
    wire clk20;
    reg facing_up = 1;
    reg facing_down = 0;
    reg facing_left = 0;
    reg facing_right = 0;
    wire [15:0] char_output;
    reg state = 0;
    
    
    
    flexible_clock First_CLK(.basys_clock(basys_clock), .count(2499_999), .SLOW_CLOCK(clk20));
    
    my_char character(
        .basys_clk(basys_clock),
        .x(x_pos),
        .y(y_pos),
        .char_x(x_offset), 
        .char_y(y_offset),
        .facing_down(facing_down),
        .facing_up(facing_up),
        .facing_left(facing_left),
        .facing_right(facing_right),
        .oled_data(char_output)
        );
    
    assign right_logic = ((y_offset <= 49 && y_offset >= 45 && x_offset >= 5 && x_offset < 81) || (x_offset >= 5 && x_offset < 12) || (x_offset >= 71 && x_offset < 81)||(x_offset >= 31 && x_offset < 54));
    assign left_logic =  ((y_offset <= 49 && y_offset >= 45 && x_offset > 5 && x_offset <= 81) || (x_offset > 5 && x_offset <= 12) || (x_offset > 71 && x_offset <= 81)||(x_offset > 31 && x_offset <= 54));
    assign down_logic =  ((y_offset < 49 && y_offset >= 45 && x_offset >= 5 && x_offset <= 81)|| (((x_offset >= 5 && x_offset <= 12) || (x_offset >= 71 && x_offset <= 81)||(x_offset >= 31 && x_offset <= 54)) && (y_offset < 49 && y_offset >= 31)));
    assign up_logic =  ((y_offset <= 49 && y_offset > 45 && x_offset >= 5 && x_offset <= 81)|| (((x_offset >= 5 && x_offset <= 12) || (x_offset >= 71 && x_offset <= 81)||(x_offset >= 31 && x_offset <= 54)) && (y_offset <= 49 && y_offset > 31)));
    
    always @(posedge clk20) begin
    if (shop == 0) gobackFarm <= 0;
    if (btnC &&  x_offset > 30 && x_offset < 50 && y_offset > 48) gobackFarm <= 1;
        if(buy_mode == 0 && sell_mode == 0 && start_task == 1)begin
        if(right_logic && btnR == 1)begin
            x_offset <= x_offset + 1;  
            facing_up <= 0;
            facing_down <= 0;
            facing_left <= 0;
            facing_right <= 1; 
            end 
        if(left_logic && btnL == 1)begin
            x_offset <= x_offset - 1; 
            facing_up <= 0;
            facing_down <= 0;
            facing_left <= 1;
            facing_right <= 0;   
            end
        if(down_logic && btnD == 1)begin
            y_offset <= y_offset + 1;  
            facing_up <= 0;
            facing_down <= 1;
            facing_left <= 0;
            facing_right <= 0;     
            end 
        if(up_logic && btnU == 1)begin
            y_offset <= y_offset - 1;
            facing_up <= 1;
            facing_down <= 0;
            facing_left <= 0;
            facing_right <= 0;  
            end
        end
        else if(start_task == 0)begin
        x_offset <= 41;
        y_offset <= 49;
        end
    end
    
    
    
    
    
    always @(posedge display_clock) begin
            if (pixel_index >= 2688 && pixel_index <= 6143) begin
                //for floor
                oled_data <= 16'b1110110010100111; 
            //for top 
            end else begin
               if ((x_pos == 0 || x_pos == 8 || x_pos == 9 || x_pos == 17 || 
                         x_pos == 18 || x_pos == 26 || x_pos == 27 || x_pos == 35 || 
                         x_pos == 36 || x_pos == 44 || x_pos == 45 || x_pos == 53 || 
                         x_pos == 54 || x_pos == 62 || x_pos == 63 || x_pos == 71 || 
                         x_pos == 72 || x_pos == 80 || x_pos == 81 || x_pos == 89 || 
                         x_pos == 90 || y_pos == 0 || y_pos == 13 || y_pos == 27)) begin
                        oled_data <= 16'b0011100000000100; // Set the desired color
                    end
                    else if ((y_pos >= 1 && y_pos <= 12) || (y_pos >= 14 && y_pos <= 26)) begin
                        if ((x_pos == 1 || x_pos == 3 || x_pos == 5 || x_pos == 7 || 
                             x_pos == 10 || x_pos == 12 || x_pos == 14 || x_pos == 16 || 
                             x_pos == 19 || x_pos == 21 || x_pos == 23 || x_pos == 25 ||
                             x_pos == 28 || x_pos == 30 || x_pos == 32 || x_pos == 34 || 
                             x_pos == 37 || x_pos == 39 || x_pos == 41 || x_pos == 43 || 
                             x_pos == 46 || x_pos == 48 || x_pos == 50 || x_pos == 52 || 
                             x_pos == 55 || x_pos == 57 || x_pos == 59 || x_pos == 61 || 
                             x_pos == 64 || x_pos == 66 || x_pos == 68 || x_pos == 70 || 
                             x_pos == 73 || x_pos == 75 || x_pos == 77 || x_pos == 79 || 
                             x_pos == 82 || x_pos == 84 || x_pos == 86 || x_pos == 88 || 
                             x_pos == 91 || x_pos == 93 || x_pos == 95)) begin
                            oled_data <= 16'b0110000001000001; // Second color pattern
                        end
                        else if ((x_pos == 2 || x_pos == 4 || x_pos == 6 || x_pos == 11 || 
                                  x_pos == 13 || x_pos == 15 || x_pos == 20 || x_pos == 22 || 
                                  x_pos == 24 || x_pos == 29 || x_pos == 31 || x_pos == 33 || 
                                  x_pos == 38 || x_pos == 40 || x_pos == 42 || x_pos == 47 || 
                                  x_pos == 49 || x_pos == 51 || x_pos == 56 || x_pos == 58 || 
                                  x_pos == 60 || x_pos == 65 || x_pos == 67 || x_pos == 69 || 
                                  x_pos == 74 || x_pos == 76 || x_pos == 78 || x_pos == 83 || 
                                  x_pos == 85 || x_pos == 87 || x_pos == 92 || x_pos == 94)) begin
                                  oled_data <= 16'b0111000100000101; // Third color pattern
                                  end
                    end
                    else
                        oled_data <= 0;
        end
        
            //shopekeeper
            if (((pixel_index >= 2060) && (pixel_index <= 2063)) || ((pixel_index >= 2153) && (pixel_index <= 2156)) || ((pixel_index >= 2159) && (pixel_index <= 2161)) || pixel_index == 2249 || pixel_index == 2258 || pixel_index == 2345 || pixel_index == 2354 || pixel_index == 2441 || pixel_index == 2450 || pixel_index == 2537 || pixel_index == 2546 || pixel_index == 2633 || pixel_index == 2642 || pixel_index == 2729 || pixel_index == 2738 || pixel_index == 2826 || ((pixel_index >= 2833) && (pixel_index <= 2834)) || pixel_index == 2922 || pixel_index == 2929 || pixel_index == 3017 || pixel_index == 3026 || pixel_index == 3113 || pixel_index == 3122 || pixel_index == 3208 || pixel_index == 3219 || pixel_index == 3303) 
            oled_data <= 16'b1111111111111111;
            else if (pixel_index == 2157) oled_data <= 16'b0101100100000001;
            else if (pixel_index == 2158) oled_data <= 16'b0101000100000001;
            else if (pixel_index == 2250) oled_data <= 16'b0100100111000101;
            else if (pixel_index == 2251) oled_data <= 16'b0110100101000010;
            else if (pixel_index == 2252) oled_data <= 16'b0111000110000010;
            else if (pixel_index == 2253) oled_data <= 16'b1000100110000000;
            else if (pixel_index == 2254) oled_data <= 16'b1000100110000001;
            else if (pixel_index == 2255) oled_data <= 16'b0111100110000001;
            else if (pixel_index == 2256) oled_data <= 16'b0110100110000010;
            else if (pixel_index == 2257) oled_data <= 16'b0100100110000100;
            else if (pixel_index == 2346) oled_data <= 16'b0110100100000001;
            else if (pixel_index == 2347) oled_data <= 16'b0110100101000001;
            else if (pixel_index == 2348) oled_data <= 16'b1011101011000011;
            else if (pixel_index == 2349) oled_data <= 16'b1101101101000011;
            else if (pixel_index == 2350) oled_data <= 16'b1101001101000100;
            else if (pixel_index == 2351) oled_data <= 16'b1100101100000011;
            else if (pixel_index == 2352) oled_data <= 16'b0111000100000000;
            else if (pixel_index == 2353) oled_data <= 16'b0110000101000001;
            else if (pixel_index == 2442) oled_data <= 16'b1000000111000011;
            else if (pixel_index == 2443) oled_data <= 16'b1000000110000001;
            else if (pixel_index == 2444) oled_data <= 16'b1000100111000010;
            else if (pixel_index == 2445) oled_data <= 16'b1011001011001000;
            else if (pixel_index == 2446) oled_data <= 16'b1011001100001001;
            else if (pixel_index == 2447) oled_data <= 16'b1000100111000100;
            else if (pixel_index == 2448) oled_data <= 16'b0111100101000001;
            else if (pixel_index == 2449) oled_data <= 16'b1000000111000100;
            else if (pixel_index == 2538) oled_data <= 16'b0101000011000001;
            else if (pixel_index == 2539 || pixel_index == 2544) oled_data <= 16'b1011101010001001;
            else if (pixel_index == 2540) oled_data <= 16'b1110110001001101;
            else if (pixel_index == 2541) oled_data <= 16'b1111110100101110;
            else if (pixel_index == 2542) oled_data <= 16'b1111010100101101;
            else if (pixel_index == 2543 || pixel_index == 2635) oled_data <= 16'b1110110010101110;
            else if (pixel_index == 2545) oled_data <= 16'b0101000101000001;
            else if (pixel_index == 2634) oled_data <= 16'b0111101100001011;
            else if (pixel_index == 2636) oled_data <= 16'b1001101111001111;
            else if (pixel_index == 2637) oled_data <= 16'b1110110100101110;
            else if (pixel_index == 2638 || pixel_index == 2735) oled_data <= 16'b1111111010110011;
            else if (pixel_index == 2639) oled_data <= 16'b1000101110001111;
            else if (pixel_index == 2640) oled_data <= 16'b1101110001001101;
            else if (pixel_index == 2641) oled_data <= 16'b1000001011001011;
            else if (pixel_index == 2730) oled_data <= 16'b1110001110001100;
            else if (pixel_index == 2731 || pixel_index == 2736 || (pixel_index >= 2925) && (pixel_index <= 2926)) oled_data <= 16'b1111111001110010;
            else if (pixel_index == 2732) oled_data <= 16'b1111111001110100;
            else if (pixel_index == 2733) oled_data <= 16'b1111010101101110;
            else if (pixel_index == 2734) oled_data <= 16'b1111111001110011;
            else if (pixel_index == 2737) oled_data <= 16'b1101101111001101;
            else if (pixel_index == 2827) oled_data <= 16'b1101110010101110;
            else if (pixel_index == 2828) oled_data <= 16'b1011110011101110;
            else if (pixel_index == 2829) oled_data <= 16'b1010001101001101;
            else if (pixel_index == 2830) oled_data <= 16'b1010001110001100;
            else if (pixel_index == 2831) oled_data <= 16'b1011110010110000;
            else if (pixel_index == 2832) oled_data <= 16'b1110010010101101;
            else if (pixel_index == 2923) oled_data <= 16'b1000000101000110;
            else if (pixel_index == 2924) oled_data <= 16'b1110010001001110;
            else if (pixel_index == 2927) oled_data <= 16'b1110110010101111;
            else if (pixel_index == 2928) oled_data <= 16'b1000000101000111;
            else if (pixel_index == 3018) oled_data <= 16'b0011101110000100;
            else if (pixel_index == 3019) oled_data <= 16'b1010101011000001;
            else if (pixel_index == 3020) oled_data <= 16'b0100110001000001;
            else if (pixel_index == 3021) oled_data <= 16'b1010110000001001;
            else if (pixel_index == 3022) oled_data <= 16'b1100010001001011;
            else if (pixel_index == 3023 || pixel_index == 3210) oled_data <= 16'b0011001111000000;
            else if (pixel_index == 3024 || pixel_index == 3120) oled_data <= 16'b1010001011000001;
            else if (pixel_index == 3025 || pixel_index == 3217 || pixel_index == 3305) oled_data <= 16'b0011001111000010;
            else if (pixel_index == 3114) oled_data <= 16'b0101110101100010;
            else if (pixel_index == 3115) oled_data <= 16'b1010101100000010;
            else if (pixel_index == 3116 || pixel_index == 3119) oled_data <= 16'b0010001100000000;
            else if (pixel_index == 3117) oled_data <= 16'b1101011100101110;
            else if (pixel_index == 3118) oled_data <= 16'b1101111100101100;
            else if (pixel_index == 3121) oled_data <= 16'b0101110100100011;
            else if (pixel_index == 3209) oled_data <= 16'b0011101101000001;
            else if (pixel_index == 3211) oled_data <= 16'b1010110100110001;
            else if (pixel_index == 3212) oled_data <= 16'b0011001101000011;
            else if (pixel_index == 3213) oled_data <= 16'b1100010010100011;
            else if (pixel_index == 3214) oled_data <= 16'b1101110001000001;
            else if (pixel_index == 3215) oled_data <= 16'b0010101101000010;
            else if (pixel_index == 3216) oled_data <= 16'b1011010101110010;
            else if (pixel_index == 3218) oled_data <= 16'b0100110000000010;
            else if (pixel_index == 3304) oled_data <= 16'b0101001110000111;
            else if (pixel_index == 3308) oled_data <= 16'b0011001111000011;
            else if (pixel_index == 3309) oled_data <= 16'b1110111100101011;
            else if (pixel_index == 3310) oled_data <= 16'b1111111101101010;
            //for shop area
            if (pixel_index == 3188 || pixel_index == 3190 || pixel_index == 3192 || pixel_index == 3200 || pixel_index == 3202 || pixel_index == 3204 || pixel_index == 3206 || pixel_index == 3214 || pixel_index == 3216 || pixel_index == 3218 || pixel_index == 3220 || pixel_index == 3228 || pixel_index == 3230 || pixel_index == 3232 || pixel_index == 3234 || pixel_index == 3388 || pixel_index == 3424 || pixel_index == 3476 || pixel_index == 3520 || pixel_index == 3528 || pixel_index == 3668 || pixel_index == 3764 || pixel_index == 3816 || pixel_index == 3861 || ((pixel_index >= 3864) && (pixel_index <= 3865)) || pixel_index == 3868 || pixel_index == 3870 || pixel_index == 3874 || pixel_index == 3880 || pixel_index == 3882 || pixel_index == 3886 || pixel_index == 3891 || ((pixel_index >= 3894) && (pixel_index <= 3895)) || pixel_index == 3901 || ((pixel_index >= 3907) && (pixel_index <= 3908)) || pixel_index == 3911 || pixel_index == 3956 || pixel_index == 3999 || pixel_index == 4008 || pixel_index == 4060 || pixel_index == 4062 || pixel_index == 4148 || pixel_index == 4159 || pixel_index == 4244 || pixel_index == 4258 || ((pixel_index >= 4269) && (pixel_index <= 4270)) || pixel_index == 4273 || pixel_index == 4277 || pixel_index == 4280 || pixel_index == 4282 || pixel_index == 4284 || pixel_index == 4341 || pixel_index == 4343 || pixel_index == 4347 || pixel_index == 4384 || pixel_index == 4386 || pixel_index == 4388 || pixel_index == 4390 || pixel_index == 4392 || pixel_index == 4436 || pixel_index == 4444 || pixel_index == 4447 || pixel_index == 4628 || pixel_index == 4672 || pixel_index == 4680 || pixel_index == 4724 || pixel_index == 4735 || pixel_index == 4776 || pixel_index == 4821 || pixel_index == 4829 || pixel_index == 4867 || pixel_index == 4870 || pixel_index == 4916 || pixel_index == 4924 || pixel_index == 4927 || pixel_index == 5116 || pixel_index == 5149 || pixel_index == 5152 || pixel_index == 5204 || pixel_index == 5301 || pixel_index == 5303 || pixel_index == 5308 || pixel_index == 5341 || pixel_index == 5344 || pixel_index == 5348 || pixel_index == 5396 || pixel_index == 5407 || pixel_index == 5501 || pixel_index == 5534 || pixel_index == 5536 || pixel_index == 5544 || pixel_index == 5588 || pixel_index == 5631 || pixel_index == 5685 || pixel_index == 5692 || pixel_index == 5725 || pixel_index == 5727 || pixel_index == 5730 || pixel_index == 3189 || pixel_index == 3191 || pixel_index == 3201 || pixel_index == 3203 || pixel_index == 3205 || pixel_index == 3215 || pixel_index == 3217 || pixel_index == 3219 || pixel_index == 3229 || pixel_index == 3231 || pixel_index == 3233 || pixel_index == 3772 || pixel_index == 3860 || pixel_index == 3873 || pixel_index == 3888 || pixel_index == 3912 || pixel_index == 4000 || pixel_index == 4192 || pixel_index == 4272 || pixel_index == 4340 || pixel_index == 4342 || pixel_index == 4344 || pixel_index == 4346 || pixel_index == 4385 || pixel_index == 4387 || pixel_index == 4488 || pixel_index == 4820 || pixel_index == 4871 || pixel_index == 5012 || pixel_index == 5020 || pixel_index == 5023 || pixel_index == 5248 || pixel_index == 5300 || pixel_index == 5302 || pixel_index == 5311 || pixel_index == 5349 || pixel_index == 5405 || pixel_index == 5492 || pixel_index == 3193 || pixel_index == 3195 || pixel_index == 3197 || pixel_index == 3199 || pixel_index == 3207 || pixel_index == 3209 || pixel_index == 3211 || pixel_index == 3213 || pixel_index == 3221 || pixel_index == 3223 || pixel_index == 3225 || pixel_index == 3227 || pixel_index == 3235 || pixel_index == 3237 || pixel_index == 3239 || pixel_index == 3284 || pixel_index == 3712 || pixel_index == 3720 || pixel_index == 3876 || pixel_index == 3897 || pixel_index == 3903 || pixel_index == 4156 || pixel_index == 4256 || pixel_index == 4260 || pixel_index == 4263 || pixel_index == 4266 || pixel_index == 4275 || pixel_index == 4296 || pixel_index == 4351 || pixel_index == 4477 || pixel_index == 4574 || pixel_index == 4636 || pixel_index == 4669 || pixel_index == 4823 || pixel_index == 4827 || pixel_index == 4831 || pixel_index == 4865 || pixel_index == 4960 || pixel_index == 5053 || pixel_index == 5064 || pixel_index == 5305 || pixel_index == 5307 || pixel_index == 5346 || pixel_index == 5352 || pixel_index == 5437 || pixel_index == 5440 || pixel_index == 5596 || pixel_index == 5598 || pixel_index == 5629 || pixel_index == 5632 || pixel_index == 5689 || pixel_index == 5693 || pixel_index == 5695 || pixel_index == 5729 || pixel_index == 5732 || pixel_index == 5734 || pixel_index == 3194 || pixel_index == 3196 || pixel_index == 3198 || pixel_index == 3208 || pixel_index == 3210 || pixel_index == 3212 || pixel_index == 3222 || pixel_index == 3224 || pixel_index == 3226 || pixel_index == 3236 || pixel_index == 3238 || pixel_index == 3240 || pixel_index == 3380 || pixel_index == 3432 || pixel_index == 3484 || pixel_index == 3676 || pixel_index == 3808 || pixel_index == 3862 || pixel_index == 3866 || pixel_index == 3869 || pixel_index == 3871 || pixel_index == 3877 || pixel_index == 3879 || pixel_index == 3883 || pixel_index == 3885 || pixel_index == 3889 || pixel_index == 3892 || pixel_index == 3898 || pixel_index == 3900 || pixel_index == 3904 || pixel_index == 3906 || pixel_index == 3909 || pixel_index == 3964 || pixel_index == 4094 || pixel_index == 4104 || pixel_index == 4189 || pixel_index == 4252 || pixel_index == 4257 || pixel_index == 4259 || ((pixel_index >= 4261) && (pixel_index <= 4262)) || ((pixel_index >= 4264) && (pixel_index <= 4265)) || ((pixel_index >= 4267) && (pixel_index <= 4268)) || pixel_index == 4271 || pixel_index == 4274 || pixel_index == 4276 || ((pixel_index >= 4278) && (pixel_index <= 4279)) || pixel_index == 4281 || pixel_index == 4283 || pixel_index == 4288 || pixel_index == 4349 || pixel_index == 4381 || pixel_index == 4391 || pixel_index == 4446 || pixel_index == 4479 || pixel_index == 4540 || pixel_index == 4576 || pixel_index == 4639 || pixel_index == 4765 || pixel_index == 4824 || pixel_index == 4826 || pixel_index == 4828 || pixel_index == 4864 || pixel_index == 4866 || pixel_index == 4869 || pixel_index == 4957 || pixel_index == 4959 || pixel_index == 4968 || pixel_index == 5056 || pixel_index == 5119 || pixel_index == 5160 || pixel_index == 5304 || pixel_index == 5306 || pixel_index == 5351 || pixel_index == 5439 || pixel_index == 5448 || pixel_index == 5500 || pixel_index == 5502 || pixel_index == 5599 || pixel_index == 5630 || pixel_index == 5640 || pixel_index == 5687 || pixel_index == 5690 || pixel_index == 5694 || pixel_index == 5731 || pixel_index == 5733 || pixel_index == 5735) 
            oled_data <= 16'b1000001110010101;    
            else if (((pixel_index >= 3285) && (pixel_index <= 3288)) || ((pixel_index >= 3290) && (pixel_index <= 3291)) || ((pixel_index >= 3293) && (pixel_index <= 3295)) || ((pixel_index >= 3297) && (pixel_index <= 3302)) || ((pixel_index >= 3304) && (pixel_index <= 3309)) || ((pixel_index >= 3311) && (pixel_index <= 3316)) || ((pixel_index >= 3318) && (pixel_index <= 3323)) || ((pixel_index >= 3325) && (pixel_index <= 3327)) || ((pixel_index >= 3329) && (pixel_index <= 3330)) || ((pixel_index >= 3332) && (pixel_index <= 3335)) || pixel_index == 3381 || pixel_index == 3383 || ((pixel_index >= 3385) && (pixel_index <= 3386)) || ((pixel_index >= 3390) && (pixel_index <= 3392)) || pixel_index == 3394 || pixel_index == 3396 || ((pixel_index >= 3399) && (pixel_index <= 3400)) || ((pixel_index >= 3403) && (pixel_index <= 3404)) || ((pixel_index >= 3406) && (pixel_index <= 3408)) || ((pixel_index >= 3410) && (pixel_index <= 3411)) || ((pixel_index >= 3414) && (pixel_index <= 3415)) || pixel_index == 3418 || pixel_index == 3420 || pixel_index == 3422 || ((pixel_index >= 3426) && (pixel_index <= 3428)) || pixel_index == 3431 || ((pixel_index >= 3477) && (pixel_index <= 3478)) || pixel_index == 3480 || ((pixel_index >= 3482) && (pixel_index <= 3483)) || ((pixel_index >= 3485) && (pixel_index <= 3486)) || pixel_index == 3488 || ((pixel_index >= 3490) && (pixel_index <= 3492)) || ((pixel_index >= 3494) && (pixel_index <= 3498)) || ((pixel_index >= 3500) && (pixel_index <= 3505)) || ((pixel_index >= 3507) && (pixel_index <= 3512)) || ((pixel_index >= 3514) && (pixel_index <= 3517)) || pixel_index == 3519 || ((pixel_index >= 3521) && (pixel_index <= 3522)) || ((pixel_index >= 3524) && (pixel_index <= 3527)) || ((pixel_index >= 3573) && (pixel_index <= 3574)) || ((pixel_index >= 3576) && (pixel_index <= 3579)) || ((pixel_index >= 3581) && (pixel_index <= 3586)) || ((pixel_index >= 3588) && (pixel_index <= 3590)) || ((pixel_index >= 3593) && (pixel_index <= 3594)) || ((pixel_index >= 3596) && (pixel_index <= 3597)) || ((pixel_index >= 3601) && (pixel_index <= 3602)) || pixel_index == 3604 || pixel_index == 3606 || ((pixel_index >= 3608) && (pixel_index <= 3610)) || ((pixel_index >= 3613) && (pixel_index <= 3615)) || ((pixel_index >= 3617) && (pixel_index <= 3618)) || pixel_index == 3621 || pixel_index == 3623 || pixel_index == 3670 || ((pixel_index >= 3672) && (pixel_index <= 3673)) || pixel_index == 3675 || pixel_index == 3677 || pixel_index == 3679 || ((pixel_index >= 3681) && (pixel_index <= 3684)) || ((pixel_index >= 3686) && (pixel_index <= 3688)) || pixel_index == 3690 || ((pixel_index >= 3692) && (pixel_index <= 3697)) || ((pixel_index >= 3699) && (pixel_index <= 3704)) || ((pixel_index >= 3706) && (pixel_index <= 3709)) || pixel_index == 3711 || ((pixel_index >= 3714) && (pixel_index <= 3717)) || pixel_index == 3719 || ((pixel_index >= 3765) && (pixel_index <= 3768)) || ((pixel_index >= 3770) && (pixel_index <= 3771)) || ((pixel_index >= 3773) && (pixel_index <= 3776)) || ((pixel_index >= 3779) && (pixel_index <= 3780)) || pixel_index == 3782 || pixel_index == 3784 || ((pixel_index >= 3786) && (pixel_index <= 3788)) || pixel_index == 3790 || pixel_index == 3792 || pixel_index == 3794 || pixel_index == 3796 || pixel_index == 3798 || pixel_index == 3800 || pixel_index == 3802 || ((pixel_index >= 3804) && (pixel_index <= 3807)) || ((pixel_index >= 3809) && (pixel_index <= 3810)) || pixel_index == 3812 || pixel_index == 3814 || ((pixel_index >= 3957) && (pixel_index <= 3960)) || ((pixel_index >= 3962) && (pixel_index <= 3963)) || ((pixel_index >= 3966) && (pixel_index <= 3967)) || ((pixel_index >= 3969) && (pixel_index <= 3981)) || ((pixel_index >= 3983) && (pixel_index <= 3989)) || ((pixel_index >= 3991) && (pixel_index <= 3996)) || pixel_index == 3998 || ((pixel_index >= 4001) && (pixel_index <= 4006)) || pixel_index == 4053 || ((pixel_index >= 4063) && (pixel_index <= 4065)) || pixel_index == 4067 || pixel_index == 4069 || pixel_index == 4071 || pixel_index == 4073 || pixel_index == 4075 || ((pixel_index >= 4077) && (pixel_index <= 4080)) || pixel_index == 4082 || ((pixel_index >= 4084) && (pixel_index <= 4086)) || pixel_index == 4088 || pixel_index == 4090 || ((pixel_index >= 4092) && (pixel_index <= 4093)) || pixel_index == 4095 || pixel_index == 4103 || pixel_index == 4157 || ((pixel_index >= 4161) && (pixel_index <= 4163)) || ((pixel_index >= 4165) && (pixel_index <= 4166)) || ((pixel_index >= 4168) && (pixel_index <= 4169)) || ((pixel_index >= 4171) && (pixel_index <= 4173)) || pixel_index == 4175 || ((pixel_index >= 4177) && (pixel_index <= 4178)) || ((pixel_index >= 4181) && (pixel_index <= 4188)) || ((pixel_index >= 4190) && (pixel_index <= 4191)) || pixel_index == 4199 || pixel_index == 4245 || ((pixel_index >= 4253) && (pixel_index <= 4254)) || ((pixel_index >= 4286) && (pixel_index <= 4287)) || pixel_index == 4350 || ((pixel_index >= 4382) && (pixel_index <= 4383)) || ((pixel_index >= 4437) && (pixel_index <= 4442)) || pixel_index == 4445 || ((pixel_index >= 4481) && (pixel_index <= 4487)) || pixel_index == 4533 || ((pixel_index >= 4541) && (pixel_index <= 4542)) || pixel_index == 4575 || pixel_index == 4583 || ((pixel_index >= 4637) && (pixel_index <= 4638)) || ((pixel_index >= 4670) && (pixel_index <= 4671)) || pixel_index == 4679 || pixel_index == 4725 || ((pixel_index >= 4733) && (pixel_index <= 4734)) || pixel_index == 4766 || ((pixel_index >= 4862) && (pixel_index <= 4863)) || ((pixel_index >= 4917) && (pixel_index <= 4920)) || ((pixel_index >= 4922) && (pixel_index <= 4923)) || pixel_index == 4925 || pixel_index == 4958 || ((pixel_index >= 4961) && (pixel_index <= 4962)) || ((pixel_index >= 4964) && (pixel_index <= 4967)) || pixel_index == 5013 || ((pixel_index >= 5021) && (pixel_index <= 5022)) || pixel_index == 5055 || pixel_index == 5063 || ((pixel_index >= 5117) && (pixel_index <= 5118)) || ((pixel_index >= 5150) && (pixel_index <= 5151)) || pixel_index == 5159 || pixel_index == 5205 || ((pixel_index >= 5213) && (pixel_index <= 5214)) || ((pixel_index >= 5246) && (pixel_index <= 5247)) || pixel_index == 5255 || pixel_index == 5310 || pixel_index == 5343 || ((pixel_index >= 5397) && (pixel_index <= 5402)) || pixel_index == 5406 || pixel_index == 5438 || ((pixel_index >= 5441) && (pixel_index <= 5447)) || pixel_index == 5493 || pixel_index == 5495 || ((pixel_index >= 5497) && (pixel_index <= 5499)) || ((pixel_index >= 5538) && (pixel_index <= 5539)) || pixel_index == 5541 || pixel_index == 5543 || ((pixel_index >= 5589) && (pixel_index <= 5590)) || pixel_index == 5592 || pixel_index == 5595 
            || pixel_index == 5633 || ((pixel_index >= 5635) && (pixel_index <= 5636)) || (pixel_index >= 5638) && (pixel_index <= 5639) || pixel_index == 3289 || pixel_index == 3296 || pixel_index == 3303 || pixel_index == 3310 || pixel_index == 3317 || pixel_index == 3324 || pixel_index == 3331 || pixel_index == 3382 || pixel_index == 3387 || pixel_index == 3389 || pixel_index == 3395 || pixel_index == 3398 || pixel_index == 3402 || pixel_index == 3412 || pixel_index == 3416 || pixel_index == 3419 || pixel_index == 3423 || pixel_index == 3425 || pixel_index == 3430 || pixel_index == 3479 || pixel_index == 3481 || pixel_index == 3489 || pixel_index == 3493 || pixel_index == 3499 || pixel_index == 3506 || pixel_index == 3513 || pixel_index == 3518 || pixel_index == 3523 || pixel_index == 3592 || pixel_index == 3598 || pixel_index == 3600 || pixel_index == 3605 || pixel_index == 3612 || pixel_index == 3620 || pixel_index == 3622 || pixel_index == 3669 || pixel_index == 3671 || pixel_index == 3678 || pixel_index == 3680 || pixel_index == 3685 || pixel_index == 3689 || pixel_index == 3691 || pixel_index == 3698 || pixel_index == 3705 || pixel_index == 3713 || pixel_index == 3769 || pixel_index == 3778 || pixel_index == 3783 || pixel_index == 3791 || pixel_index == 3795 || pixel_index == 3799 || pixel_index == 3803 || pixel_index == 3811 || pixel_index == 3813 || pixel_index == 3815 || pixel_index == 3961 || pixel_index == 3968 || pixel_index == 3982 || pixel_index == 3990 || pixel_index == 3997 || pixel_index == 4007 || pixel_index == 4061 || pixel_index == 4066 || pixel_index == 4068 || pixel_index == 4070 || pixel_index == 4072 || pixel_index == 4074 || pixel_index == 4076 || pixel_index == 4081 || pixel_index == 4083 || pixel_index == 4087 || pixel_index == 4089 || pixel_index == 4091 || pixel_index == 4149 || pixel_index == 4158 || pixel_index == 4160 || pixel_index == 4174 || pixel_index == 4180 || pixel_index == 4295 || pixel_index == 4443 || pixel_index == 4478 || pixel_index == 4629 || pixel_index == 4767 || pixel_index == 4775 || pixel_index == 4830 || pixel_index == 4921 || pixel_index == 4963 || pixel_index == 5109 || pixel_index == 5309 || pixel_index == 5342 || pixel_index == 5403 || pixel_index == 5494 || pixel_index == 5496 || pixel_index == 5537 || pixel_index == 5540 || pixel_index == 5542 || pixel_index == 5593
            || pixel_index == 3384 || pixel_index == 3393 || pixel_index == 3397 || pixel_index == 3401 || pixel_index == 3413 || pixel_index == 3417 || pixel_index == 3421 || pixel_index == 3429 || pixel_index == 3575 || pixel_index == 3591 || pixel_index == 3595 || pixel_index == 3599 || pixel_index == 3603 || pixel_index == 3611 || pixel_index == 3619 || pixel_index == 3718 || pixel_index == 3777 || pixel_index == 3781 || pixel_index == 3785 || pixel_index == 3793 || pixel_index == 3801 || pixel_index == 4164 || pixel_index == 4167 || pixel_index == 4170 || pixel_index == 4176 || pixel_index == 4179 || pixel_index == 5591 || pixel_index == 5594 || pixel_index == 5637
            || pixel_index == 3405 || pixel_index == 3409 || pixel_index == 3487 || pixel_index == 3587 || pixel_index == 3607 || pixel_index == 3674 || pixel_index == 3710 || pixel_index == 3789 || pixel_index == 3797 || pixel_index == 5634) oled_data <= 16'b1110011011111110;
            else if (pixel_index == 3292 || pixel_index == 3328 || pixel_index == 3336 || pixel_index == 3580 || pixel_index == 3872 || pixel_index == 3887 || pixel_index == 3899 || pixel_index == 3905 || pixel_index == 4096 || pixel_index == 4200 || pixel_index == 4345 || pixel_index == 4768 || pixel_index == 4825 || pixel_index == 4872 || pixel_index == 5108 || pixel_index == 5215 || pixel_index == 5350 || pixel_index == 5404 || pixel_index == 5688
            || pixel_index == 3572 || pixel_index == 3881 || pixel_index == 4052 || pixel_index == 4389 || pixel_index == 4532 || pixel_index == 4543 || pixel_index == 4868 || pixel_index == 5245 || pixel_index == 5535 || pixel_index == 5686 || pixel_index == 5691 || pixel_index == 5726
            || pixel_index == 3616 || pixel_index == 3624 || pixel_index == 3863 || pixel_index == 3875 || pixel_index == 3896 || pixel_index == 3902 || pixel_index == 4255 || pixel_index == 4573 || pixel_index == 4584 || pixel_index == 4732 || pixel_index == 4822 || pixel_index == 4926 || pixel_index == 5054 || pixel_index == 5212 || pixel_index == 5256 || pixel_index == 5345 || pixel_index == 5347 || pixel_index == 5533 || pixel_index == 5597 || pixel_index == 5684 || pixel_index == 5728 || pixel_index == 3867 || pixel_index == 3878 || pixel_index == 3884 || pixel_index == 3890 || pixel_index == 3893 || pixel_index == 3910 || pixel_index == 3965 || pixel_index == 4285 || pixel_index == 4348 || pixel_index == 4480 || pixel_index == 4861 || pixel_index == 5503 || pixel_index == 5736) oled_data <= 16'b1000001111010101;
            //oled_data <= 16'b1000001111010100;
            else if (  ((pixel_index >= 4150) && (pixel_index <= 4155)) || ((pixel_index >= 4054) && (pixel_index <= 4059)) || ((pixel_index >= 4246) && (pixel_index <= 4251))) oled_data <= 16'b11111_101000_10110; // Pink
            else if ( ((pixel_index >= 4193) && (pixel_index <= 4198)) || ((pixel_index >= 4097) && (pixel_index <= 4102))||  (pixel_index >= 4289) && (pixel_index <= 4294)) oled_data <= 16'b11111_101000_10110; // Pink
            else if (((pixel_index >= 4534) && (pixel_index <= 4539)) || ((pixel_index >= 4577) && (pixel_index <= 4582)) || ((pixel_index >= 4630) && (pixel_index <= 4635)) || ((pixel_index >= 4673) && (pixel_index <= 4678)) || ((pixel_index >= 4726) && (pixel_index <= 4731)) || (pixel_index >= 4769) && (pixel_index <= 4774)) oled_data <= 16'b1111111110100000;
            else if (((pixel_index >= 5014) && (pixel_index <= 5019)) || ((pixel_index >= 5057) && (pixel_index <= 5062)) || ((pixel_index >= 5110) && (pixel_index <= 5115)) || ((pixel_index >= 5153) && (pixel_index <= 5158)) || ((pixel_index >= 5206) && (pixel_index <= 5211)) || (pixel_index >= 5249) && (pixel_index <= 5254)) oled_data <= 16'b1111110000000000;
            
            //shelf
            if((x_pos <= 6 || x_pos >= 89  )&& y_pos >= 33 && pixel_index != 3173 && pixel_index != 3174 && pixel_index != 3270 && pixel_index != 3258 && pixel_index != 3257 && pixel_index != 3353) begin
            oled_data <= 16'b1000001110010101;   
            if(((x_pos >= 0 && x_pos <= 2) || x_pos == 4 || x_pos == 5 || (x_pos >= 93 && x_pos <= 95) || x_pos == 90 || x_pos == 91) && (y_pos >= 34 && y_pos <= 62) && pixel_index != 3354 && pixel_index != 3269 ) 
            oled_data <= 16'b1110011011111110;
            end
            
            //watercan
            if (pixel_index == 3641 || pixel_index == 3739 || pixel_index == 3833 || pixel_index == 3931 || pixel_index == 4409 || pixel_index == 4507 || pixel_index == 4601 || pixel_index == 4794 || pixel_index == 5177 || pixel_index == 5369 || pixel_index == 5467 || pixel_index == 3737 || pixel_index == 4505 || pixel_index == 5273 || pixel_index == 3834 || pixel_index == 4026 || pixel_index == 4699 || pixel_index == 5275 || pixel_index == 5466 || pixel_index == 5563 
            || pixel_index == 3930 || pixel_index == 5370 || pixel_index == 4027 || pixel_index == 4698 || pixel_index == 4795 || pixel_index == 5562 || pixel_index == 4602)
             oled_data <= 16'b11111_000000_01001;
             
            //fishing rod
            if (pixel_index == 2982 || pixel_index == 3078 || pixel_index == 3174 || ((pixel_index >= 3269) && (pixel_index <= 3270)) || ((pixel_index >= 3365) && (pixel_index <= 3366)) || pixel_index == 3461 || ((pixel_index >= 3556) && (pixel_index <= 3557)) || ((pixel_index >= 3652) && (pixel_index <= 3653)) || pixel_index == 3748 || pixel_index == 3844 || pixel_index == 3940 || pixel_index == 4038 || pixel_index == 4134 || ((pixel_index >= 4229) && (pixel_index <= 4230)) || ((pixel_index >= 4325) && (pixel_index <= 4326)) || pixel_index == 4421 || ((pixel_index >= 4516) && (pixel_index <= 4517)) || ((pixel_index >= 4612) && (pixel_index <= 4613)) || pixel_index == 4708 || pixel_index == 4804 || pixel_index == 4900 || pixel_index == 4998 || pixel_index == 5094 || ((pixel_index >= 5189) && (pixel_index <= 5190)) || ((pixel_index >= 5285) && (pixel_index <= 5286)) || pixel_index == 5381 || ((pixel_index >= 5476) && (pixel_index <= 5477)) || ((pixel_index >= 5572) && (pixel_index <= 5573)) || pixel_index == 5668 || pixel_index == 5764 || pixel_index == 5860) 
            begin
            if (rod_num == 2'b01)
             oled_data <= 16'b00100_101100_01001; //Fishing rod 2 green
             else if (rod_num == 2'b10)
             oled_data <= 16'b00000_000000_00000; //Fishing rod 3 black
            end
           
            
            if(char_output != 16'd0)
                oled_data <= char_output;
                
                
        //sell_mode        
        if ((x_offset >= 39 && x_offset <= 46)&& (y_offset >= 29 && y_offset <= 35) && btnC == 1)begin
            sell_mode <= 1;
            end
        if(sell_mode == 1)begin
            if(btnL == 1)begin
            current_out <= current + 
                           ((selector[3] && carp_count > 0) ? 200 : 0) +
                           ((selector[4] && bluetang_count > 0) ? 400 : 0) +
                           ((selector[5] && koi_count > 0) ? 1000 : 0) +
                           ((selector[6] && wheat_count > 0) ? 400 : 0) +
                           ((selector[7] && pumpkin_count > 0) ? 600 : 0);        
                if((selector[3] && carp_count > 0))begin
                    carp_count_out <= carp_count - 1;
                    end
                if((selector[4] && bluetang_count > 0))begin
                    bluetang_count_out <= bluetang_count - 1;
                    end
                if((selector[5] && koi_count > 0))begin
                    koi_count_out <= koi_count - 1;
                    end
                if((selector[6] && wheat_count > 0))begin
                    wheat_count_out <= wheat_count - 1;
                    end
                if((selector[7] && pumpkin_count > 0))begin
                    pumpkin_count_out <= pumpkin_count - 1;
                    end
                sell_mode <= 0;
            end
            if(btnR == 1)begin
                sell_mode <= 0;
            end
        end
        //chat
        if (((x_offset >= 31 && x_offset <= 34) || (x_offset >= 51 && x_offset <= 54)) && (y_offset >= 29 && y_offset <= 45)) begin
            if (((pixel_index >= 824) && (pixel_index <= 841)) || 
                ((pixel_index >= 919) && (pixel_index <= 938)) || 
                ((pixel_index >= 1014) && (pixel_index <= 1034)) || 
                ((pixel_index >= 1110) && (pixel_index <= 1116)) || 
                ((pixel_index >= 1124) && (pixel_index <= 1130)) || 
                ((pixel_index >= 1206) && (pixel_index <= 1212)) || 
                ((pixel_index >= 1220) && (pixel_index <= 1226)) || 
                ((pixel_index >= 1302) && (pixel_index <= 1308)) || 
                ((pixel_index >= 1316) && (pixel_index <= 1322)) || 
                ((pixel_index >= 1398) && (pixel_index <= 1404)) || 
                ((pixel_index >= 1412) && (pixel_index <= 1418)) || 
                ((pixel_index >= 1494) && (pixel_index <= 1500)) || 
                ((pixel_index >= 1508) && (pixel_index <= 1514)) || 
                ((pixel_index >= 1590) && (pixel_index <= 1596)) || 
                ((pixel_index >= 1604) && (pixel_index <= 1610)) || 
                ((pixel_index >= 1686) && (pixel_index <= 1692)) || 
                ((pixel_index >= 1700) && (pixel_index <= 1706)) || 
                ((pixel_index >= 1781) && (pixel_index <= 1802)) || 
                ((pixel_index >= 1876) && (pixel_index <= 1898)) || 
                ((pixel_index >= 1971) && (pixel_index <= 1992)) || 
                (pixel_index == 2072) || 
                (pixel_index == 2454)) 
            begin
                oled_data <= 16'b1111111111111111;
            end
        if(btnC == 1)
            buy_mode <= 1;
        
        
        if ((x_pos >= 61 && x_pos <= 67) && (y_pos >= 11 && y_pos <= 17)) begin
        
                oled_data <= 16'b1111111111111111;
                
                
                if (y_offset >= 29 && y_offset <= 35) begin
                    if(pixel_index == 1215 || pixel_index == 1599 || pixel_index == 1410)
                    oled_data <= 16'b11111_101000_10110;   
                    if(pixel_index == 1214 || pixel_index == 1598 || pixel_index == 1409
                    || pixel_index == 1216 || pixel_index == 1600 || pixel_index == 1411
                    || pixel_index ==  1119 || pixel_index == 1314 || pixel_index == 1503
                    || pixel_index == 1311 || pixel_index == 1506 || pixel_index == 1695)
                    oled_data <= 16'b10011_010100_01011;
                    item_code <= 3'b001;
                    if(buy_mode == 1)begin
                            if(btnL == 1)begin
                                current_out <= current - 200;
                                bait_count_out <= bait_count + 1;
                                buy_mode <= 0;
                            end
                            if(btnR == 1 || current < 200)begin
                                buy_mode <= 0;
                            end
                            end
                end
                
                if (y_offset > 35 && y_offset <= 40) begin
                    if (pixel_index == 1022 || ((pixel_index >= 1117) && (pixel_index <= 1118)) || ((pixel_index >= 1120) && (pixel_index <= 1121)) || pixel_index == 1219 || pixel_index == 1314 || ((pixel_index >= 1405) && (pixel_index <= 1406)) || pixel_index == 1409 || ((pixel_index >= 1504) && (pixel_index <= 1505)) || pixel_index == 1598 || pixel_index == 1603 || pixel_index == 1693 || pixel_index == 1699 || pixel_index == 1216 || pixel_index == 1310 || pixel_index == 1315 || pixel_index == 1694 || pixel_index == 1698) 
                    oled_data <= 16'b1111111110100000;
                    item_code <= 3'b010;
                                    if(buy_mode == 1)begin
                            if(btnL == 1)begin
                                current_out <= current - 300;
                                wheatseed_count_out <= wheatseed_count + 1;
                                buy_mode <= 0;
                            end
                            if(btnR == 1 || current < 300)begin
                                buy_mode <= 0;
                            end
                            end
                end
                
                if (y_offset > 40 && y_offset <= 45) begin
                    if (pixel_index == 1022 || ((pixel_index >= 1117) && (pixel_index <= 1118)) || ((pixel_index >= 1120) && (pixel_index <= 1121)) || pixel_index == 1219 || pixel_index == 1314 || ((pixel_index >= 1405) && (pixel_index <= 1406)) || pixel_index == 1409 || ((pixel_index >= 1504) && (pixel_index <= 1505)) || pixel_index == 1598 || pixel_index == 1603 || pixel_index == 1693 || pixel_index == 1699 || pixel_index == 1216 || pixel_index == 1310 || pixel_index == 1315 || pixel_index == 1694 || pixel_index == 1698) 
                    oled_data <= 16'b1111110000000000;
                    item_code <= 3'b011;
                            if(buy_mode == 1)begin
                            if(btnL == 1)begin
                                current_out <= current - 400;
                                pumpkinseed_count_out <= pumpkinseed_count + 1;
                                buy_mode <= 0;
                            end
                            if(btnR == 1 || current < 400)begin
                                buy_mode <= 0;
                            end
                            end
                end
            end
        
        end
        end
        
        endmodule