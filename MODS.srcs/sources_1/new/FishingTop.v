`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 11:47:19
// Design Name: 
// Module Name: FishingTop
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


module FishingTop(
input MAIN_CLK, //100MHZ
input [7:0] sw,
input btnC, btnU, btnD, btnL, btnR, input [12:0] pixel_index,
input fish,

input signed [4:0] input_bait_count,
output reg signed [4:0] output_bait_count,
input signed [4:0] input_carp_count,
output reg signed [4:0] output_carp_count,
input signed [4:0] input_bluetang_count,
output reg signed [4:0] output_bluetang_count,
input signed [4:0] input_koi_count,
output reg signed [4:0] output_koi_count,

output reg [15:0] led = 0, 
output reg[15:0] oled_data,
output gobackFarmFromFish
    );
    
    wire clk6p25m;
    flexible_clock fc_6p25MHz(.basys_clock(MAIN_CLK),.count(7),.SLOW_CLOCK(clk6p25m));
    wire [6:0] x;
    wire [5:0] y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    wire [15:0] fishing_oled_data;
    wire [15:0] fishing_led;
    
   // reg signed [4:0] input_bait_count;
    wire signed[4:0] output_bait_count;
   // reg signed [4:0] input_carp_count;
    wire signed[4:0] output_carp_count;
   // reg signed [4:0] input_bluetang_count;
    wire signed[4:0] output_bluetang_count;
   // reg signed [4:0] input_koi_count;
    wire signed[4:0] output_koi_count; 
    
    reg fishing_view = 1;
    wire farming_view;
    reg [1:0] rod_num;
    
    my_fishing_control fcm(
        .basys_clk(MAIN_CLK),
        .sw(sw),
        .btnC(btnC),
        .btnU(btnU),
        .btnD(btnD),
        .btnL(btnL),
        .btnR(btnR),
        .x(x),
        .y(y),
        .rod_num(rod_num),
        .fishing_view(fishing_view),
        .farming_view(farming_view),
        .oled_data(fishing_oled_data),
        .led(fishing_led),
        .output_bait_count(output_bait_count),
        .output_carp_count(output_carp_count),
        .output_bluetang_count(output_bluetang_count),
        .output_koi_count(output_koi_count),
        .gobackFarmFromFish(gobackFarmFromFish),
        .fish(fish),
        .input_bait_count(input_bait_count),
        .input_carp_count(input_carp_count),
        .input_bluetang_count(input_bluetang_count),
        .input_koi_count(input_koi_count)
        );
    
    
    always @ (*) 
        begin
        if(fishing_view == 1)
        begin
           rod_num <= {sw[7], sw[6]};
           oled_data <= fishing_oled_data;
       //    led <= fishing_led;
           //input_bait_count <= (input_bait_count - (input_bait_count - output_bait_count));
          // output1_bait_count <= output_bait_count;
           //input_carp_count <= (input_carp_count - (input_carp_count - output_carp_count));
         //  output1_carp_count <= output_carp_count;
           //input_bluetang_count <= (input_bluetang_count - (input_bluetang_count - output_bluetang_count));
        //   output1_bluetang_count <= output_bluetang_count;
           //input_koi_count <= (input_koi_count - (input_koi_count - output_koi_count));
        //   output1_koi_count <= output_koi_count;
        end
    //    else
    //    begin
    //       oled_data <= 16'h07E0;
    //       led[15:0] <= fishing_led[15:0];
    //    end
    end
    
endmodule