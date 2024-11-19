`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 00:21:25
// Design Name: 
// Module Name: Farm
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


module Farm(
input MAIN_CLK, //100MHZ
input [7:0]sw,
input btnU ,btnD ,btnC ,btnL ,btnR ,
//input stateA,
//input [2:0] inputcurrentTaskA,
input [12:0] pixel_index,
input gobackFarm,
input gobackFarmFromFish,
input gobackFarmFromHome,
input [31:0] day,
//output reg [15:0]led = 0,
output reg [15:0]oled_data = 0,
input [4:0] wheat_count,
output reg [4:0] wheat_output,
input [4:0] pumpkin_count,
output reg [4:0] pumpkin_output,
  //  .wheat_count_out(wheat_count_out),
 //   .pumpkin_count(pumpkin_count),
  //  .pumpkin_count_out(pumpkin_count_out)
//output reg [2:0] outputcurrentTaskA = 0
output reg shop = 0,
output reg fish = 0,
output reg home = 1
);



reg [13:0] plot [0:18];
reg [24:0] wet = 24'b000000000000000000000000;
reg [1:0] GrowthState [0:18];
reg [1:0] PType [0:18];

integer i, j;

reg [4:0] PumpSeed = 9;
reg [4:0] WheatSeed = 9;
reg [4:0] Wheat = 0;
reg [4:0] Pumpkin = 0;

reg [13:0] base_values [0:16];
reg [13:0] base_valuesG1C1 [0:14];
reg [13:0] base_valuesG1C2 [0:16];

reg [13:0] base_valuesD1C1 [0:19];
reg [13:0] base_valuesD1C2 [0:23];
reg [13:0] base_valuesD1C3 [0:21];
reg newday = 0;

initial begin
PType[0] = 2;
PType[1] = 2;
PType[2] = 2;
PType[3] = 1;
PType[4] = 1;
PType[5] = 1;
PType[6] = 1;
PType[7] = 1;
PType[8] = 1;
PType[9] = 1;
PType[10] = 1;
PType[11] = 1;
PType[12] = 1;
PType[13] = 1;
PType[14] = 1;
//PType[15] = 1;
//PType[16] = 1;
//PType[17] = 1;
//PType[18] = 1;
//PType[19] = 1;
//PType[20] = 1;
//PType[21] = 1;
//PType[22] = 1;
//PType[23] = 1;
plot[0] = 1828;
plot[1] = 1839;
plot[2] = 1850;
plot[3] = 2500;
plot[4] = 2511;
plot[5] = 2522;
plot[6] = 3172;
plot[7] = 3183;
plot[8] = 3194;
plot[9] = 3844;
plot[10] = 3855;
plot[11] = 3866;
plot[12] = 4516;
plot[13] = 4527;
plot[14] = 4538;
//plot[15] = 5188;
//plot[16] =  5199;
//plot[17] = 5210;
//plot[18] = 1883;
//plot[19] = 1894;
//plot[20] = 1905;
//plot[21] = 2555;
//plot[22] = 2566;
//plot[23] = 2577;
GrowthState[0] = 1;
GrowthState[1] = 1;
GrowthState[2] = 1;
GrowthState[3] = 2;
GrowthState[4] = 2;
GrowthState[5] = 2;
GrowthState[6] = 1;
GrowthState[7] = 1;
GrowthState[8] = 1;
GrowthState[9] = 3;
GrowthState[10] = 3;
GrowthState[11] = 3;
GrowthState[12] = 2;
GrowthState[13] = 2;
GrowthState[14] = 2;
//GrowthState[15] = 2;
//GrowthState[16] = 2;
//GrowthState[17] = 2;
//GrowthState[18] = 1;
//GrowthState[19] = 1;
//GrowthState[20] = 1;
//GrowthState[21] = 3;
//GrowthState[22] = 3;
//GrowthState[23] = 3;
base_values[0] = 391;
base_values[1] = 482;
base_values[2] = 3;
base_values[3] = 103;
base_values[4] = 293;
base_values[5] = 485;
base_values[6] = 98;
base_values[7] = 384;
base_values[8] = 489;
base_values[9] = 101;
base_values[10] = 296;
base_values[11] = 388;
base_values[12] = 0;
base_values[14] = 8;
base_values[15] = 195;

base_valuesG1C1[0] = 2;
base_valuesG1C1[1] = 6;
base_valuesG1C1[2] = 197;
base_valuesG1C1[3] = 384;
base_valuesG1C1[4] = 387;
base_valuesG1C1[5] = 4;
base_valuesG1C1[6] = 293;
base_valuesG1C1[7] = 487;
base_valuesG1C1[8] = 98;
base_valuesG1C1[9] = 102;
base_valuesG1C1[10] = 480;
base_valuesG1C1[11] = 483;
base_valuesG1C1[12] = 100;
base_valuesG1C1[13] = 391;

base_valuesG1C2[0] = 96;
base_valuesG1C2[1] = 192;
base_valuesG1C2[2] = 200;
base_valuesG1C2[3] = 290;
base_valuesG1C2[4] = 292;
base_valuesG1C2[5] = 294;
base_valuesG1C2[6] = 388;
base_valuesG1C2[7] = 481;
base_valuesG1C2[8] = 485;
base_valuesG1C2[9] = 488;
base_valuesG1C2[10] = 577;
base_valuesG1C2[11] = 584;
base_valuesG1C2[12] = 296;
base_valuesG1C2[13] = 386;
base_valuesG1C2[14] = 390;
base_valuesG1C2[15] = 581;

base_valuesD1C1[0] = 0;
base_valuesD1C1[1] = 4;
base_valuesD1C1[2] = 7;
base_valuesD1C1[3] = 105;
base_valuesD1C1[4] = 192;
base_valuesD1C1[5] = 196;
base_valuesD1C1[6] = 199;
base_valuesD1C1[7] = 201;
base_valuesD1C1[8] = 390;
base_valuesD1C1[9] = 486;
base_valuesD1C1[10] = 96;
base_valuesD1C1[11] = 100;
base_valuesD1C1[12] = 103;
base_valuesD1C1[13] = 288;
base_valuesD1C1[14] = 292;
base_valuesD1C1[15] = 295;
base_valuesD1C1[16] = 297;
base_valuesD1C1[17] = 582;
base_valuesD1C1[18] = 9;

base_valuesD1C2[0] = 98;
base_valuesD1C2[1] = 102;
base_valuesD1C2[2] = 104;
base_valuesD1C2[3] = 384;
base_valuesD1C2[4] = 388;
base_valuesD1C2[5] = 393;
base_valuesD1C2[6] = 482;
base_valuesD1C2[7] = 487;
base_valuesD1C2[8] = 576;
base_valuesD1C2[9] = 580;
base_valuesD1C2[10] = 194;
base_valuesD1C2[11] = 198;
base_valuesD1C2[12] = 386;
base_valuesD1C2[13] = 391;
base_valuesD1C2[14] = 480;
base_valuesD1C2[15] = 489;
base_valuesD1C2[16] = 583;
base_valuesD1C2[17] = 200;
base_valuesD1C2[18] = 484;
base_valuesD1C2[19] = 290;
base_valuesD1C2[20] = 294;
base_valuesD1C2[21] = 585;
base_valuesD1C2[22] = 679;

base_valuesD1C3[0] = 195;
base_valuesD1C3[1] = 289;
base_valuesD1C3[2] = 293;
base_valuesD1C3[3] = 296;
base_valuesD1C3[4] = 387;
base_valuesD1C3[5] = 481;
base_valuesD1C3[6] = 485;
base_valuesD1C3[7] = 488;
base_valuesD1C3[8] = 385;
base_valuesD1C3[9] = 389;
base_valuesD1C3[10] = 392;
base_valuesD1C3[11] = 483;
base_valuesD1C3[12] = 577;
base_valuesD1C3[13] = 584;
base_valuesD1C3[14] = 677;
base_valuesD1C3[15] = 579;
base_valuesD1C3[16] = 581;
base_valuesD1C3[17] = 673;
base_valuesD1C3[18] = 680;
base_valuesD1C3[19] = 290;
base_valuesD1C3[20] = 291;

end



wire clk6p25m;
flexible_clock First_CLK(.basys_clock(MAIN_CLK),.count(7),.SLOW_CLOCK(clk6p25m));

wire clk100;
flexible_clock hundred_CLK(.basys_clock(MAIN_CLK),.count(499999),.SLOW_CLOCK(clk100));

//wire clk5;
//flexible_clock five_CLK(.basys_clock(MAIN_CLK),.count(9999999),.SLOW_CLOCK(clk5));

wire fb, sending_pixels, sample_bits;

wire [6:0] x;
wire [5:0] y;

assign x = pixel_index % 96;
assign y = pixel_index / 96;

wire [6:0] char_x;
wire [5:0] char_y;

wire facing_up;
wire facing_down;
wire facing_left;
wire facing_right;

Movement character(.basys_clock(MAIN_CLK), .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR), .char_x(char_x), .char_y(char_y),
.facing_up(facing_up),.facing_down(facing_down) ,.facing_left(facing_left), .facing_right(facing_right),
.gobackFarm(gobackFarm), .gobackFarmFromFish(gobackFarmFromFish), .gobackFarmFromHome(gobackFarmFromHome));

reg threeseconds_elapsed = 0;
wire onekhzclock;
flexible_clock onekhz_clock(.basys_clock(MAIN_CLK),.count(49999),.SLOW_CLOCK(onekhzclock));
reg [31:0] counter = 0;

//reg [31:0] day = 0;
reg [31:0] previous_day = 0;

always @(posedge onekhzclock) begin
    counter <= (btnC && sw[0]) ? counter + 1 : 0;
    if (counter >= 1000)
    begin
        threeseconds_elapsed = 1;
    end
    else begin
        threeseconds_elapsed = 0;
    end
    
   // if (sw[3]) day <= 1;
   // if (sw[4]) day = 2;
 //   if (sw[5]) day = 3;
    
    //COMMENTED FOR TEST
   /* for (j = 0; j < 24; j = j + 1) begin 
        if (PType[j] == 0) begin
            GrowthState[j] = 1;
        end
    end */
    

   // if (PType[16] == 0) GrowthState[16] = 1;
   // if (PType[17] == 0) GrowthState[17] = 1;
    //if (PType[18] == 0) GrowthState[18] = 1;
  //  if (PType[19] == 0) GrowthState[19] = 1;
  //  if (PType[20] == 0) GrowthState[20] = 1;
   // if (PType[21] == 0) GrowthState[21] = 1;
   // if (PType[22] == 0) GrowthState[22] = 1;
  //  if (PType[23] == 0) GrowthState[23] = 1;
    /*
    
    if (day > previous_day) begin
        for (j = 0; j < 18; j = j + 1) begin 
            if (GrowthState[j] < 3 && GrowthState[j] && wet[j] > 0) begin
                GrowthState[j] <= GrowthState[j] + 1;
                wet[j] <= 0;
            end
        end
     end  
     
     */
      
    // previous_day <= day;   
      
     if (char_x > 40 && char_x < 60 && char_y > 47) shop <= 1;
     if (char_x > 78 && char_y > 20 && char_y < 29) fish <= 1;
     if (char_x > 40 && char_x < 60 && char_y < 17) home <= 1;
     if (gobackFarm) shop <= 0;
     if (gobackFarmFromFish) fish <= 0;
     if (gobackFarmFromHome) home <= 0;
     
    end


always @(posedge clk6p25m) begin


if (pixel_index == 0 || pixel_index == 7 || pixel_index == 12 || pixel_index == 17 || pixel_index == 23 || pixel_index == 28 || pixel_index == 32 || pixel_index == 35 || pixel_index == 37 || pixel_index == 59 || pixel_index == 66 || pixel_index == 73 || pixel_index == 75 || pixel_index == 78 || pixel_index == 80 || pixel_index == 84 || pixel_index == 86 || pixel_index == 89 || pixel_index == 91 || ((pixel_index >= 103) && (pixel_index <= 104)) || pixel_index == 115 || pixel_index == 122 || pixel_index == 133 || pixel_index == 156 || pixel_index == 163 || pixel_index == 175 || pixel_index == 182 || pixel_index == 192 || pixel_index == 198 || pixel_index == 218 || pixel_index == 251 || pixel_index == 278 || pixel_index == 295 || pixel_index == 306 || pixel_index == 348 || pixel_index == 355 || pixel_index == 367 || pixel_index == 384 || pixel_index == 391 || pixel_index == 403 || pixel_index == 410 || pixel_index == 443 || pixel_index == 445 || pixel_index == 451 || pixel_index == 464 || pixel_index == 481 || pixel_index == 487 || pixel_index == 500 || pixel_index == 540 || pixel_index == 566 || pixel_index == 576 || pixel_index == 635 || pixel_index == 637 || pixel_index == 643 || pixel_index == 649 || pixel_index == 656 || pixel_index == 692) oled_data = 16'b0001001010000100;
else if (pixel_index == 1 || pixel_index == 6 || pixel_index == 13 || pixel_index == 15 || pixel_index == 18 || pixel_index == 20 || pixel_index == 24 || pixel_index == 26 || pixel_index == 29 || pixel_index == 31 || pixel_index == 34 || pixel_index == 60 || pixel_index == 62 || pixel_index == 67 || pixel_index == 72 || pixel_index == 77 || pixel_index == 83 || pixel_index == 88 || pixel_index == 92 || pixel_index == 96 || pixel_index == 116 || pixel_index == 121 || pixel_index == 127 || pixel_index == 132 || pixel_index == 157 || pixel_index == 164 || pixel_index == 176 || pixel_index == 181 || pixel_index == 187 || pixel_index == 193 || pixel_index == 200 || pixel_index == 205 || pixel_index == 210 || pixel_index == 212 || pixel_index == 252 || pixel_index == 258 || pixel_index == 260 || pixel_index == 265 || pixel_index == 270 || pixel_index == 272 || pixel_index == 288 || pixel_index == 296 || pixel_index == 307 || pixel_index == 313 || pixel_index == 319 || pixel_index == 349 || pixel_index == 354 || pixel_index == 366 || pixel_index == 373 || pixel_index == 379 || pixel_index == 385 || pixel_index == 390 || pixel_index == 397 || pixel_index == 404 || pixel_index == 409 || pixel_index == 452 || pixel_index == 457 || pixel_index == 463 || ((pixel_index >= 469) && (pixel_index <= 470)) || pixel_index == 488 || pixel_index == 493 || pixel_index == 505 || pixel_index == 511 || pixel_index == 539 || pixel_index == 546 || pixel_index == 548 || pixel_index == 571 || pixel_index == 577 || pixel_index == 582 || pixel_index == 584 || pixel_index == 602 || pixel_index == 607 || pixel_index == 642 || pixel_index == 667 || pixel_index == 703 || pixel_index == 731 || pixel_index == 752 || pixel_index == 758 || pixel_index == 763 || pixel_index == 774 || pixel_index == 834) oled_data = 16'b0001001010000101;
else if (pixel_index == 2 || pixel_index == 14 || pixel_index == 19 || pixel_index == 25 || pixel_index == 30 || pixel_index == 61 || pixel_index == 68 || pixel_index == 97 || pixel_index == 109 || pixel_index == 211 || pixel_index == 253 || pixel_index == 259 || pixel_index == 271 || pixel_index == 283 || pixel_index == 289 || pixel_index == 308 || pixel_index == 314 || pixel_index == 374 || pixel_index == 415 || pixel_index == 462 || pixel_index == 475 || pixel_index == 506 || pixel_index == 547 || pixel_index == 565 || pixel_index == 583 || pixel_index == 589 || pixel_index == 698 || pixel_index == 738 || pixel_index == 827) oled_data = 16'b0001101010000100;
else if (pixel_index == 8 || pixel_index == 36 || pixel_index == 74 || pixel_index == 79 || pixel_index == 85 || pixel_index == 90 || pixel_index == 102 || pixel_index == 114 || pixel_index == 155 || pixel_index == 162 || pixel_index == 169 || pixel_index == 174 || pixel_index == 199 || pixel_index == 217 || pixel_index == 223 || pixel_index == 228 || pixel_index == 277 || pixel_index == 294 || pixel_index == 301 || pixel_index == 347 || pixel_index == 356 || pixel_index == 361 || pixel_index == 368 || pixel_index == 392 || pixel_index == 402 || pixel_index == 444 || pixel_index == 450 || pixel_index == 480 || pixel_index == 486 || pixel_index == 541 || pixel_index == 553 || pixel_index == 560 || pixel_index == 596 || pixel_index == 636 || pixel_index == 644 || pixel_index == 662 || pixel_index == 678) oled_data = 16'b0001101010000101;
else if (pixel_index == 40 || ((pixel_index >= 42) && (pixel_index <= 43)) || pixel_index == 45 || ((pixel_index >= 47) && (pixel_index <= 48)) || pixel_index == 50 || ((pixel_index >= 52) && (pixel_index <= 53)) || pixel_index == 135 || pixel_index == 137 || pixel_index == 140 || pixel_index == 142 || ((pixel_index >= 144) && (pixel_index <= 145)) || ((pixel_index >= 149) && (pixel_index <= 151)) || pixel_index == 230 || pixel_index == 232 || pixel_index == 235 || ((pixel_index >= 238) && (pixel_index <= 239)) || pixel_index == 242 || pixel_index == 244 || pixel_index == 246 || pixel_index == 248) oled_data = 16'b1001100000000110;
else if (pixel_index == 41 || pixel_index == 44 || pixel_index == 46 || pixel_index == 49 || pixel_index == 51 || pixel_index == 54 || pixel_index == 136 || pixel_index == 138 || pixel_index == 141 || pixel_index == 146 || pixel_index == 148 || pixel_index == 231 || pixel_index == 234 || pixel_index == 236 || pixel_index == 240 || pixel_index == 243 || pixel_index == 247) oled_data = 16'b1001000000000110;
else if (pixel_index == 98 || pixel_index == 202 || pixel_index == 207 || pixel_index == 262 || pixel_index == 285 || pixel_index == 387 || pixel_index == 466 || pixel_index == 474 || pixel_index == 484 || pixel_index == 574 || pixel_index == 593 || pixel_index == 600 || pixel_index == 604 || pixel_index == 658 || pixel_index == 664 || pixel_index == 675 || pixel_index == 735 || pixel_index == 780 || pixel_index == 803 || pixel_index == 840 || pixel_index == 852 || pixel_index == 869) oled_data = 16'b0010010101101010;
else if (pixel_index == 99 || pixel_index == 101 || pixel_index == 106 || pixel_index == 111 || pixel_index == 113 || pixel_index == 118 || pixel_index == 120 || pixel_index == 126 || pixel_index == 129 || pixel_index == 131 || pixel_index == 159 || pixel_index == 161 || pixel_index == 166 || pixel_index == 168 || pixel_index == 171 || pixel_index == 173 || pixel_index == 178 || pixel_index == 180 || pixel_index == 186 || pixel_index == 189 || pixel_index == 191 || pixel_index == 194 || pixel_index == 201 || pixel_index == 203 || pixel_index == 206 || pixel_index == 208 || pixel_index == 213 || pixel_index == 224 || pixel_index == 254 || pixel_index == 261 || pixel_index == 263 || pixel_index == 266 || pixel_index == 273 || pixel_index == 284 || pixel_index == 291 || pixel_index == 293 || pixel_index == 300 || pixel_index == 303 || pixel_index == 312 || pixel_index == 316 || pixel_index == 318 || pixel_index == 321 || pixel_index == 323 || pixel_index == 353 || pixel_index == 358 || pixel_index == 360 || pixel_index == 363 || pixel_index == 365 || pixel_index == 370 || pixel_index == 372 || pixel_index == 376 || pixel_index == 378 || pixel_index == 381 || pixel_index == 386 || pixel_index == 393 || pixel_index == 398 || pixel_index == 405 || pixel_index == 407 || pixel_index == 446 || pixel_index == 448 || pixel_index == 453 || pixel_index == 458 || pixel_index == 465 || pixel_index == 467 || pixel_index == 471 || pixel_index == 473 || pixel_index == 478 || pixel_index == 483 || pixel_index == 485 || pixel_index == 490 || pixel_index == 497 || pixel_index == 504 || pixel_index == 508 || pixel_index == 510 || pixel_index == 513 || pixel_index == 515 || pixel_index == 545 || pixel_index == 552 || pixel_index == 555 || pixel_index == 562 || pixel_index == 568 || pixel_index == 570 || pixel_index == 575 || pixel_index == 578 || pixel_index == 580 || pixel_index == 585 || pixel_index == 592 || pixel_index == 597 || pixel_index == 599 || pixel_index == 603 || pixel_index == 605 || pixel_index == 608 || pixel_index == 638 || pixel_index == 645 || pixel_index == 657 || pixel_index == 663 || pixel_index == 665 || pixel_index == 668 || pixel_index == 670 || pixel_index == 674 || pixel_index == 676 || pixel_index == 684 || pixel_index == 689 || pixel_index == 696 || pixel_index == 702 || pixel_index == 707 || pixel_index == 734 || pixel_index == 736 || pixel_index == 744 || pixel_index == 749 || pixel_index == 756 || pixel_index == 762 || pixel_index == 770 || pixel_index == 773 || pixel_index == 777 || pixel_index == 782 || pixel_index == 789 || pixel_index == 795 || pixel_index == 800 || pixel_index == 830 || pixel_index == 833 || pixel_index == 837 || pixel_index == 842 || pixel_index == 849 || pixel_index == 855 || pixel_index == 860 || pixel_index == 866 || pixel_index == 876 || pixel_index == 878 || pixel_index == 885 || pixel_index == 888 || pixel_index == 936 || pixel_index == 938 || pixel_index == 941 || pixel_index == 945 || pixel_index == 948) oled_data = 16'b0010010110101001;
else if (pixel_index == 100 || pixel_index == 105 || pixel_index == 107 || pixel_index == 110 || pixel_index == 112 || pixel_index == 117 || pixel_index == 119 || pixel_index == 123 || pixel_index == 125 || pixel_index == 128 || pixel_index == 158 || pixel_index == 160 || pixel_index == 165 || pixel_index == 167 || pixel_index == 170 || pixel_index == 172 || pixel_index == 177 || pixel_index == 179 || pixel_index == 183 || pixel_index == 185 || pixel_index == 188 || pixel_index == 190 || pixel_index == 195 || pixel_index == 197 || pixel_index == 204 || pixel_index == 209 || pixel_index == 216 || pixel_index == 220 || pixel_index == 222 || pixel_index == 225 || pixel_index == 227 || pixel_index == 255 || pixel_index == 257 || pixel_index == 264 || pixel_index == 267 || pixel_index == 269 || pixel_index == 276 || pixel_index == 280 || pixel_index == 282 || pixel_index == 287 || pixel_index == 290 || pixel_index == 292 || pixel_index == 297 || pixel_index == 299 || pixel_index == 302 || pixel_index == 309 || pixel_index == 311 || pixel_index == 315 || pixel_index == 317 || pixel_index == 320 || pixel_index == 322 || pixel_index == 350 || pixel_index == 357 || pixel_index == 362 || pixel_index == 369 || pixel_index == 371 || pixel_index == 375 || pixel_index == 377 || pixel_index == 380 || pixel_index == 382 || pixel_index == 389 || pixel_index == 394 || pixel_index == 396 || pixel_index == 399 || pixel_index == 401 || pixel_index == 406 || pixel_index == 414 || pixel_index == 419 || pixel_index == 447 || pixel_index == 449 || pixel_index == 454 || pixel_index == 456 || pixel_index == 459 || pixel_index == 461 || pixel_index == 477 || pixel_index == 479 || pixel_index == 489 || pixel_index == 491 || pixel_index == 494 || pixel_index == 496 || pixel_index == 501 || pixel_index == 503 || pixel_index == 507 || pixel_index == 509 || pixel_index == 512 || pixel_index == 514 || pixel_index == 542 || pixel_index == 549 || pixel_index == 551 || pixel_index == 554 || pixel_index == 556 || pixel_index == 561 || pixel_index == 563 || pixel_index == 567 || pixel_index == 569 || pixel_index == 572 || pixel_index == 579 || pixel_index == 581 || pixel_index == 588 || pixel_index == 591 || pixel_index == 598 || pixel_index == 609 || pixel_index == 611 || pixel_index == 639 || pixel_index == 641 || pixel_index == 646 || pixel_index == 648 || pixel_index == 651 || pixel_index == 653 || pixel_index == 660 || pixel_index == 669 || pixel_index == 671 || pixel_index == 677 || pixel_index == 681 || pixel_index == 686 || pixel_index == 693 || pixel_index == 699 || pixel_index == 737 || pixel_index == 741 || pixel_index == 746 || pixel_index == 753 || pixel_index == 759 || pixel_index == 785 || pixel_index == 792 || pixel_index == 798 || pixel_index == 845 || pixel_index == 858 || pixel_index == 863 || pixel_index == 873 || pixel_index == 926 || pixel_index == 929 || pixel_index == 933) oled_data = 16'b0010010101101001;
else if (pixel_index == 108 || pixel_index == 196 || pixel_index == 215 || pixel_index == 219 || pixel_index == 221 || pixel_index == 226 || pixel_index == 256 || pixel_index == 268 || pixel_index == 275 || pixel_index == 279 || pixel_index == 281 || pixel_index == 305 || pixel_index == 310 || pixel_index == 351 || pixel_index == 383 || pixel_index == 395 || pixel_index == 400 || pixel_index == 411 || pixel_index == 413 || pixel_index == 416 || pixel_index == 418 || pixel_index == 455 || pixel_index == 460 || pixel_index == 476 || pixel_index == 543 || pixel_index == 557 || pixel_index == 564 || pixel_index == 587 || pixel_index == 590 || pixel_index == 640 || pixel_index == 647 || pixel_index == 650 || pixel_index == 767 || pixel_index == 881) oled_data = 16'b0010010110101010;
else if (pixel_index == 124 || pixel_index == 184 || pixel_index == 286 || pixel_index == 298 || pixel_index == 388 || pixel_index == 492 || pixel_index == 495 || pixel_index == 550 || pixel_index == 573 || pixel_index == 652 || pixel_index == 659) oled_data = 16'b0010110110101001;
else if (pixel_index == 130 || pixel_index == 214 || pixel_index == 274 || pixel_index == 304 || pixel_index == 352 || pixel_index == 359 || pixel_index == 364 || pixel_index == 408 || pixel_index == 412 || pixel_index == 417 || pixel_index == 468 || pixel_index == 482 || pixel_index == 544 || pixel_index == 586 || pixel_index == 606 || pixel_index == 666 || pixel_index == 704 || pixel_index == 764) oled_data = 16'b0010110101101001;
else if (pixel_index == 139 || pixel_index == 147 || pixel_index == 233 || pixel_index == 237 || pixel_index == 241) oled_data = 16'b1001100000000101;
else if (pixel_index == 143 || pixel_index == 245) oled_data = 16'b1001000000000101;
else if (pixel_index == 324 || pixel_index == 346 || pixel_index == 420 || pixel_index == 442 || pixel_index == 538 || pixel_index == 708 || pixel_index == 730 || pixel_index == 804 || pixel_index == 826 || pixel_index == 900 || pixel_index == 922 || pixel_index == 1092 || pixel_index == 1114 || pixel_index == 1210 || pixel_index == 1284 || pixel_index == 1380 || ((pixel_index >= 1440) && (pixel_index <= 1443)) || pixel_index == 1445 || ((pixel_index >= 1447) && (pixel_index <= 1448)) || pixel_index == 1450 || ((pixel_index >= 1452) && (pixel_index <= 1453)) || ((pixel_index >= 1455) && (pixel_index <= 1458)) || pixel_index == 1460 || pixel_index == 1462 || ((pixel_index >= 1465) && (pixel_index <= 1467)) || ((pixel_index >= 1469) && (pixel_index <= 1470)) || pixel_index == 1472 || pixel_index == 1475 || ((pixel_index >= 1477) && (pixel_index <= 1479)) || ((pixel_index >= 1481) && (pixel_index <= 1493)) || ((pixel_index >= 1495) && (pixel_index <= 1497)) || ((pixel_index >= 1499) && (pixel_index <= 1502)) || pixel_index == 1504 || ((pixel_index >= 1506) && (pixel_index <= 1509)) || ((pixel_index >= 1511) && (pixel_index <= 1512)) || ((pixel_index >= 1515) && (pixel_index <= 1518)) || ((pixel_index >= 1520) && (pixel_index <= 1522)) || ((pixel_index >= 1525) && (pixel_index <= 1527)) || pixel_index == 1530 || pixel_index == 1532 || (pixel_index >= 1534) && (pixel_index <= 1535)) oled_data = 16'b0001000010000010;
else if (pixel_index == 325 || pixel_index == 327 || pixel_index == 329 || ((pixel_index >= 331) && (pixel_index <= 332)) || pixel_index == 335 || pixel_index == 337 || ((pixel_index >= 339) && (pixel_index <= 340)) || pixel_index == 342 || pixel_index == 344) oled_data = 16'b0011100000000010;
else if (pixel_index == 326 || pixel_index == 328 || pixel_index == 330 || ((pixel_index >= 333) && (pixel_index <= 334)) || pixel_index == 336 || pixel_index == 338 || pixel_index == 341 || pixel_index == 343 || pixel_index == 345) oled_data = 16'b0011000000000010;
else if (pixel_index == 421 || pixel_index == 423 || pixel_index == 425 || pixel_index == 428 || pixel_index == 431 || ((pixel_index >= 434) && (pixel_index <= 435)) || pixel_index == 438 || pixel_index == 441 || pixel_index == 518 || pixel_index == 633 || pixel_index == 715 || pixel_index == 825 || pixel_index == 1003 || pixel_index == 1096 || pixel_index == 1110 || pixel_index == 1289 || pixel_index == 1381) oled_data = 16'b1101010010100110;
else if (pixel_index == 422 || pixel_index == 424 || pixel_index == 533 || pixel_index == 537 || pixel_index == 613 || pixel_index == 622 || pixel_index == 624 || pixel_index == 729 || pixel_index == 997 || pixel_index == 1287 || pixel_index == 1303 || pixel_index == 1382) oled_data = 16'b1101110001000110;
else if (pixel_index == 426 || pixel_index == 429 || pixel_index == 432 || pixel_index == 437 || pixel_index == 440 || pixel_index == 535 || pixel_index == 805 || pixel_index == 1094 || pixel_index == 1108 || pixel_index == 1113 || pixel_index == 1191 || pixel_index == 1205 || pixel_index == 1285 || pixel_index == 1386 || pixel_index == 1400) oled_data = 16'b1101110010100110;
else if (pixel_index == 427 || pixel_index == 430 || pixel_index == 433 || pixel_index == 436 || pixel_index == 521 || pixel_index == 524 || pixel_index == 527 || pixel_index == 530 || pixel_index == 619 || pixel_index == 621 || pixel_index == 625 || pixel_index == 627 || pixel_index == 709 || pixel_index == 811 || pixel_index == 819 || pixel_index == 907 || pixel_index == 1011 || pixel_index == 1017 || pixel_index == 1093 || pixel_index == 1095 || ((pixel_index >= 1097) && (pixel_index <= 1098)) || pixel_index == 1109 || ((pixel_index >= 1111) && (pixel_index <= 1112)) || pixel_index == 1189 || pixel_index == 1194 || pixel_index == 1203 || pixel_index == 1208 || pixel_index == 1288 || pixel_index == 1291 || pixel_index == 1300 || pixel_index == 1302 || pixel_index == 1305 || pixel_index == 1385 || pixel_index == 1395 || pixel_index == 1397 || pixel_index == 1399) oled_data = 16'b1101010001000110;
else if (pixel_index == 439 || pixel_index == 517 || pixel_index == 522 || pixel_index == 525 || pixel_index == 528 || pixel_index == 534 || pixel_index == 536 || pixel_index == 921 || pixel_index == 1107 || pixel_index == 1190 || pixel_index == 1192 || pixel_index == 1204 || pixel_index == 1206 || pixel_index == 1286 || pixel_index == 1387 || pixel_index == 1401) oled_data = 16'b1101010001000101;
else if (pixel_index == 472) oled_data = 16'b0010110101101010;
else if (pixel_index == 498 || pixel_index == 559 || pixel_index == 595 || pixel_index == 654 || pixel_index == 661 || pixel_index == 673 || pixel_index == 679 || pixel_index == 685 || pixel_index == 697 || pixel_index == 732 || pixel_index == 739 || pixel_index == 757 || pixel_index == 768 || pixel_index == 776 || pixel_index == 786 || pixel_index == 828 || pixel_index == 836 || pixel_index == 841 || pixel_index == 846 || pixel_index == 865 || pixel_index == 877 || pixel_index == 883 || pixel_index == 889 || pixel_index == 894 || pixel_index == 925 || pixel_index == 931 || pixel_index == 943 || pixel_index == 949 || pixel_index == 954 || ((pixel_index >= 959) && (pixel_index <= 960)) || pixel_index == 968 || pixel_index == 974 || pixel_index == 978 || pixel_index == 984 || pixel_index == 990 || pixel_index == 995 || pixel_index == 1028 || pixel_index == 1033 || pixel_index == 1038 || pixel_index == 1044 || pixel_index == 1050 || ((pixel_index >= 1055) && (pixel_index <= 1056)) || pixel_index == 1063 || pixel_index == 1069 || pixel_index == 1080 || ((pixel_index >= 1086) && (pixel_index <= 1087)) || pixel_index == 1091 || ((pixel_index >= 1116) && (pixel_index <= 1117)) || ((pixel_index >= 1129) && (pixel_index <= 1130)) || pixel_index == 1134 || pixel_index == 1140 || pixel_index == 1146 || ((pixel_index >= 1151) && (pixel_index <= 1153)) || ((pixel_index >= 1159) && (pixel_index <= 1160)) || pixel_index == 1170 || pixel_index == 1176 || pixel_index == 1187 || ((pixel_index >= 1219) && (pixel_index <= 1220)) || pixel_index == 1226 || pixel_index == 1231 || pixel_index == 1236 || pixel_index == 1243 || pixel_index == 1249 || pixel_index == 1256 || ((pixel_index >= 1261) && (pixel_index <= 1262)) || pixel_index == 1266 || ((pixel_index >= 1272) && (pixel_index <= 1273)) || ((pixel_index >= 1278) && (pixel_index <= 1279)) || pixel_index == 1283 || ((pixel_index >= 1308) && (pixel_index <= 1309)) || pixel_index == 1321 || pixel_index == 1326 || pixel_index == 1332 || pixel_index == 1338) oled_data = 16'b0101100110000100;
else if (pixel_index == 499 || pixel_index == 558 || pixel_index == 594 || pixel_index == 601 || pixel_index == 655 || pixel_index == 672 || pixel_index == 680 || pixel_index == 690 || pixel_index == 733 || pixel_index == 740 || pixel_index == 745 || pixel_index == 750 || pixel_index == 769 || pixel_index == 775 || pixel_index == 781 || pixel_index == 787 || pixel_index == 793 || pixel_index == 799 || pixel_index == 829 || pixel_index == 835 || pixel_index == 847 || pixel_index == 853 || pixel_index == 859 || pixel_index == 864 || pixel_index == 882 || pixel_index == 899 || pixel_index == 937 || pixel_index == 942 || pixel_index == 961 || pixel_index == 967 || pixel_index == 973 || pixel_index == 979 || pixel_index == 985 || pixel_index == 991 || ((pixel_index >= 1020) && (pixel_index <= 1021)) || pixel_index == 1027 || pixel_index == 1034 || pixel_index == 1039 || pixel_index == 1045 || pixel_index == 1051 || pixel_index == 1070 || pixel_index == 1074 || pixel_index == 1124 || pixel_index == 1147 || pixel_index == 1166 || pixel_index == 1171 || pixel_index == 1177 || pixel_index == 1183 || pixel_index == 1212 || pixel_index == 1230 || pixel_index == 1237 || ((pixel_index >= 1247) && (pixel_index <= 1248)) || pixel_index == 1255 || pixel_index == 1315 || pixel_index == 1322 || pixel_index == 1327 || pixel_index == 1333 || pixel_index == 1339) oled_data = 16'b0110000110000100;
else if (pixel_index == 502 || pixel_index == 610) oled_data = 16'b0010110110101010;
else if (pixel_index == 516) oled_data = 16'b0001100010000011;
else if (pixel_index == 519 || pixel_index == 531 || pixel_index == 1099 || pixel_index == 1209 || pixel_index == 1290 || pixel_index == 1301 || pixel_index == 1384) oled_data = 16'b1101110001000101;
else if (pixel_index == 520 || pixel_index == 532 || pixel_index == 623 || pixel_index == 723 || pixel_index == 901 || pixel_index == 915 || pixel_index == 1195 || pixel_index == 1304 || pixel_index == 1383 || pixel_index == 1398) oled_data = 16'b1101010010100101;
else if (pixel_index == 523 || pixel_index == 526 || pixel_index == 529 || pixel_index == 620 || pixel_index == 626 || pixel_index == 1193 || pixel_index == 1207 || pixel_index == 1299 || pixel_index == 1396) oled_data = 16'b1101110010100101;
else if (pixel_index == 612 || pixel_index == 996 || pixel_index == 1018 || pixel_index == 1306 || pixel_index == 1446 || pixel_index == 1449 || pixel_index == 1464 || pixel_index == 1471 || pixel_index == 1474 || pixel_index == 1480 || pixel_index == 1513 || pixel_index == 1519 || pixel_index == 1524 || pixel_index == 1528 || pixel_index == 1531) oled_data = 16'b0001000011000010;
else if (((pixel_index >= 614) && (pixel_index <= 618)) || ((pixel_index >= 628) && (pixel_index <= 631)) || pixel_index == 710 || pixel_index == 712 || pixel_index == 714 || pixel_index == 728 || ((pixel_index >= 806) && (pixel_index <= 810)) || ((pixel_index >= 820) && (pixel_index <= 824)) || pixel_index == 902 || pixel_index == 904 || pixel_index == 906 || pixel_index == 916 || pixel_index == 918 || pixel_index == 920 || ((pixel_index >= 999) && (pixel_index <= 1002)) || (pixel_index >= 1012) && (pixel_index <= 1016)) oled_data = 16'b0010000101000101;
else if (pixel_index == 632 || pixel_index == 998) oled_data = 16'b0001100101000101;
else if (pixel_index == 634 || pixel_index == 1402 || pixel_index == 1494) oled_data = 16'b0001100010000010;
else if (((pixel_index >= 682) && (pixel_index <= 683)) || ((pixel_index >= 694) && (pixel_index <= 695)) || ((pixel_index >= 700) && (pixel_index <= 701)) || ((pixel_index >= 705) && (pixel_index <= 706)) || ((pixel_index >= 742) && (pixel_index <= 743)) || ((pixel_index >= 754) && (pixel_index <= 755)) || ((pixel_index >= 760) && (pixel_index <= 761)) || ((pixel_index >= 765) && (pixel_index <= 766)) || ((pixel_index >= 771) && (pixel_index <= 772)) || ((pixel_index >= 778) && (pixel_index <= 779)) || pixel_index == 791 || pixel_index == 796 || pixel_index == 801 || ((pixel_index >= 813) && (pixel_index <= 817)) || ((pixel_index >= 831) && (pixel_index <= 832)) || ((pixel_index >= 838) && (pixel_index <= 839)) || ((pixel_index >= 850) && (pixel_index <= 851)) || ((pixel_index >= 856) && (pixel_index <= 857)) || ((pixel_index >= 861) && (pixel_index <= 862)) || ((pixel_index >= 867) && (pixel_index <= 868)) || ((pixel_index >= 874) && (pixel_index <= 875)) || ((pixel_index >= 886) && (pixel_index <= 887)) || ((pixel_index >= 892) && (pixel_index <= 893)) || ((pixel_index >= 897) && (pixel_index <= 898)) || ((pixel_index >= 909) && (pixel_index <= 910)) || ((pixel_index >= 912) && (pixel_index <= 913)) || ((pixel_index >= 927) && (pixel_index <= 928)) || ((pixel_index >= 934) && (pixel_index <= 935)) || ((pixel_index >= 946) && (pixel_index <= 947)) || ((pixel_index >= 952) && (pixel_index <= 953)) || pixel_index == 957 || ((pixel_index >= 963) && (pixel_index <= 964)) || pixel_index == 970 || ((pixel_index >= 982) && (pixel_index <= 983)) || ((pixel_index >= 988) && (pixel_index <= 989)) || ((pixel_index >= 993) && (pixel_index <= 994)) || ((pixel_index >= 1005) && (pixel_index <= 1009)) || ((pixel_index >= 1023) && (pixel_index <= 1024)) || ((pixel_index >= 1030) && (pixel_index <= 1031)) || ((pixel_index >= 1042) && (pixel_index <= 1043)) || ((pixel_index >= 1048) && (pixel_index <= 1049)) || ((pixel_index >= 1053) && (pixel_index <= 1054)) || ((pixel_index >= 1059) && (pixel_index <= 1060)) || ((pixel_index >= 1066) && (pixel_index <= 1067)) || ((pixel_index >= 1078) && (pixel_index <= 1079)) || ((pixel_index >= 1084) && (pixel_index <= 1085)) || ((pixel_index >= 1089) && (pixel_index <= 1090)) || pixel_index == 1101 || pixel_index == 1103 || pixel_index == 1105 || ((pixel_index >= 1119) && (pixel_index <= 1120)) || pixel_index == 1126 || ((pixel_index >= 1138) && (pixel_index <= 1139)) || ((pixel_index >= 1144) && (pixel_index <= 1145)) || pixel_index == 1150 || ((pixel_index >= 1155) && (pixel_index <= 1156)) || ((pixel_index >= 1162) && (pixel_index <= 1163)) || ((pixel_index >= 1174) && (pixel_index <= 1175)) || ((pixel_index >= 1180) && (pixel_index <= 1181)) || ((pixel_index >= 1185) && (pixel_index <= 1186)) || ((pixel_index >= 1197) && (pixel_index <= 1201)) || ((pixel_index >= 1215) && (pixel_index <= 1216)) || ((pixel_index >= 1222) && (pixel_index <= 1223)) || ((pixel_index >= 1234) && (pixel_index <= 1235)) || ((pixel_index >= 1240) && (pixel_index <= 1241)) || ((pixel_index >= 1245) && (pixel_index <= 1246)) || pixel_index == 1251 || ((pixel_index >= 1258) && (pixel_index <= 1259)) || ((pixel_index >= 1270) && (pixel_index <= 1271)) || ((pixel_index >= 1276) && (pixel_index <= 1277)) || ((pixel_index >= 1281) && (pixel_index <= 1282)) || pixel_index == 1293 || pixel_index == 1295 || pixel_index == 1311 || ((pixel_index >= 1318) && (pixel_index <= 1319)) || ((pixel_index >= 1330) && (pixel_index <= 1331)) || ((pixel_index >= 1336) && (pixel_index <= 1337)) || ((pixel_index >= 1341) && (pixel_index <= 1342)) || ((pixel_index >= 1347) && (pixel_index <= 1348)) || ((pixel_index >= 1354) && (pixel_index <= 1355)) || ((pixel_index >= 1366) && (pixel_index <= 1367)) || ((pixel_index >= 1372) && (pixel_index <= 1373)) || ((pixel_index >= 1377) && (pixel_index <= 1378)) || ((pixel_index >= 1389) && (pixel_index <= 1393)) || ((pixel_index >= 1407) && (pixel_index <= 1408)) || ((pixel_index >= 1414) && (pixel_index <= 1415)) || pixel_index == 1427 || ((pixel_index >= 1432) && (pixel_index <= 1433)) || (pixel_index >= 1437) && (pixel_index <= 1438)) oled_data = 16'b0111101000000101;
else if (pixel_index == 687 || pixel_index == 747 || pixel_index == 844 || pixel_index == 879 || pixel_index == 1035 || pixel_index == 1072 || pixel_index == 1132 || pixel_index == 1264 || pixel_index == 1324) oled_data = 16'b1001101011001000;
else if (pixel_index == 688 || pixel_index == 748 || ((pixel_index >= 783) && (pixel_index <= 784)) || pixel_index == 843 || pixel_index == 880 || ((pixel_index >= 939) && (pixel_index <= 940)) || ((pixel_index >= 975) && (pixel_index <= 976)) || pixel_index == 1036 || pixel_index == 1071 || pixel_index == 1131 || ((pixel_index >= 1167) && (pixel_index <= 1168)) || ((pixel_index >= 1227) && (pixel_index <= 1228)) || pixel_index == 1263 || pixel_index == 1323 || ((pixel_index >= 1359) && (pixel_index <= 1360)) || (pixel_index >= 1419) && (pixel_index <= 1420)) oled_data = 16'b1001101011000111;
else if (pixel_index == 691 || pixel_index == 751 || pixel_index == 895 || pixel_index == 924 || pixel_index == 955 || pixel_index == 1075 || pixel_index == 1081 || pixel_index == 1123 || pixel_index == 1141 || pixel_index == 1165 || pixel_index == 1182 || pixel_index == 1242 || pixel_index == 1316 || pixel_index == 1343) oled_data = 16'b0101100111000100;
else if (pixel_index == 711 || pixel_index == 713 || pixel_index == 727 || pixel_index == 903 || pixel_index == 917) oled_data = 16'b1001011010111101;
else if (pixel_index == 716 || pixel_index == 722 || pixel_index == 914 || pixel_index == 1004 || pixel_index == 1298) oled_data = 16'b0010100010000010;
else if (pixel_index == 717 || pixel_index == 720 || pixel_index == 908) oled_data = 16'b0010100011000001;
else if (((pixel_index >= 718) && (pixel_index <= 719)) || pixel_index == 721 || pixel_index == 812 || pixel_index == 818 || pixel_index == 1010 || pixel_index == 1100 || pixel_index == 1106 || pixel_index == 1196 || pixel_index == 1202 || pixel_index == 1292 || pixel_index == 1388 || pixel_index == 1394) oled_data = 16'b0010100011000010;
else if (pixel_index == 724 || pixel_index == 726) oled_data = 16'b0010000101000110;
else if (pixel_index == 725) oled_data = 16'b1001011010111100;
else if (pixel_index == 790 || pixel_index == 797 || pixel_index == 958 || pixel_index == 1296) oled_data = 16'b0111101000000110;
else if (pixel_index == 802 || pixel_index == 911 || pixel_index == 971 || pixel_index == 1104 || pixel_index == 1127 || pixel_index == 1149 || pixel_index == 1252 || pixel_index == 1294 || pixel_index == 1297 || pixel_index == 1312 || pixel_index == 1426) oled_data = 16'b0111001000000101;
else if (pixel_index == 871 || pixel_index == 1267) oled_data = 16'b0101100110000011;
else if (pixel_index == 872 || pixel_index == 932 || pixel_index == 1057 || pixel_index == 1064 || pixel_index == 1135 || pixel_index == 1213 || pixel_index == 1225) oled_data = 16'b0110000111000100;
else if (pixel_index == 905 || pixel_index == 919) oled_data = 16'b1001011011111101;
else if (pixel_index == 1102) oled_data = 16'b1111111000100010;
else if (pixel_index == 1188 || pixel_index == 1459) oled_data = 16'b0001100011000010;
else if (pixel_index == 1444 || pixel_index == 1451 || pixel_index == 1454 || pixel_index == 1463 || pixel_index == 1473 || pixel_index == 1476 || pixel_index == 1498 || pixel_index == 1505 || pixel_index == 1510 || pixel_index == 1514 || pixel_index == 1523 || pixel_index == 1529 || pixel_index == 1533) oled_data = 16'b0001000010000011;
else if (pixel_index == 1468 || pixel_index == 1503) oled_data = 16'b0001000011000011;
else if (pixel_index == 1579 || pixel_index == 1587 || pixel_index == 1779 || pixel_index == 1867 || pixel_index == 2067 || pixel_index == 2155 || pixel_index == 2347 || pixel_index == 2355 || pixel_index == 2635 || pixel_index == 2643 || pixel_index == 2923 || pixel_index == 3211 || pixel_index == 3412 || pixel_index == 3415 || pixel_index == 3417 || pixel_index == 3419 || pixel_index == 3421 || pixel_index == 3423 || pixel_index == 3425 || pixel_index == 3427 || pixel_index == 3429 || pixel_index == 3431 || pixel_index == 3433 || pixel_index == 3435 || pixel_index == 3437 || pixel_index == 3439 || pixel_index == 3441 || pixel_index == 3443 || pixel_index == 3445 || pixel_index == 3447 || pixel_index == 3449 || pixel_index == 3451 || pixel_index == 3453 || pixel_index == 3787 || pixel_index == 4075 || pixel_index == 4084 || pixel_index == 4087 || pixel_index == 4090 || pixel_index == 4102 || pixel_index == 4105 || pixel_index == 4108 || pixel_index == 4111 || pixel_index == 4114 || pixel_index == 4118 || pixel_index == 4122 || pixel_index == 4126 || pixel_index == 4267 || pixel_index == 4275 || pixel_index == 4555 || pixel_index == 4563 || pixel_index == 4843 || pixel_index == 4851 || pixel_index == 5035 || pixel_index == 5139 || pixel_index == 5323 || pixel_index == 5427 || pixel_index == 5515 || pixel_index == 5715 || pixel_index == 5803 || pixel_index == 5995 || pixel_index == 6003) oled_data = 16'b1101011000101110;
else if (pixel_index == 1675 || pixel_index == 1683 || pixel_index == 1771 || pixel_index == 1875 || pixel_index == 1963 || pixel_index == 1971 || pixel_index == 2059 || pixel_index == 2163 || pixel_index == 2251 || pixel_index == 2259 || pixel_index == 2443 || pixel_index == 2539 || pixel_index == 2547 || pixel_index == 2731 || pixel_index == 2739 || pixel_index == 2827 || pixel_index == 2835 || pixel_index == 3019 || pixel_index == 3027 || pixel_index == 3115 || pixel_index == 3123 || pixel_index == 3307 || pixel_index == 3315 || pixel_index == 3403 || ((pixel_index >= 3413) && (pixel_index <= 3414)) || pixel_index == 3418 || pixel_index == 3420 || pixel_index == 3422 || pixel_index == 3424 || pixel_index == 3426 || pixel_index == 3428 || pixel_index == 3430 || pixel_index == 3432 || pixel_index == 3434 || pixel_index == 3436 || pixel_index == 3438 || pixel_index == 3440 || pixel_index == 3442 || pixel_index == 3444 || pixel_index == 3446 || pixel_index == 3448 || pixel_index == 3450 || pixel_index == 3452 || ((pixel_index >= 3454) && (pixel_index <= 3455)) || pixel_index == 3595 || pixel_index == 3691 || pixel_index == 3883 || pixel_index == 3979 || pixel_index == 4085 || pixel_index == 4091 || pixel_index == 4093 || pixel_index == 4095 || pixel_index == 4097 || pixel_index == 4099 || pixel_index == 4101 || pixel_index == 4104 || pixel_index == 4107 || pixel_index == 4109 || ((pixel_index >= 4112) && (pixel_index <= 4113)) || ((pixel_index >= 4116) && (pixel_index <= 4117)) || ((pixel_index >= 4120) && (pixel_index <= 4121)) || ((pixel_index >= 4124) && (pixel_index <= 4125)) || pixel_index == 4127 || pixel_index == 4171 || pixel_index == 4179 || pixel_index == 4363 || pixel_index == 4459 || pixel_index == 4467 || pixel_index == 4651 || pixel_index == 4755 || pixel_index == 4939 || pixel_index == 5043 || pixel_index == 5131 || pixel_index == 5227 || pixel_index == 5235 || pixel_index == 5419 || pixel_index == 5611 || pixel_index == 5707 || pixel_index == 5811 || pixel_index == 5899 || pixel_index == 6091) oled_data = 16'b1101010111101110;
else if (pixel_index == 2451 || pixel_index == 3416 || pixel_index == 4083 || pixel_index == 4086 || pixel_index == 4089 || pixel_index == 4096 || pixel_index == 4100 || pixel_index == 4103 || pixel_index == 4106 || pixel_index == 4110 || pixel_index == 4115 || pixel_index == 4119 || pixel_index == 4123 || pixel_index == 4659 || pixel_index == 4747 || pixel_index == 5331 || pixel_index == 5619 || pixel_index == 5907) oled_data = 16'b1100110111101110;
else if (pixel_index == 2931 || pixel_index == 3219 || pixel_index == 3499 || pixel_index == 4094 || pixel_index == 4098) oled_data = 16'b1100111000101110;
else if (pixel_index == 3411 || pixel_index == 4088 || pixel_index == 5523 || pixel_index == 6099) oled_data = 16'b1101010111101101;
else if (pixel_index == 4092 || pixel_index == 4371 || pixel_index == 4947) oled_data = 16'b1100110111101101; 
/*if (y > 3 && y < 8) oled_data = 16'b0010010110101001;
if (y > 3 && y < 15 && x > 36 && x < 58) oled_data = 16'b1101010010100110;

if (pixel_index == 0 || pixel_index == 7 || pixel_index == 12 || pixel_index == 17 || pixel_index == 23 || pixel_index == 28 || pixel_index == 32 || pixel_index == 35 || pixel_index == 37 || pixel_index == 59 || pixel_index == 66 || pixel_index == 73 || pixel_index == 75 || pixel_index == 78 || pixel_index == 80 || pixel_index == 84 || pixel_index == 86 || pixel_index == 89 || pixel_index == 91 || ((pixel_index >= 103) && (pixel_index <= 104)) || pixel_index == 115 || pixel_index == 122 || pixel_index == 133 || pixel_index == 156 || pixel_index == 163 || pixel_index == 175 || pixel_index == 182 || pixel_index == 192 || pixel_index == 198 || pixel_index == 218 || pixel_index == 251 || pixel_index == 278 || pixel_index == 295 || pixel_index == 306 || pixel_index == 348 || pixel_index == 355 || pixel_index == 367 || pixel_index == 384 || pixel_index == 391 || pixel_index == 403 || pixel_index == 452 || pixel_index == 463 || pixel_index == 470 || pixel_index == 481 || ((pixel_index >= 487) && (pixel_index <= 488)) || pixel_index == 493 || pixel_index == 500 || pixel_index == 506 || pixel_index == 540 || pixel_index == 553 || pixel_index == 560 || pixel_index == 565 || pixel_index == 576 || pixel_index == 582 || ((pixel_index >= 636) && (pixel_index <= 637)) || pixel_index == 642 || pixel_index == 656 || pixel_index == 692 || pixel_index == 703 || pixel_index == 827 || pixel_index == 834 || pixel_index == 1 || pixel_index == 6 || pixel_index == 13 || pixel_index == 15 || pixel_index == 18 || pixel_index == 20 || pixel_index == 24 || pixel_index == 26 || pixel_index == 29 || pixel_index == 31 || pixel_index == 34 || pixel_index == 60 || pixel_index == 62 || pixel_index == 67 || pixel_index == 72 || pixel_index == 77 || pixel_index == 83 || pixel_index == 88 || pixel_index == 92 || pixel_index == 96 || pixel_index == 116 || pixel_index == 121 || pixel_index == 127 || pixel_index == 132 || pixel_index == 157 || pixel_index == 164 || pixel_index == 176 || pixel_index == 181 || pixel_index == 187 || pixel_index == 193 || pixel_index == 200 || pixel_index == 205 || pixel_index == 210 || pixel_index == 212 || pixel_index == 252 || pixel_index == 258 || pixel_index == 260 || pixel_index == 265 || pixel_index == 270 || pixel_index == 272 || pixel_index == 288 || pixel_index == 296 || pixel_index == 307 || pixel_index == 313 || pixel_index == 319 || pixel_index == 349 || pixel_index == 354 || pixel_index == 366 || pixel_index == 373 || pixel_index == 379 || pixel_index == 385 || pixel_index == 390 || pixel_index == 397 || pixel_index == 404 || pixel_index == 410 || pixel_index == 443 || pixel_index == 445 || pixel_index == 451 || pixel_index == 457 || pixel_index == 464 || pixel_index == 505 || pixel_index == 511 || pixel_index == 539 || pixel_index == 546 || pixel_index == 548 || pixel_index == 566 || pixel_index == 571 || pixel_index == 584 || pixel_index == 596 || pixel_index == 602 || pixel_index == 643 || pixel_index == 662 || pixel_index == 678 || pixel_index == 731 || pixel_index == 752 || pixel_index == 763 || pixel_index == 2 || pixel_index == 14 || pixel_index == 19 || pixel_index == 25 || pixel_index == 30 || pixel_index == 61 || pixel_index == 68 || pixel_index == 97 || pixel_index == 109 || pixel_index == 211 || pixel_index == 253 || pixel_index == 259 || pixel_index == 271 || pixel_index == 283 || pixel_index == 289 || pixel_index == 308 || pixel_index == 314 || pixel_index == 374 || pixel_index == 409 || pixel_index == 415 || pixel_index == 444 || pixel_index == 450 || pixel_index == 547 || pixel_index == 644 || pixel_index == 667 || pixel_index == 698 || pixel_index == 758) oled_data = 16'b0001101010000100;
else if (pixel_index == 8 || pixel_index == 36 || pixel_index == 74 || pixel_index == 79 || pixel_index == 85 || pixel_index == 90 || pixel_index == 102 || pixel_index == 114 || pixel_index == 155 || pixel_index == 162 || pixel_index == 169 || pixel_index == 174 || pixel_index == 199 || pixel_index == 217 || pixel_index == 223 || pixel_index == 228 || pixel_index == 277 || pixel_index == 294 || pixel_index == 301 || pixel_index == 347 || pixel_index == 356 || pixel_index == 361 || pixel_index == 368 || pixel_index == 392 || pixel_index == 402 || pixel_index == 462 || pixel_index == 469 || pixel_index == 475 || pixel_index == 480 || pixel_index == 486 || pixel_index == 541 || pixel_index == 577 || pixel_index == 583 || pixel_index == 589 || pixel_index == 607 || pixel_index == 635 || pixel_index == 649 || pixel_index == 738 || pixel_index == 774) oled_data = 16'b0001101010000101;
else if (pixel_index == 40 || ((pixel_index >= 42) && (pixel_index <= 43)) || pixel_index == 45 || ((pixel_index >= 47) && (pixel_index <= 48)) || pixel_index == 50 || ((pixel_index >= 52) && (pixel_index <= 53)) || pixel_index == 135 || pixel_index == 137 || pixel_index == 140 || pixel_index == 142 || ((pixel_index >= 144) && (pixel_index <= 145)) || ((pixel_index >= 149) && (pixel_index <= 151)) || pixel_index == 230 || pixel_index == 232 || pixel_index == 235 || ((pixel_index >= 238) && (pixel_index <= 239)) || pixel_index == 242 || pixel_index == 244 || pixel_index == 246 || pixel_index == 248) oled_data = 16'b1001100000000110;
else if (pixel_index == 41 || pixel_index == 44 || pixel_index == 46 || pixel_index == 49 || pixel_index == 51 || pixel_index == 54 || pixel_index == 136 || pixel_index == 138 || pixel_index == 141 || pixel_index == 146 || pixel_index == 148 || pixel_index == 231 || pixel_index == 234 || pixel_index == 236 || pixel_index == 240 || pixel_index == 243 || pixel_index == 247) oled_data = 16'b1001000000000110;
else if (pixel_index == 98 || pixel_index == 202 || pixel_index == 207 || pixel_index == 262 || pixel_index == 285 || pixel_index == 798 || pixel_index == 876 || pixel_index == 888 || pixel_index == 929 || pixel_index == 936) oled_data = 16'b0010010101101010;
else if (pixel_index == 99 || pixel_index == 101 || pixel_index == 106 || pixel_index == 111 || pixel_index == 113 || pixel_index == 118 || pixel_index == 120 || pixel_index == 126 || pixel_index == 129 || pixel_index == 131 || pixel_index == 159 || pixel_index == 161 || pixel_index == 166 || pixel_index == 168 || pixel_index == 171 || pixel_index == 173 || pixel_index == 178 || pixel_index == 180 || pixel_index == 186 || pixel_index == 189 || pixel_index == 191 || pixel_index == 194 || pixel_index == 201 || pixel_index == 203 || pixel_index == 206 || pixel_index == 208 || pixel_index == 213 || pixel_index == 224 || pixel_index == 254 || pixel_index == 261 || pixel_index == 263 || pixel_index == 266 || pixel_index == 273 || pixel_index == 284 || pixel_index == 291 || pixel_index == 293 || pixel_index == 300 || pixel_index == 303 || pixel_index == 312 || pixel_index == 316 || pixel_index == 318 || pixel_index == 321 || pixel_index == 323 || pixel_index == 353 || pixel_index == 358 || pixel_index == 360 || pixel_index == 363 || pixel_index == 365 || pixel_index == 370 || pixel_index == 372 || pixel_index == 376 || pixel_index == 378 || pixel_index == 381 || pixel_index == 770 || pixel_index == 777 || pixel_index == 780 || pixel_index == 782 || pixel_index == 789 || pixel_index == 792 || pixel_index == 795 || pixel_index == 800 || pixel_index == 833 || pixel_index == 837 || pixel_index == 840 || pixel_index == 842 || pixel_index == 849 || pixel_index == 852 || pixel_index == 855 || pixel_index == 860 || pixel_index == 863 || pixel_index == 866 || pixel_index == 869 || pixel_index == 873 || pixel_index == 881 || pixel_index == 933 || pixel_index == 941) oled_data = 16'b0010010110101001;
else if (pixel_index == 100 || pixel_index == 105 || pixel_index == 107 || pixel_index == 110 || pixel_index == 112 || pixel_index == 117 || pixel_index == 119 || pixel_index == 123 || pixel_index == 125 || pixel_index == 128 || pixel_index == 158 || pixel_index == 160 || pixel_index == 165 || pixel_index == 167 || pixel_index == 170 || pixel_index == 172 || pixel_index == 177 || pixel_index == 179 || pixel_index == 183 || pixel_index == 185 || pixel_index == 188 || pixel_index == 190 || pixel_index == 195 || pixel_index == 197 || pixel_index == 204 || pixel_index == 209 || pixel_index == 216 || pixel_index == 220 || pixel_index == 222 || pixel_index == 225 || pixel_index == 227 || pixel_index == 255 || pixel_index == 257 || pixel_index == 264 || pixel_index == 267 || pixel_index == 269 || pixel_index == 276 || pixel_index == 280 || pixel_index == 282 || pixel_index == 287 || pixel_index == 290 || pixel_index == 292 || pixel_index == 297 || pixel_index == 299 || pixel_index == 302 || pixel_index == 309 || pixel_index == 311 || pixel_index == 315 || pixel_index == 317 || pixel_index == 320 || pixel_index == 322 || pixel_index == 350 || pixel_index == 357 || pixel_index == 362 || pixel_index == 369 || pixel_index == 371 || pixel_index == 375 || pixel_index == 377 || pixel_index == 380 || pixel_index == 382 || pixel_index == 773 || pixel_index == 785 || pixel_index == 830 || pixel_index == 845 || pixel_index == 858 || pixel_index == 878 || pixel_index == 885 || pixel_index == 938 || pixel_index == 945 || pixel_index == 948) oled_data = 16'b0010010101101001;
else if (pixel_index == 108 || pixel_index == 196 || pixel_index == 215 || pixel_index == 219 || pixel_index == 221 || pixel_index == 226 || pixel_index == 256 || pixel_index == 268 || pixel_index == 275 || pixel_index == 279 || pixel_index == 281 || pixel_index == 305 || pixel_index == 310 || pixel_index == 351 || pixel_index == 383 || pixel_index == 803) oled_data = 16'b0010010110101010;
else if (pixel_index == 124 || pixel_index == 184 || pixel_index == 286 || pixel_index == 298 || pixel_index == 926) oled_data = 16'b0010110110101001;
else if (pixel_index == 130 || pixel_index == 214 || pixel_index == 274 || pixel_index == 304 || pixel_index == 352 || pixel_index == 359 || pixel_index == 364) oled_data = 16'b0010110101101001;
else if (pixel_index == 139 || pixel_index == 147 || pixel_index == 233 || pixel_index == 237 || pixel_index == 241) oled_data = 16'b1001100000000101;
else if (pixel_index == 143 || pixel_index == 245) oled_data = 16'b1001000000000101;
else if (pixel_index == 324 || pixel_index == 346 || pixel_index == 420 || pixel_index == 538 || pixel_index == 634 || pixel_index == 708 || pixel_index == 730 || pixel_index == 804 || pixel_index == 826 || pixel_index == 900 || pixel_index == 922 || pixel_index == 1188 || pixel_index == 1210 || pixel_index == 1306 || pixel_index == 1402 || ((pixel_index >= 1440) && (pixel_index <= 1441)) || pixel_index == 1443 || ((pixel_index >= 1445) && (pixel_index <= 1446)) || ((pixel_index >= 1448) && (pixel_index <= 1449)) || ((pixel_index >= 1452) && (pixel_index <= 1454)) || ((pixel_index >= 1456) && (pixel_index <= 1460)) || pixel_index == 1462 || ((pixel_index >= 1464) && (pixel_index <= 1468)) || ((pixel_index >= 1470) && (pixel_index <= 1472)) || ((pixel_index >= 1475) && (pixel_index <= 1478)) || ((pixel_index >= 1480) && (pixel_index <= 1486)) || ((pixel_index >= 1488) && (pixel_index <= 1496)) || ((pixel_index >= 1498) && (pixel_index <= 1503)) || pixel_index == 1505 || ((pixel_index >= 1507) && (pixel_index <= 1508)) || ((pixel_index >= 1510) && (pixel_index <= 1511)) || ((pixel_index >= 1513) && (pixel_index <= 1514)) || ((pixel_index >= 1516) && (pixel_index <= 1521)) || ((pixel_index >= 1523) && (pixel_index <= 1527)) || ((pixel_index >= 1529) && (pixel_index <= 1532)) || (pixel_index >= 1534) && (pixel_index <= 1535)) oled_data = 16'b0001000010000010;
else if (pixel_index == 325 || pixel_index == 327 || pixel_index == 329 || ((pixel_index >= 331) && (pixel_index <= 332)) || pixel_index == 335 || pixel_index == 337 || ((pixel_index >= 339) && (pixel_index <= 340)) || pixel_index == 342 || pixel_index == 344) oled_data = 16'b0011100000000010;
else if (pixel_index == 326 || pixel_index == 328 || pixel_index == 330 || ((pixel_index >= 333) && (pixel_index <= 334)) || pixel_index == 336 || pixel_index == 338 || pixel_index == 341 || pixel_index == 343 || pixel_index == 345) oled_data = 16'b0011000000000010;
else if (pixel_index == 421) oled_data = 16'b1101010010100110;
else if (pixel_index == 442 || pixel_index == 1018 || pixel_index == 1092 || pixel_index == 1380 || pixel_index == 1442 || pixel_index == 1447 || pixel_index == 1451 || pixel_index == 1463 || pixel_index == 1473 || pixel_index == 1506 || pixel_index == 1509 || pixel_index == 1512 || pixel_index == 1522) oled_data = 16'b0001000011000010;
else if (pixel_index == 498 || pixel_index == 558 || pixel_index == 594 || pixel_index == 654 || ((pixel_index >= 672) && (pixel_index <= 673)) || pixel_index == 680 || pixel_index == 685 || pixel_index == 691 || pixel_index == 697 || pixel_index == 733 || ((pixel_index >= 739) && (pixel_index <= 740)) || pixel_index == 745 || pixel_index == 751 || pixel_index == 757 || pixel_index == 769 || pixel_index == 836 || pixel_index == 864 || ((pixel_index >= 871) && (pixel_index <= 872)) || pixel_index == 877 || pixel_index == 883 || pixel_index == 889 || ((pixel_index >= 894) && (pixel_index <= 895)) || pixel_index == 899 || pixel_index == 925 || pixel_index == 931 || pixel_index == 937 || pixel_index == 943 || pixel_index == 949 || ((pixel_index >= 954) && (pixel_index <= 955)) || pixel_index == 959 || pixel_index == 961 || pixel_index == 968 || pixel_index == 973 || pixel_index == 978 || pixel_index == 990 || pixel_index == 995 || pixel_index == 1020 || pixel_index == 1028 || pixel_index == 1033 || pixel_index == 1038 || pixel_index == 1050 || ((pixel_index >= 1055) && (pixel_index <= 1056)) || pixel_index == 1063 || pixel_index == 1069 || pixel_index == 1074 || ((pixel_index >= 1080) && (pixel_index <= 1081)) || ((pixel_index >= 1086) && (pixel_index <= 1087)) || pixel_index == 1091 || pixel_index == 1129 || pixel_index == 1134 || ((pixel_index >= 1140) && (pixel_index <= 1141)) || ((pixel_index >= 1146) && (pixel_index <= 1147)) || ((pixel_index >= 1151) && (pixel_index <= 1152)) || pixel_index == 1159 || pixel_index == 1166 || pixel_index == 1170 || pixel_index == 1176 || pixel_index == 1182 || pixel_index == 1187 || pixel_index == 1212 || ((pixel_index >= 1219) && (pixel_index <= 1220)) || pixel_index == 1226 || pixel_index == 1230 || pixel_index == 1236 || pixel_index == 1242 || ((pixel_index >= 1247) && (pixel_index <= 1249)) || pixel_index == 1256 || pixel_index == 1261 || pixel_index == 1267 || pixel_index == 1272 || pixel_index == 1309 || pixel_index == 1316 || pixel_index == 1321 || pixel_index == 1327 || ((pixel_index >= 1332) && (pixel_index <= 1333)) || pixel_index == 1339 || pixel_index == 1343) oled_data = 16'b0101100110000100;
else if (pixel_index == 499 || pixel_index == 559 || pixel_index == 595 || pixel_index == 601 || pixel_index == 655 || pixel_index == 661 || pixel_index == 679 || pixel_index == 690 || pixel_index == 732 || pixel_index == 750 || pixel_index == 768 || pixel_index == 776 || pixel_index == 781 || pixel_index == 787 || pixel_index == 793 || pixel_index == 799 || pixel_index == 828 || pixel_index == 835 || pixel_index == 841 || pixel_index == 847 || pixel_index == 853 || pixel_index == 859 || pixel_index == 865 || pixel_index == 882 || pixel_index == 924 || pixel_index == 932 || pixel_index == 942 || pixel_index == 960 || pixel_index == 967 || pixel_index == 979 || pixel_index == 985 || pixel_index == 1021 || pixel_index == 1027 || pixel_index == 1039 || pixel_index == 1045 || pixel_index == 1070 || pixel_index == 1075 || pixel_index == 1116 || pixel_index == 1124 || pixel_index == 1130 || pixel_index == 1135 || pixel_index == 1153 || pixel_index == 1160 || pixel_index == 1165 || pixel_index == 1183 || pixel_index == 1213 || pixel_index == 1225 || pixel_index == 1243 || pixel_index == 1255 || pixel_index == 1266 || pixel_index == 1273 || pixel_index == 1279 || pixel_index == 1283 || pixel_index == 1315 || pixel_index == 1326) oled_data = 16'b0110000110000100;
else if (pixel_index == 516 || pixel_index == 996) oled_data = 16'b0001100010000010;
else if (pixel_index == 612 || pixel_index == 1114 || pixel_index == 1284 || pixel_index == 1444 || pixel_index == 1450 || pixel_index == 1455 || pixel_index == 1469 || pixel_index == 1474 || pixel_index == 1479 || pixel_index == 1487 || pixel_index == 1504 || pixel_index == 1515 || pixel_index == 1528) oled_data = 16'b0001000010000011;
else if (((pixel_index >= 614) && (pixel_index <= 615)) || ((pixel_index >= 617) && (pixel_index <= 618)) || ((pixel_index >= 629) && (pixel_index <= 630)) || pixel_index == 632 || pixel_index == 710 || pixel_index == 712 || pixel_index == 714 || pixel_index == 724 || pixel_index == 726 || pixel_index == 728 || ((pixel_index >= 806) && (pixel_index <= 810)) || ((pixel_index >= 820) && (pixel_index <= 821)) || pixel_index == 824 || pixel_index == 902 || pixel_index == 904 || pixel_index == 906 || pixel_index == 918 || ((pixel_index >= 998) && (pixel_index <= 1001)) || (pixel_index >= 1012) && (pixel_index <= 1016)) oled_data = 16'b0010000101000101;
else if (pixel_index == 616 || pixel_index == 628 || pixel_index == 631 || pixel_index == 823 || pixel_index == 920) oled_data = 16'b0010000101000110;
else if (((pixel_index >= 682) && (pixel_index <= 683)) || ((pixel_index >= 694) && (pixel_index <= 695)) || ((pixel_index >= 700) && (pixel_index <= 701)) || ((pixel_index >= 705) && (pixel_index <= 706)) || ((pixel_index >= 742) && (pixel_index <= 743)) || ((pixel_index >= 754) && (pixel_index <= 755)) || ((pixel_index >= 760) && (pixel_index <= 761)) || ((pixel_index >= 765) && (pixel_index <= 766)) || ((pixel_index >= 771) && (pixel_index <= 772)) || ((pixel_index >= 778) && (pixel_index <= 779)) || ((pixel_index >= 790) && (pixel_index <= 791)) || ((pixel_index >= 796) && (pixel_index <= 797)) || ((pixel_index >= 801) && (pixel_index <= 802)) || ((pixel_index >= 813) && (pixel_index <= 817)) || ((pixel_index >= 831) && (pixel_index <= 832)) || ((pixel_index >= 838) && (pixel_index <= 839)) || ((pixel_index >= 850) && (pixel_index <= 851)) || ((pixel_index >= 856) && (pixel_index <= 857)) || ((pixel_index >= 861) && (pixel_index <= 862)) || ((pixel_index >= 867) && (pixel_index <= 868)) || ((pixel_index >= 874) && (pixel_index <= 875)) || ((pixel_index >= 886) && (pixel_index <= 887)) || ((pixel_index >= 892) && (pixel_index <= 893)) || ((pixel_index >= 897) && (pixel_index <= 898)) || pixel_index == 909 || ((pixel_index >= 911) && (pixel_index <= 912)) || ((pixel_index >= 927) && (pixel_index <= 928)) || ((pixel_index >= 934) && (pixel_index <= 935)) || pixel_index == 946 || pixel_index == 952 || ((pixel_index >= 957) && (pixel_index <= 958)) || ((pixel_index >= 963) && (pixel_index <= 964)) || ((pixel_index >= 970) && (pixel_index <= 971)) || ((pixel_index >= 982) && (pixel_index <= 983)) || ((pixel_index >= 988) && (pixel_index <= 989)) || ((pixel_index >= 993) && (pixel_index <= 994)) || ((pixel_index >= 1005) && (pixel_index <= 1009)) || ((pixel_index >= 1023) && (pixel_index <= 1024)) || ((pixel_index >= 1030) && (pixel_index <= 1031)) || ((pixel_index >= 1042) && (pixel_index <= 1043)) || ((pixel_index >= 1048) && (pixel_index <= 1049)) || ((pixel_index >= 1053) && (pixel_index <= 1054)) || ((pixel_index >= 1059) && (pixel_index <= 1060)) || ((pixel_index >= 1066) && (pixel_index <= 1067)) || ((pixel_index >= 1078) && (pixel_index <= 1079)) || ((pixel_index >= 1084) && (pixel_index <= 1085)) || ((pixel_index >= 1089) && (pixel_index <= 1090)) || pixel_index == 1101 || ((pixel_index >= 1104) && (pixel_index <= 1105)) || pixel_index == 1120 || ((pixel_index >= 1126) && (pixel_index <= 1127)) || ((pixel_index >= 1138) && (pixel_index <= 1139)) || ((pixel_index >= 1144) && (pixel_index <= 1145)) || ((pixel_index >= 1149) && (pixel_index <= 1150)) || pixel_index == 1155 || pixel_index == 1162 || ((pixel_index >= 1174) && (pixel_index <= 1175)) || ((pixel_index >= 1180) && (pixel_index <= 1181)) || ((pixel_index >= 1185) && (pixel_index <= 1186)) || ((pixel_index >= 1197) && (pixel_index <= 1201)) || ((pixel_index >= 1215) && (pixel_index <= 1216)) || pixel_index == 1222 || ((pixel_index >= 1234) && (pixel_index <= 1235)) || ((pixel_index >= 1240) && (pixel_index <= 1241)) || ((pixel_index >= 1245) && (pixel_index <= 1246)) || ((pixel_index >= 1251) && (pixel_index <= 1252)) || ((pixel_index >= 1258) && (pixel_index <= 1259)) || ((pixel_index >= 1270) && (pixel_index <= 1271)) || pixel_index == 1277 || pixel_index == 1282 || pixel_index == 1293 || pixel_index == 1295 || ((pixel_index >= 1311) && (pixel_index <= 1312)) || ((pixel_index >= 1318) && (pixel_index <= 1319)) || ((pixel_index >= 1330) && (pixel_index <= 1331)) || ((pixel_index >= 1336) && (pixel_index <= 1337)) || ((pixel_index >= 1341) && (pixel_index <= 1342)) || ((pixel_index >= 1347) && (pixel_index <= 1348)) || ((pixel_index >= 1354) && (pixel_index <= 1355)) || ((pixel_index >= 1366) && (pixel_index <= 1367)) || ((pixel_index >= 1372) && (pixel_index <= 1373)) || ((pixel_index >= 1377) && (pixel_index <= 1378)) || ((pixel_index >= 1389) && (pixel_index <= 1393)) || pixel_index == 1407 || ((pixel_index >= 1414) && (pixel_index <= 1415)) || ((pixel_index >= 1426) && (pixel_index <= 1427)) || ((pixel_index >= 1432) && (pixel_index <= 1433)) || (pixel_index >= 1437) && (pixel_index <= 1438)) oled_data = 16'b0111101000000101;
else if (((pixel_index >= 687) && (pixel_index <= 688)) || ((pixel_index >= 747) && (pixel_index <= 748)) || pixel_index == 784 || pixel_index == 844 || pixel_index == 879 || pixel_index == 939 || ((pixel_index >= 975) && (pixel_index <= 976)) || ((pixel_index >= 1035) && (pixel_index <= 1036)) || pixel_index == 1071 || pixel_index == 1131 || ((pixel_index >= 1167) && (pixel_index <= 1168)) || ((pixel_index >= 1227) && (pixel_index <= 1228)) || pixel_index == 1263 || pixel_index == 1323 || ((pixel_index >= 1359) && (pixel_index <= 1360)) || (pixel_index >= 1419) && (pixel_index <= 1420)) oled_data = 16'b1001101011000111;
else if (pixel_index == 711 || pixel_index == 905) oled_data = 16'b1001011010111101;
else if (pixel_index == 713 || pixel_index == 725 || pixel_index == 903) oled_data = 16'b1001011011111101;
else if (((pixel_index >= 716) && (pixel_index <= 722)) || pixel_index == 812 || pixel_index == 818 || pixel_index == 908 || pixel_index == 1010 || pixel_index == 1106 || pixel_index == 1196 || pixel_index == 1292 || pixel_index == 1298 || pixel_index == 1394) oled_data = 16'b0010100011000010;
else if (pixel_index == 727) oled_data = 16'b1001011011111100;
else if (pixel_index == 775) oled_data = 16'b0101100110000011;
else if (pixel_index == 783 || pixel_index == 843 || pixel_index == 880 || pixel_index == 940 || pixel_index == 1072 || pixel_index == 1132 || pixel_index == 1264 || pixel_index == 1324) oled_data = 16'b1001101011001000;
else if (pixel_index == 786 || pixel_index == 829 || pixel_index == 846 || pixel_index == 984 || pixel_index == 1044 || pixel_index == 1117 || pixel_index == 1123 || pixel_index == 1171 || pixel_index == 1231 || pixel_index == 1278 || pixel_index == 1322 || pixel_index == 1338) oled_data = 16'b0101100111000100;
else if (pixel_index == 822 || pixel_index == 916) oled_data = 16'b0001100101000101;
else if (pixel_index == 910 || pixel_index == 913 || pixel_index == 1103 || pixel_index == 1119 || pixel_index == 1156 || pixel_index == 1163 || pixel_index == 1223 || pixel_index == 1276 || pixel_index == 1281 || pixel_index == 1294 || pixel_index == 1297 || pixel_index == 1408) oled_data = 16'b0111001000000101;
else if (pixel_index == 914 || pixel_index == 1004 || pixel_index == 1202 || pixel_index == 1388) oled_data = 16'b0010100010000010;
else if (pixel_index == 917) oled_data = 16'b1001111010111101;
else if (pixel_index == 919) oled_data = 16'b1001011010111100;
else if (pixel_index == 947 || pixel_index == 953 || pixel_index == 1296) oled_data = 16'b0111101000000110;
else if (pixel_index == 974 || pixel_index == 991 || pixel_index == 1034 || pixel_index == 1051 || pixel_index == 1057 || pixel_index == 1064 || pixel_index == 1177 || pixel_index == 1237 || pixel_index == 1262 || pixel_index == 1308) oled_data = 16'b0110000111000100;
else if (pixel_index == 1002) oled_data = 16'b0001100101000110;
else if (pixel_index == 1100) oled_data = 16'b0010100011000001;
else if (pixel_index == 1102) oled_data = 16'b1111111000100010;
else if (pixel_index == 1497 || pixel_index == 1533) oled_data = 16'b0001000011000011;
else if (pixel_index == 1579 || pixel_index == 1587 || pixel_index == 1771 || pixel_index == 1779 || pixel_index == 1963 || pixel_index == 2067 || pixel_index == 2155 || pixel_index == 2259 || pixel_index == 2347 || pixel_index == 2547 || pixel_index == 2635 || pixel_index == 2827 || pixel_index == 2835 || pixel_index == 3019 || pixel_index == 3123 || pixel_index == 3307 || pixel_index == 3413 || pixel_index == 3419 || pixel_index == 3421 || pixel_index == 3423 || pixel_index == 3425 || pixel_index == 3427 || pixel_index == 3429 || pixel_index == 3431 || pixel_index == 3433 || pixel_index == 3435 || pixel_index == 3437 || pixel_index == 3439 || pixel_index == 3442 || pixel_index == 3444 || pixel_index == 3446 || pixel_index == 3448 || pixel_index == 3450 || pixel_index == 3452 || pixel_index == 3454 || pixel_index == 3499 || pixel_index == 3979 || pixel_index == 4085 || pixel_index == 4088 || pixel_index == 4091 || pixel_index == 4101 || pixel_index == 4106 || pixel_index == 4111 || pixel_index == 4115 || pixel_index == 4119 || pixel_index == 4124 || pixel_index == 4171 || pixel_index == 4179 || pixel_index == 4363 || pixel_index == 4467 || pixel_index == 4651 || pixel_index == 4755 || pixel_index == 5043 || pixel_index == 5131 || pixel_index == 5323 || pixel_index == 5611 || pixel_index == 5803 || pixel_index == 6091) oled_data = 16'b1101011000101110;
else if (pixel_index == 1675 || pixel_index == 1683 || pixel_index == 1867 || pixel_index == 1875 || pixel_index == 1971 || pixel_index == 2059 || pixel_index == 2251 || pixel_index == 2355 || pixel_index == 2443 || pixel_index == 2451 || pixel_index == 2539 || pixel_index == 2731 || pixel_index == 2739 || pixel_index == 2923 || pixel_index == 2931 || pixel_index == 3115 || pixel_index == 3211 || pixel_index == 3219 || pixel_index == 3403 || pixel_index == 3412 || pixel_index == 3415 || ((pixel_index >= 3417) && (pixel_index <= 3418)) || pixel_index == 3420 || pixel_index == 3422 || pixel_index == 3424 || pixel_index == 3426 || pixel_index == 3428 || pixel_index == 3430 || pixel_index == 3432 || pixel_index == 3434 || pixel_index == 3436 || pixel_index == 3438 || ((pixel_index >= 3440) && (pixel_index <= 3441)) || pixel_index == 3443 || pixel_index == 3445 || pixel_index == 3447 || pixel_index == 3449 || pixel_index == 3451 || pixel_index == 3453 || pixel_index == 3455 || pixel_index == 3595 || pixel_index == 3787 || pixel_index == 3883 || pixel_index == 4075 || pixel_index == 4084 || pixel_index == 4087 || pixel_index == 4090 || pixel_index == 4094 || pixel_index == 4096 || pixel_index == 4098 || pixel_index == 4100 || ((pixel_index >= 4103) && (pixel_index <= 4104)) || ((pixel_index >= 4107) && (pixel_index <= 4108)) || pixel_index == 4110 || ((pixel_index >= 4112) && (pixel_index <= 4114)) || ((pixel_index >= 4116) && (pixel_index <= 4118)) || ((pixel_index >= 4120) && (pixel_index <= 4123)) || ((pixel_index >= 4125) && (pixel_index <= 4127)) || pixel_index == 4267 || pixel_index == 4275 || pixel_index == 4459 || pixel_index == 4555 || pixel_index == 4563 || pixel_index == 4747 || pixel_index == 4851 || pixel_index == 4939 || pixel_index == 5035 || pixel_index == 5139 || pixel_index == 5227 || pixel_index == 5235 || pixel_index == 5419 || pixel_index == 5427 || pixel_index == 5515 || pixel_index == 5707 || pixel_index == 5715 || pixel_index == 5811 || pixel_index == 5995 || pixel_index == 6003) oled_data = 16'b1101010111101110;
else if (pixel_index == 2163 || pixel_index == 2643 || pixel_index == 3027 || pixel_index == 3315 || pixel_index == 4083 || pixel_index == 4086 || pixel_index == 4089 || pixel_index == 4092 || pixel_index == 4099 || pixel_index == 4102 || pixel_index == 4105 || pixel_index == 4109 || pixel_index == 4659 || pixel_index == 5899) oled_data = 16'b1100110111101110;
else if (pixel_index == 3411) oled_data = 16'b1101011000101101;
else if (pixel_index == 3414 || pixel_index == 4093 || pixel_index == 5523 || pixel_index == 6099) oled_data = 16'b1101010111101101;
else if (pixel_index == 3416 || pixel_index == 3691 || pixel_index == 4095 || pixel_index == 4843 || pixel_index == 5331 || pixel_index == 5619 || pixel_index == 5907) oled_data = 16'b1100111000101110;
else if (pixel_index == 4097 || pixel_index == 4371 || pixel_index == 4947) oled_data = 16'b1100110111101101; */


//Filling Colour
else if (y < 4) oled_data = 16'b1001111010111100;
else if (y < 15 && !(y > 3 && y < 15 && x > 36 && x < 58) ) oled_data = 16'b0000000111000001;
else if (y > 15) oled_data = 16'b1111011100110011;
else oled_data = 0;



if ((y >= 18) && (y <= 53) && (x >= 3) && (x <= 36)) oled_data = 16'b0010100011000010;
if ((y >= 19) && (y <= 52) && (x >= 4) && (x <= 35)) oled_data = 16'b1001101011000111;
if (((y == 25) || (y == 32) || (y == 39) || (y == 46))  && (x >= 4) && (x <= 35) ) oled_data = 16'b0101100110000100;
if (((x == 14) || (x == 25))  && (y >= 19) && (y <= 52) ) oled_data = 16'b0101100110000100;

    if (PType[0] == 0) GrowthState[0] = 1;
    if (PType[1] == 0) GrowthState[1] = 1;
    if (PType[2] == 0) GrowthState[2] = 1;
    if (PType[3] == 0) GrowthState[3] = 1;
    if (PType[4] == 0) GrowthState[4] = 1;
    if (PType[5] == 0) GrowthState[5] = 1;
    if (PType[6] == 0) GrowthState[6] = 1;
    if (PType[7] == 0) GrowthState[7] = 1;
    if (PType[8] == 0) GrowthState[8] = 1;
    if (PType[9] == 0) GrowthState[9] = 1;
    if (PType[10] == 0) GrowthState[10] = 1;
    if (PType[11] == 0) GrowthState[11] = 1;
    if (PType[12] == 0) GrowthState[12] = 1;
    if (PType[13] == 0) GrowthState[13] = 1;
    if (PType[14] == 0) GrowthState[14] = 1;
    if (PType[15] == 0) GrowthState[15] = 1;

/*
if ((y >= 18) && (y <= 32) && (x >= 58) && (x <= 91)) oled_data = 16'b0010100011000010;
if ((y >= 19) && (y <= 31) && (x >= 59) && (x <= 90)) oled_data = 16'b1001101011000111;
if ((y == 25)  && (x >= 59) && (x <= 90)) oled_data = 16'b0101100110000100;
if (((x == 69) || (x == 80))  && (y >= 19) && (y <= 31) ) oled_data = 16'b0101100110000100; */
    if (day > previous_day) begin
    for (j = 0; j < 18; j = j + 1) begin 
        if (GrowthState[j] < 3 && GrowthState[j] && wet[j] > 0) begin
            GrowthState[j] <= GrowthState[j] + 1;
            wet[j] <= 0;
        end
    end
 end  

previous_day <= day;   


for (j = 0; j < 5; j = j + 1) begin
    for (i = 0; i < 3; i = i + 1) begin
            	
        if ( (x > (3 + 11*i) && x < (14 + 11*i)) && ( y > (18 + 7*j) && y < (25 + 7*j)) ) begin
            if ((char_x + 2> (3 + 11*i) && char_x + 2 < (14 + 11*i)) && ( char_y + 15 > (18 + 7*j) && char_y + 15 < (25 + 7*j))) 
            begin
                if (threeseconds_elapsed) wet[j*3 + i] = 1;
                if (!sw[0] && !sw[1] && btnC && GrowthState[j*3 + i] == 3)
                begin
                    if (PType[j*3 + i] == 1) wheat_output <= (wheat_count < 9) ? wheat_count + 1 : wheat_count; 
                    if (PType[j*3 + i] == 2) pumpkin_output <= (pumpkin_count < 9) ? pumpkin_count + 1 : pumpkin_count;
                    PType[j*3 + i] <= 0;
                end
                if (sw[1] && btnC && PType[j*3 + i] == 0) PType[j*3 + i] = 1;
                if (sw[2] && btnC && PType[j*3 + i] != 1) PType[j*3 + i] = 2;
             end
             if (wet[j*3 + i] == 1) oled_data = 16'b0101100110000100;
        end
                
    end
end


 /*        
for (j = 0; j < 2; j = j + 1) begin
    for (i = 0; i < 3; i = i + 1) begin
         
        if ( (x > (58 + 11*i) && x < (69 + 11*i)) && ( y > (18 + 7*j) && y < (25 + 7*j)) ) begin
            if ((char_x + 2 > (58 + 11*i) && char_x + 2 < (69 + 11*i)) && ( char_y + 15 > (18 + 7*j) && char_y + 15 < (25 + 7*j))) 
            begin
                if (threeseconds_elapsed) wet[j*3 + i + 18] = 1;
                if (!sw[0] && !sw[1] && btnC && GrowthState[j*3 + i + 18] == 3)
                begin
                    if (PType[j*3 + i + 18] == 1) wheat_output <= (wheat_count < 9) ? wheat_count + 1 : wheat_count; 
                    if (PType[j*3 + i + 18] == 2)pumpkin_output <= (pumpkin_count < 9) ? pumpkin_count + 1 : pumpkin_count;
                    PType[j*3 + i + 18] <= 0;
                end  //Check bitstream time later
                if (sw[1] && btnC && PType[j*3 + i + 18] == 0) PType[j*3 + i + 18] = 1;
                if (sw[2] && btnC && PType[j*3 + i + 18] != 1) PType[j*3 + i + 18] = 2;
            end
            if (wet[j*3 + i + 18] == 1) oled_data = 16'b0101100110000100;
        end
            
    end
end */
            
for (i = 0; i < 16; i = i + 1) begin
    for (j = 0; j < 15; j = j + 1) begin
        if (pixel_index == (base_values[i] + plot[j])) begin
        if (GrowthState[j] == 1 && PType[j] == 1) oled_data = 16'b1010111100100100;
                end
            end
        end
        
        for (i = 0; i < 14; i = i + 1) begin
                    for (j = 0; j < 15; j = j + 1) begin
                        if (pixel_index == (base_valuesG1C1[i] + plot[j] - 96)) begin
                            if (GrowthState[j] == 2 && PType[j] == 1) oled_data = 16'b1101111101101001;
                        end
                    end
                end
                
                        for (i = 0; i < 16; i = i + 1) begin
                            for (j = 0; j < 15; j = j + 1) begin
                                if (pixel_index == (base_valuesG1C2[i] + plot[j] - 96)) begin
                                    if (GrowthState[j] == 2 && PType[j] == 1) oled_data = 16'b1101010111101011;
                                end
                            end
                        end
                        
                                           for (i = 0; i < 19; i = i + 1) begin
                            for (j = 0; j < 15; j = j + 1) begin
                                if (pixel_index == (base_valuesD1C1[i] + plot[j] - 192)) begin
                                    if (GrowthState[j] == 3 && PType[j] == 1) oled_data = 16'b1111111110100000;
                                end
                            end
                        end
                        
         for (i = 0; i < 23; i = i + 1) begin
         for (j = 0; j < 15; j = j + 1) begin
             if (pixel_index == (base_valuesD1C2[i] + plot[j] - 192)) begin
                 if (GrowthState[j] == 3 && PType[j] == 1) oled_data = 16'b1111111000100001;
             end
         end
     end
     
              for (i = 0; i < 21; i = i + 1) begin
     for (j = 0; j < 15; j = j + 1) begin
         if (pixel_index == (base_valuesD1C3[i] + plot[j] - 192)) begin
             if (GrowthState[j] == 3 && PType[j] == 1) oled_data = 16'b1101110010100110;
         end
     end
 end
 
 for (j = 0; j < 15; j = j + 1) begin
 if (pixel_index == 292 + plot[j] || pixel_index == 293 + plot[j] || pixel_index == 388 + plot[j]) begin
    if (GrowthState[j] == 1 && PType[j] == 2) oled_data = 16'b1100111011100111;
 end
 end
 
  for (j = 0; j < 15; j = j + 1) begin
 if (pixel_index == 100 + plot[j] || pixel_index == 101 + plot[j] || pixel_index == 196 + plot[j]) begin
    if (GrowthState[j] == 2 && PType[j] == 2) oled_data = 16'b1100111011100111;
 end
 end
 
for (j = 0; j < 15; j = j + 1) begin
if (x > 2 + (plot[j]%96) && x < 6 + (plot[j]%96) && y > 2 + (plot[j]/96) && y < 5 + (plot[j]/96)) begin
if (GrowthState[j] == 2 && PType[j] == 2) oled_data = 16'b1111111000100001;
end
end

for (j = 0; j < 15; j = j + 1) begin
if (pixel_index == 4 + plot[j] || pixel_index == 5 + plot[j] || pixel_index == 100 + plot[j]) begin
if (GrowthState[j] == 3 && PType[j] == 2) oled_data = 16'b0100110101101010;
end
end

for (j = 0; j < 15; j = j + 1) begin
if (x > 1 + (plot[j]%96) && x < 7 + (plot[j]%96) && y > 1 + (plot[j]/96) && y < 5 + (plot[j]/96)) begin
if (GrowthState[j] == 3 && PType[j] == 2) oled_data = 16'b1111101111000000;
end
end 

//Character
if (facing_down)
begin
if (sw[0]) begin


if (((pixel_index >= (char_y*96 + char_x) + 3) && (pixel_index <= (char_y*96 + char_x) + 4)) || pixel_index == (char_y*96 + char_x) + 98 || pixel_index == (char_y*96 + char_x) + 101) oled_data = 16'b1100010010100010;
else if ((pixel_index >= (char_y*96 + char_x) + 99) && (pixel_index <= (char_y*96 + char_x) + 100)) oled_data = 16'b1111111000100010;
else if (pixel_index == (char_y*96 + char_x) + 195 || ((pixel_index >= (char_y*96 + char_x) + 291) && (pixel_index <= (char_y*96 + char_x) + 292)) || pixel_index == (char_y*96 + char_x) + 388) oled_data = 16'b1110010101101111;
else if (pixel_index == (char_y*96 + char_x) + 196) oled_data = 16'b1110010100101110;
else if (pixel_index == (char_y*96 + char_x) + 385 || pixel_index == (char_y*96 + char_x) + 389) oled_data = 16'b0001001010000100;
else if (pixel_index == (char_y*96 + char_x) + 386 || pixel_index == (char_y*96 + char_x) + 480 || pixel_index == (char_y*96 + char_x) + 486 || pixel_index == (char_y*96 + char_x) + 578 || pixel_index == (char_y*96 + char_x) + 672 || pixel_index == (char_y*96 + char_x) + 677) oled_data = 16'b0001001010000101;
else if (pixel_index == (char_y*96 + char_x) + 387 || pixel_index == (char_y*96 + char_x) + 770 || pixel_index == (char_y*96 + char_x) + 870) oled_data = 16'b1110010100101111;
else if (pixel_index == (char_y*96 + char_x) + 481 || pixel_index == (char_y*96 + char_x) + 483 || pixel_index == (char_y*96 + char_x) + 485 || pixel_index == (char_y*96 + char_x) + 580 || pixel_index == (char_y*96 + char_x) + 673 || pixel_index == (char_y*96 + char_x) + 675 || pixel_index == (char_y*96 + char_x) + 678 || pixel_index == (char_y*96 + char_x) + 772) oled_data = 16'b0010010101101001;
else if (pixel_index == (char_y*96 + char_x) + 482) oled_data = 16'b0010110110101001;
else if (pixel_index == (char_y*96 + char_x) + 484 || pixel_index == (char_y*96 + char_x) + 577 || pixel_index == (char_y*96 + char_x) + 579 || pixel_index == (char_y*96 + char_x) + 582 || pixel_index == (char_y*96 + char_x) + 676 || pixel_index == (char_y*96 + char_x) + 774) oled_data = 16'b0010010110101001;
else if (pixel_index == (char_y*96 + char_x) + 576 || pixel_index == (char_y*96 + char_x) + 773) oled_data = 16'b0001101010000100;
else if (pixel_index == (char_y*96 + char_x) + 581) oled_data = 16'b0001101010000101;
else if (pixel_index == (char_y*96 + char_x) + 674 || pixel_index == (char_y*96 + char_x) + 771) oled_data = 16'b1100100100000101;
else if (pixel_index == (char_y*96 + char_x) + 769 || pixel_index == (char_y*96 + char_x) + 961 || pixel_index == (char_y*96 + char_x) + 963) oled_data = 16'b1100100100000100;
else if (pixel_index == (char_y*96 + char_x) + 865) oled_data = 16'b1100100011000101;
else if (pixel_index == (char_y*96 + char_x) + 866) oled_data = 16'b1110100100000100;
else if (pixel_index == (char_y*96 + char_x) + 867) oled_data = 16'b1100100011000100;
else if (pixel_index == (char_y*96 + char_x) + 868 || pixel_index == (char_y*96 + char_x) + 1252) oled_data = 16'b0011000111010011;
else if (pixel_index == (char_y*96 + char_x) + 869 || pixel_index == (char_y*96 + char_x) + 1253) oled_data = 16'b0001100101000101;
else if (pixel_index == (char_y*96 + char_x) + 962) oled_data = 16'b1110000011000101;
else if (pixel_index == (char_y*96 + char_x) + 964 || pixel_index == (char_y*96 + char_x) + 1058 || pixel_index == (char_y*96 + char_x) + 1250) oled_data = 16'b0011000110010011;
else if (pixel_index == (char_y*96 + char_x) + 965 || pixel_index == (char_y*96 + char_x) + 1057 || pixel_index == (char_y*96 + char_x) + 1061 || pixel_index == (char_y*96 + char_x) + 1153 || pixel_index == (char_y*96 + char_x) + 1249) oled_data = 16'b0010000101000101;
else if (pixel_index == (char_y*96 + char_x) + 1060 || pixel_index == (char_y*96 + char_x) + 1154) oled_data = 16'b0010100111010011;
else if (pixel_index == (char_y*96 + char_x) + 1156) oled_data = 16'b0011000110010010;
else if (pixel_index == (char_y*96 + char_x) + 1157) oled_data = 16'b0010000101000110;
else if (((pixel_index >= (char_y*96 + char_x) + 1344) && (pixel_index <= (char_y*96 + char_x) + 1345)) || (pixel_index >= (char_y*96 + char_x) + 1348) && (pixel_index <= (char_y*96 + char_x) + 1350)) oled_data = 16'b0111101000000101;
else if (pixel_index == (char_y*96 + char_x) + 1346) oled_data = 16'b0111001000000101;

if (btnC) begin //Spraying
if (pixel_index == (char_y*96 + char_x) + 1058) oled_data = 16'b1110100011000100;
if (pixel_index == (char_y*96 + char_x) + 1154 || pixel_index == (char_y*96 + char_x) + 1249 || pixel_index == (char_y*96 + char_x) + 1251
|| pixel_index == (char_y*96 + char_x) + 1344 || pixel_index == (char_y*96 + char_x) + 1346 || pixel_index == (char_y*96 + char_x) + 1348) oled_data = 16'b0000000000011111;
end

end

else begin //Scythe
if (((pixel_index >= (char_y*96 + char_x) + 3) && (pixel_index <= (char_y*96 + char_x) + 4)) || pixel_index == (char_y*96 + char_x) + 98 || pixel_index == (char_y*96 + char_x) + 101) oled_data = 16'b1100010010100010;
else if ((pixel_index >= (char_y*96 + char_x) + 99) && (pixel_index <= (char_y*96 + char_x) + 100)) oled_data = 16'b1111111000100010;
else if (pixel_index == (char_y*96 + char_x) + 195 || ((pixel_index >= (char_y*96 + char_x) + 291) && (pixel_index <= (char_y*96 + char_x) + 292)) || pixel_index == (char_y*96 + char_x) + 388 || pixel_index == (char_y*96 + char_x) + 770) oled_data = 16'b1110010101101111;
else if (pixel_index == (char_y*96 + char_x) + 196) oled_data = 16'b1110010100101110;
else if (pixel_index == (char_y*96 + char_x) + 295 || pixel_index == (char_y*96 + char_x) + 297 || pixel_index == (char_y*96 + char_x) + 490 || pixel_index == (char_y*96 + char_x) + 682) oled_data = 16'b0100101001001000;
else if (pixel_index == (char_y*96 + char_x) + 296 || pixel_index == (char_y*96 + char_x) + 586) oled_data = 16'b0100001000001001;
else if (pixel_index == (char_y*96 + char_x) + 385 || pixel_index == (char_y*96 + char_x) + 389) oled_data = 16'b0001001010000100;
else if (pixel_index == (char_y*96 + char_x) + 386 || pixel_index == (char_y*96 + char_x) + 480 || pixel_index == (char_y*96 + char_x) + 485 || pixel_index == (char_y*96 + char_x) + 578 || pixel_index == (char_y*96 + char_x) + 672 || pixel_index == (char_y*96 + char_x) + 677 || pixel_index == (char_y*96 + char_x) + 769) oled_data = 16'b0001001010000101;
else if (pixel_index == (char_y*96 + char_x) + 387) oled_data = 16'b1110010100101111;
else if (pixel_index == (char_y*96 + char_x) + 391 || pixel_index == (char_y*96 + char_x) + 486 || ((pixel_index >= (char_y*96 + char_x) + 580) && (pixel_index <= (char_y*96 + char_x) + 582)) || pixel_index == (char_y*96 + char_x) + 674 || pixel_index == (char_y*96 + char_x) + 676 || pixel_index == (char_y*96 + char_x) + 771) oled_data = 16'b1001101011000111;
else if (pixel_index == (char_y*96 + char_x) + 392) oled_data = 16'b0100101000001001;
else if (pixel_index == (char_y*96 + char_x) + 393) oled_data = 16'b0100001001001001;
else if (pixel_index == (char_y*96 + char_x) + 481 || pixel_index == (char_y*96 + char_x) + 483 || pixel_index == (char_y*96 + char_x) + 673 || pixel_index == (char_y*96 + char_x) + 772) oled_data = 16'b0010010101101001;
else if (pixel_index == (char_y*96 + char_x) + 482) oled_data = 16'b0010110110101001;
else if (pixel_index == (char_y*96 + char_x) + 484 || pixel_index == (char_y*96 + char_x) + 577 || pixel_index == (char_y*96 + char_x) + 579) oled_data = 16'b0010010110101001;
else if (pixel_index == (char_y*96 + char_x) + 487 || pixel_index == (char_y*96 + char_x) + 675) oled_data = 16'b1001101011001000;
else if (pixel_index == (char_y*96 + char_x) + 489) oled_data = 16'b0100001000001000;
else if (pixel_index == (char_y*96 + char_x) + 576) oled_data = 16'b0001101010000100;
else if (pixel_index == (char_y*96 + char_x) + 773) oled_data = 16'b0001101010000101;
else if (pixel_index == (char_y*96 + char_x) + 865 || pixel_index == (char_y*96 + char_x) + 961 || pixel_index == (char_y*96 + char_x) + 965 || pixel_index == (char_y*96 + char_x) + 1057 || pixel_index == (char_y*96 + char_x) + 1153 || pixel_index == (char_y*96 + char_x) + 1157 || pixel_index == (char_y*96 + char_x) + 1249 || pixel_index == (char_y*96 + char_x) + 1253) oled_data = 16'b0010000101000101;
else if (pixel_index == (char_y*96 + char_x) + 866 || pixel_index == (char_y*96 + char_x) + 868 || pixel_index == (char_y*96 + char_x) + 1058 || pixel_index == (char_y*96 + char_x) + 1250) oled_data = 16'b0011000110010011;
else if (pixel_index == (char_y*96 + char_x) + 867) oled_data = 16'b0011000111010010;
else if (pixel_index == (char_y*96 + char_x) + 869 || pixel_index == (char_y*96 + char_x) + 1061) oled_data = 16'b0001100101000101;
else if (pixel_index == (char_y*96 + char_x) + 962) oled_data = 16'b0010100111010011;
else if (pixel_index == (char_y*96 + char_x) + 964 || pixel_index == (char_y*96 + char_x) + 1156) oled_data = 16'b0011000111010011;
else if (pixel_index == (char_y*96 + char_x) + 1060) oled_data = 16'b0011000110010010;
else if (pixel_index == (char_y*96 + char_x) + 1154) oled_data = 16'b0010100111010010;
else if (pixel_index == (char_y*96 + char_x) + 1252) oled_data = 16'b0010100110010011;
else if (((pixel_index >= (char_y*96 + char_x) + 1344) && (pixel_index <= (char_y*96 + char_x) + 1345)) || (pixel_index >= (char_y*96 + char_x) + 1348) && (pixel_index <= (char_y*96 + char_x) + 1350)) oled_data = 16'b0111101000000101;
else if (pixel_index == (char_y*96 + char_x) + 1346) oled_data = 16'b0111001000000101;
end

end
else if (facing_up)
begin
    if(sw[0]) begin

//Watering
    if (((pixel_index >= (char_y*96 + char_x) + 6) && (pixel_index <= (char_y*96 + char_x) + 7)) || pixel_index == (char_y*96 + char_x) + 101 || pixel_index == (char_y*96 + char_x) + 104) oled_data = 16'b1100010010100010;
    else if ((pixel_index >= (char_y*96 + char_x) + 102) && (pixel_index <= (char_y*96 + char_x) + 103)) oled_data = 16'b1111111000100010;
    else if ((pixel_index >= (char_y*96 + char_x) + 198) && (pixel_index <= (char_y*96 + char_x) + 199)) oled_data = 16'b0011100000000010;
    else if (pixel_index == (char_y*96 + char_x) + 294) oled_data = 16'b0011000000000010;
    else if (pixel_index == (char_y*96 + char_x) + 295) oled_data = 16'b0011100001000010;
    else if (pixel_index ==(char_y*96 + char_x) +  389 || pixel_index == (char_y*96 + char_x) + 392) oled_data = 16'b0001001010000100;
    else if (pixel_index == (char_y*96 + char_x) + 390 || pixel_index == (char_y*96 + char_x) + 868) oled_data = 16'b1110010101101111;
    else if (pixel_index == (char_y*96 + char_x) + 391) oled_data = 16'b1110010100101111;
    else if (pixel_index == (char_y*96 + char_x) + 393 || pixel_index == (char_y*96 + char_x) + 484 || pixel_index == (char_y*96 + char_x) + 586 || pixel_index == (char_y*96 + char_x) + 677 || pixel_index == (char_y*96 + char_x) + 680 || pixel_index == (char_y*96 + char_x) + 777) oled_data = 16'b0001001010000101;
    else if (pixel_index == (char_y*96 + char_x) + 485 || pixel_index == (char_y*96 + char_x) + 582 || pixel_index == (char_y*96 + char_x) + 585 || pixel_index == (char_y*96 + char_x) + 676 || pixel_index == (char_y*96 + char_x) + 679 || pixel_index == (char_y*96 + char_x) + 774) oled_data = 16'b0010010101101001;
    else if (((pixel_index >= (char_y*96 + char_x) + 486) && (pixel_index <= (char_y*96 + char_x) + 487)) || pixel_index == (char_y*96 + char_x) + 489 || pixel_index == (char_y*96 + char_x) + 580 || pixel_index == (char_y*96 + char_x) + 583 || pixel_index == (char_y*96 + char_x) + 678 || pixel_index == (char_y*96 + char_x) + 681 || pixel_index == (char_y*96 + char_x) + 772 || pixel_index == (char_y*96 + char_x) + 775) oled_data = 16'b0010010110101001;
    else if (pixel_index == (char_y*96 + char_x) + 488) oled_data = 16'b0010010101101010;
    else if (pixel_index == (char_y*96 + char_x) + 490 || pixel_index == (char_y*96 + char_x) + 682) oled_data = 16'b0001101010000100;
    else if (pixel_index == (char_y*96 + char_x) + 581 || pixel_index == (char_y*96 + char_x) + 584 || pixel_index == (char_y*96 + char_x) + 773) oled_data = 16'b0001101010000101;
    else if (pixel_index == (char_y*96 + char_x) + 776) oled_data = 16'b0010110101101001;
    else if (pixel_index == (char_y*96 + char_x) + 869 || pixel_index == (char_y*96 + char_x) + 873 || pixel_index == (char_y*96 + char_x) + 965 || pixel_index == (char_y*96 + char_x) + 969 || pixel_index == (char_y*96 + char_x) + 1061 || pixel_index == (char_y*96 + char_x) + 1157 || pixel_index == (char_y*96 + char_x) + 1161 || pixel_index == (char_y*96 + char_x) + 1253 || pixel_index == (char_y*96 + char_x) + 1257) oled_data = 16'b0010000101000101;
    else if (pixel_index == (char_y*96 + char_x) + 870 || pixel_index == (char_y*96 + char_x) + 1062 || pixel_index == (char_y*96 + char_x) + 1254) oled_data = 16'b0011000110010011;
    else if (pixel_index == (char_y*96 + char_x) + 871 || pixel_index == (char_y*96 + char_x) + 1064) oled_data = 16'b0011000111010011;
    else if (pixel_index == (char_y*96 + char_x) + 872 || pixel_index == (char_y*96 + char_x) + 966 || pixel_index == (char_y*96 + char_x) + 1158 || pixel_index == (char_y*96 + char_x) + 1256) oled_data = 16'b0010100111010011;
    else if (pixel_index == (char_y*96 + char_x) + 967) oled_data = 16'b1110100011000100;
    else if (pixel_index == (char_y*96 + char_x) + 968 || pixel_index == (char_y*96 + char_x) + 1160) oled_data = 16'b0011000110010010;
    else if (pixel_index == (char_y*96 + char_x) + 1065) oled_data = 16'b0001100101000101;
    else if (((pixel_index >= (char_y*96 + char_x) + 1348) && (pixel_index <= (char_y*96 + char_x) + 1349)) || (pixel_index >= (char_y*96 + char_x) + 1352) && (pixel_index <= (char_y*96 + char_x) + 1354)) oled_data = 16'b0111101000000101;
    else if (pixel_index == (char_y*96 + char_x) + 1350) oled_data = 16'b0111001000000101;
    
            if (btnC) begin //Spraying
    if (pixel_index == (char_y*96 + char_x) + 1160 || pixel_index == (char_y*96 + char_x) + 1254 || pixel_index == (char_y*96 + char_x) + 1257
    || pixel_index == (char_y*96 + char_x) + 1350 || pixel_index == (char_y*96 + char_x) + 1352 || pixel_index == (char_y*96 + char_x) + 1354) oled_data = 16'b0000000000011111;
end
    
    
end

else begin //Scythe
if (((pixel_index >= (char_y*96 + char_x) + 6) && (pixel_index <= (char_y*96 + char_x) + 7)) || pixel_index == (char_y*96 + char_x) + 101 || pixel_index == (char_y*96 + char_x) + 104) oled_data = 16'b1100010010100010;
else if ((pixel_index >= (char_y*96 + char_x) + 102) && (pixel_index <= (char_y*96 + char_x) + 103)) oled_data = 16'b1111111000100010;
else if ((pixel_index >= (char_y*96 + char_x) + 198) && (pixel_index <= (char_y*96 + char_x) + 199)) oled_data = 16'b0011100000000010;
else if (pixel_index == (char_y*96 + char_x) + 289 || pixel_index == (char_y*96 + char_x) + 291 || pixel_index == (char_y*96 + char_x) + 386 || pixel_index == (char_y*96 + char_x) + 480 || pixel_index == (char_y*96 + char_x) + 672) oled_data = 16'b0100101001001001;
else if (pixel_index == (char_y*96 + char_x) + 290 || pixel_index == (char_y*96 + char_x) + 385 || pixel_index == (char_y*96 + char_x) + 481 || pixel_index == (char_y*96 + char_x) + 576) oled_data = 16'b0100001000001000;
else if (pixel_index == (char_y*96 + char_x) + 294 || pixel_index == (char_y*96 + char_x) + 295) oled_data = 16'b0011100001000010;
else if (pixel_index == (char_y*96 + char_x) + 387 || (pixel_index >= (char_y*96 + char_x) + 483) && (pixel_index <= (char_y*96 + char_x) + 484)) oled_data = 16'b1001101011000111;
else if (pixel_index == (char_y*96 + char_x) + 389 || pixel_index == (char_y*96 + char_x) + 392 || pixel_index == (char_y*96 + char_x) + 581 || pixel_index == (char_y*96 + char_x) + 586) oled_data = 16'b0001001010000100;
else if (pixel_index == (char_y*96 + char_x) + 390 || pixel_index == (char_y*96 + char_x) + 391) oled_data = 16'b1110010100101111;
else if (pixel_index == (char_y*96 + char_x) + 393 || pixel_index == (char_y*96 + char_x) + 485 || pixel_index == (char_y*96 + char_x) + 680 || pixel_index == (char_y*96 + char_x) + 773 || pixel_index == (char_y*96 + char_x) + 777) oled_data = 16'b0001001010000101;
else if (pixel_index == (char_y*96 + char_x) + 486 || pixel_index == (char_y*96 + char_x) + 488 || pixel_index == (char_y*96 + char_x) + 583 || pixel_index == (char_y*96 + char_x) + 678 || pixel_index == (char_y*96 + char_x) + 681 || pixel_index == (char_y*96 + char_x) + 775) oled_data = 16'b0010010101101001;
else if (pixel_index == (char_y*96 + char_x) + 487 || pixel_index == (char_y*96 + char_x) + 489 || pixel_index == (char_y*96 + char_x) + 585 || pixel_index == (char_y*96 + char_x) + 679 || pixel_index == (char_y*96 + char_x) + 774) oled_data = 16'b0010010110101001;
else if (pixel_index == (char_y*96 + char_x) + 490 || pixel_index == (char_y*96 + char_x) + 584 || pixel_index == (char_y*96 + char_x) + 682) oled_data = 16'b0001101010000101;
else if (pixel_index == (char_y*96 + char_x) + 580) oled_data = 16'b1001101011001000;
else if (pixel_index == (char_y*96 + char_x) + 582) oled_data = 16'b0010010110101010;
else if (pixel_index == (char_y*96 + char_x) + 677) oled_data = 16'b0001101010000100;
else if (pixel_index == (char_y*96 + char_x) + 776) oled_data = 16'b0010110110101001;
else if (pixel_index == (char_y*96 + char_x) + 869 || pixel_index == (char_y*96 + char_x) + 873 || pixel_index == (char_y*96 + char_x) + 965 || pixel_index == (char_y*96 + char_x) + 969 || pixel_index == (char_y*96 + char_x) + 1061 || pixel_index == (char_y*96 + char_x) + 1065 || pixel_index == (char_y*96 + char_x) + 1157 || pixel_index == (char_y*96 + char_x) + 1253 || pixel_index == (char_y*96 + char_x) + 1257) oled_data = 16'b0010000101000101;
else if (pixel_index == (char_y*96 + char_x) + 870 || pixel_index == (char_y*96 + char_x) + 872 || pixel_index == (char_y*96 + char_x) + 1062 || pixel_index == (char_y*96 + char_x) + 1064 || pixel_index == (char_y*96 + char_x) + 1254 || pixel_index == (char_y*96 + char_x) + 1256) oled_data = 16'b0011000110010011;
else if (pixel_index == (char_y*96 + char_x) + 871) oled_data = 16'b0011000111010011;
else if (pixel_index == (char_y*96 + char_x) + 966 || pixel_index == (char_y*96 + char_x) + 1158) oled_data = 16'b0010100111010011;
else if (pixel_index == (char_y*96 + char_x) + 968) oled_data = 16'b0010100111010010;
else if (pixel_index == (char_y*96 + char_x) + 1160) oled_data = 16'b0011000111010010;
else if (pixel_index == (char_y*96 + char_x) + 1161) oled_data = 16'b0001100101000101;
else if (((pixel_index >= (char_y*96 + char_x) + 1348) && (pixel_index <= (char_y*96 + char_x) + 1349)) || (pixel_index >= (char_y*96 + char_x) + 1352) && (pixel_index <= (char_y*96 + char_x) + 1354)) oled_data = 16'b0111101000000101;
else if (pixel_index == (char_y*96 + char_x) + 1350) oled_data = 16'b0111001000000101;
end
end
else if (facing_left)
begin
if (((pixel_index >= (char_y*96 + char_x) +  4) && (pixel_index <= (char_y*96 + char_x) + 6)) || pixel_index == (char_y*96 + char_x) + 99 || pixel_index == (char_y*96 + char_x) + 103) oled_data = 16'b1100010010100010;
else if ((pixel_index >= (char_y*96 + char_x) + 100) && (pixel_index <= (char_y*96 + char_x) + 101)) oled_data = 16'b1111111000100010;
else if (pixel_index == (char_y*96 + char_x) + 102) oled_data = 16'b1111111000100001;
else if (pixel_index == (char_y*96 + char_x) + 196 || pixel_index == (char_y*96 + char_x) + 292 || pixel_index == (char_y*96 + char_x) + 389 || pixel_index == (char_y*96 + char_x) + 675) oled_data = 16'b1110010101101111;
else if (pixel_index == (char_y*96 + char_x) + 197 || pixel_index == (char_y*96 + char_x) + 388) oled_data = 16'b1110010100101111;
else if (pixel_index == (char_y*96 + char_x) + 198) oled_data = 16'b0011100000000010;
else if (pixel_index == (char_y*96 + char_x) + 293) oled_data = 16'b1110010101101110;
else if (pixel_index == (char_y*96 + char_x) + 294) oled_data = 16'b0011000000000010;
else if (pixel_index == (char_y*96 + char_x) + 484 || pixel_index == (char_y*96 + char_x) + 678) oled_data = 16'b0001001010000100;
else if (pixel_index == (char_y*96 + char_x) + 485 || pixel_index == (char_y*96 + char_x) + 676) oled_data = 16'b0010010101101001;
else if (pixel_index == (char_y*96 + char_x) + 486 || pixel_index == (char_y*96 + char_x) + 580 || pixel_index == (char_y*96 + char_x) + 772 || pixel_index == (char_y*96 + char_x) + 774) oled_data = 16'b0001001010000101;
else if (pixel_index == (char_y*96 + char_x) + 581 || pixel_index == (char_y*96 + char_x) + 677) oled_data = 16'b0010010110101001;
else if (pixel_index == (char_y*96 + char_x) + 582) oled_data = 16'b0001101010000101;
else if (pixel_index == (char_y*96 + char_x) + 773) oled_data = 16'b0001101010000100;
else if (pixel_index == (char_y*96 + char_x) + 868 || pixel_index == (char_y*96 + char_x) + 870 || pixel_index == (char_y*96 + char_x) + 964 || pixel_index == (char_y*96 + char_x) + 966 || pixel_index == (char_y*96 + char_x) + 1060 || pixel_index == (char_y*96 + char_x) + 1062 || pixel_index == (char_y*96 + char_x) + 1156 || pixel_index == (char_y*96 + char_x) + 1158 || pixel_index == (char_y*96 + char_x) + 1252 || pixel_index == (char_y*96 + char_x) + 1254) oled_data = 16'b0010000101000101;
else if (pixel_index == (char_y*96 + char_x) + 869 || pixel_index == (char_y*96 + char_x) + 1061 || pixel_index == (char_y*96 + char_x) + 1253) oled_data = 16'b0011000110010011;
else if (pixel_index == (char_y*96 + char_x) + 965 || pixel_index == (char_y*96 + char_x) + 1157) oled_data = 16'b0010100111010011;
else if (((pixel_index >= (char_y*96 + char_x) + 1347) && (pixel_index <= (char_y*96 + char_x) + 1348)) || pixel_index == (char_y*96 + char_x) + 1350) oled_data = 16'b0111101000000101;
else if (pixel_index == (char_y*96 + char_x) + 1349) oled_data = 16'b0111001000000101;

if (sw[0]) begin //Watering can
if (btnC) begin //Spraying
if (pixel_index == (char_y*96 + char_x) + 1152 || pixel_index == (char_y*96 + char_x) + 1247 || pixel_index == (char_y*96 + char_x) + 1249
|| pixel_index == (char_y*96 + char_x) + 1342 || pixel_index == (char_y*96 + char_x) + 1344 || pixel_index == (char_y*96 + char_x) + 1346) oled_data = 16'b0000000000011111;
if (pixel_index == (char_y*96 + char_x) + 674 || ((pixel_index >= (char_y*96 + char_x) + 866) && (pixel_index <= (char_y*96 + char_x) + 867)) || pixel_index == (char_y*96 + char_x) + 961 || pixel_index == (char_y*96 + char_x) + 1056
|| pixel_index == (char_y*96 + char_x) + 770 || pixel_index == (char_y*96 + char_x) + 962 || pixel_index == (char_y*96 + char_x) + 1057 || pixel_index == (char_y*96 + char_x) + 963 ) oled_data = 16'b1110100011000100;
end
else if (pixel_index == (char_y*96 + char_x) + 576 || pixel_index == (char_y*96 + char_x) + 672 || pixel_index == (char_y*96 + char_x) + 674 || pixel_index == (char_y*96 + char_x) + 675 || pixel_index == (char_y*96 + char_x) + 769 || pixel_index == (char_y*96 + char_x) + 768 || pixel_index == (char_y*96 + char_x) + 772 || (pixel_index <= (char_y*96 + char_x) + 868 && pixel_index >= (char_y*96 + char_x) + 865) || (pixel_index <= (char_y*96 + char_x) + 964 && pixel_index >= (char_y*96 + char_x) + 961)) oled_data = 16'b1110100011000100;
end

else begin
if (pixel_index == (char_y*96 + char_x) + 288 || pixel_index == (char_y*96 + char_x) + 290 || pixel_index == (char_y*96 + char_x) + 480 || pixel_index == (char_y*96 + char_x) + 672 || pixel_index ==(char_y*96 + char_x) +  865 || pixel_index == (char_y*96 + char_x) + 289 || pixel_index == (char_y*96 + char_x) + 384 || pixel_index == (char_y*96 + char_x) + 576 || pixel_index == (char_y*96 + char_x) + 769) oled_data = 16'b0100001000001000;
else if (pixel_index == (char_y*96 + char_x) + 386 || pixel_index == (char_y*96 + char_x) + 482 || pixel_index == (char_y*96 + char_x) + 579) oled_data = 16'b1001101011000111;
else if (pixel_index == (char_y*96 + char_x) + 481 || pixel_index == (char_y*96 + char_x) + 577 || pixel_index == (char_y*96 + char_x) + 673) oled_data = 16'b1011010110110110;
end

end

else if (facing_right) begin
if (((pixel_index >= (char_y*96 + char_x) + 4) && (pixel_index <= (char_y*96 + char_x) + 6)) || pixel_index == (char_y*96 + char_x) + 99 || pixel_index == (char_y*96 + char_x) + 103) oled_data = 16'b1100010010100010;
else if ((pixel_index >= (char_y*96 + char_x) + 100) && (pixel_index <= (char_y*96 + char_x) + 101)) oled_data = 16'b1111111000100010;
else if (pixel_index == (char_y*96 + char_x) + 102) oled_data = 16'b1111111000100001;
else if (pixel_index == (char_y*96 + char_x) + 196) oled_data = 16'b0011100000000010;
else if (pixel_index == (char_y*96 + char_x) + 197 || ((pixel_index >= (char_y*96 + char_x) + 293) && (pixel_index <= (char_y*96 + char_x) + 294)) || pixel_index == (char_y*96 + char_x) + 389 || pixel_index == (char_y*96 + char_x) + 679) oled_data = 16'b1110010101101111;
else if (pixel_index == (char_y*96 + char_x) + 198 || pixel_index == (char_y*96 + char_x) + 390) oled_data = 16'b1110010100101111;
else if (pixel_index == (char_y*96 + char_x) + 292) oled_data = 16'b0011000000000010;
else if (pixel_index == (char_y*96 + char_x) + 484 || pixel_index == (char_y*96 + char_x) + 486 || pixel_index == (char_y*96 + char_x) + 676 || pixel_index == (char_y*96 + char_x) + 774) oled_data = 16'b0001001010000100;
else if (pixel_index == (char_y*96 + char_x) + 485 || pixel_index == (char_y*96 + char_x) + 677) oled_data = 16'b0010010101101001;
else if (pixel_index == (char_y*96 + char_x) + 580 || pixel_index == (char_y*96 + char_x) + 773) oled_data = 16'b0001101010000101;
else if (pixel_index == (char_y*96 + char_x) + 581 || pixel_index == (char_y*96 + char_x) + 678) oled_data = 16'b0010010110101001;
else if (pixel_index == (char_y*96 + char_x) + 582 || pixel_index == (char_y*96 + char_x) + 772) oled_data = 16'b0001001010000101;
else if (pixel_index == (char_y*96 + char_x) + 868 || pixel_index == (char_y*96 + char_x) + 870 || pixel_index == (char_y*96 + char_x) + 964 || pixel_index == (char_y*96 + char_x) + 966 || pixel_index == (char_y*96 + char_x) + 1060 || pixel_index == (char_y*96 + char_x) + 1062 || pixel_index == (char_y*96 + char_x) + 1156 || pixel_index == (char_y*96 + char_x) + 1158 || pixel_index == (char_y*96 + char_x) + 1252) oled_data = 16'b0010000101000101;
else if (pixel_index == (char_y*96 + char_x) + 869 || pixel_index == (char_y*96 + char_x) + 1061 || pixel_index == (char_y*96 + char_x) + 1253) oled_data = 16'b0011000111010011;
else if (pixel_index == (char_y*96 + char_x) + 965 || pixel_index == (char_y*96 + char_x) + 1157) oled_data = 16'b0010100110010011;
else if (pixel_index == (char_y*96 + char_x) + 1254) oled_data = 16'b0001100101000101;
else if ((pixel_index >= (char_y*96 + char_x) + 1348) && (pixel_index <= (char_y*96 + char_x) + 1351)) oled_data = 16'b0111101000000101;

if (sw[0]) begin //Watering can
if (btnC) begin //Spraying
if (pixel_index == (char_y*96 + char_x) + 680 || ((pixel_index >= (char_y*96 + char_x) + 871) && (pixel_index <= (char_y*96 + char_x) + 872)) || (pixel_index >= (char_y*96 + char_x) + 1065) && (pixel_index <= (char_y*96 + char_x) + 1066) || 
pixel_index == (char_y*96 + char_x) + 776 || pixel_index == (char_y*96 + char_x) + 967 || pixel_index == (char_y*96 + char_x) + 969 || pixel_index == (char_y*96 + char_x) + 968) oled_data = 16'b1110100011000100;
if (pixel_index == (char_y*96 + char_x) + 1162 || pixel_index == (char_y*96 + char_x) + 1257 || pixel_index == (char_y*96 + char_x) + 1259
|| pixel_index == (char_y*96 + char_x) + 1352 || pixel_index == (char_y*96 + char_x) + 1354 || pixel_index == (char_y*96 + char_x) + 1356) oled_data = 16'b0000000000011111;
end
else
if (pixel_index == (char_y*96 + char_x) + 587 || pixel_index == (char_y*96 + char_x) + 680 || pixel_index == (char_y*96 + char_x) + 681 || pixel_index == (char_y*96 + char_x) + 683 || pixel_index == (char_y*96 + char_x) + 775 || pixel_index == (char_y*96 + char_x) + 778 || pixel_index == (char_y*96 + char_x) + 779 || pixel_index == (char_y*96 + char_x) + 871 || pixel_index == (char_y*96 + char_x) + 872 || pixel_index == (char_y*96 + char_x) + 873 || pixel_index == (char_y*96 + char_x) + 874 || pixel_index == (char_y*96 + char_x) + 967 || pixel_index == (char_y*96 + char_x) + 968 || pixel_index == (char_y*96 + char_x) + 969 || pixel_index == (char_y*96 + char_x) + 970) oled_data = 16'b1110100011000100;
end
else begin
if (pixel_index == (char_y*96 + char_x) + 296 || pixel_index == (char_y*96 + char_x) + 298 || pixel_index == (char_y*96 + char_x) + 490) oled_data = 16'b0100101001001001;
else if (pixel_index == (char_y*96 + char_x) + 297 || pixel_index == (char_y*96 + char_x) + 394 || pixel_index == (char_y*96 + char_x) + 586) oled_data = 16'b0100001000001000;
else if (pixel_index == (char_y*96 + char_x) + 392 || pixel_index == (char_y*96 + char_x) + 488 || pixel_index == (char_y*96 + char_x) + 583) oled_data = 16'b1001101011000111;
else if (pixel_index == (char_y*96 + char_x) + 489 || pixel_index == (char_y*96 + char_x) + 585 || pixel_index == (char_y*96 + char_x) + 681) oled_data = 16'b1011010110110110;
else if (pixel_index == (char_y*96 + char_x) + 682 || pixel_index == (char_y*96 + char_x) + 777) oled_data = 16'b0100001000001001;
else if (pixel_index == (char_y*96 + char_x) + 873) oled_data = 16'b0100101001001000;
end



end


end



endmodule
