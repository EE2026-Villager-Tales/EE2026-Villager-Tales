`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 11:55:10
// Design Name: 
// Module Name: my_fishing_control
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


module my_fishing_control(
    input basys_clk,
    input [15:0] sw,
    input btnC,
    input btnU, 
    input btnD,
    input btnL,
    input btnR, 
    input [6:0] x,
    input [5:0] y,
    input [1:0] rod_num,
    input fishing_view,
    output farming_view,
    output reg [15:0] oled_data = 0,
    output reg [15:0] led = 0,
    output signed [4:0] output_bait_count,
    output signed [4:0] output_carp_count,
    output signed [4:0] output_bluetang_count,
    output signed [4:0] output_koi_count,
    
    input signed [4:0] input_bait_count,
    input signed [4:0] input_carp_count,
    input signed [4:0] input_bluetang_count,
    input signed [4:0] input_koi_count,

    input fish,
    output gobackFarmFromFish
    );
    
    
    // Character movement
    wire [6:0] char_x;
    wire [5:0] char_y;
    wire facing_down;
    wire facing_up;
    wire facing_left;
    wire facing_right;
    wire fishing_start_pbC;
    wire oled_sig;
    
    my_fishing_movement fm(
        .basys_clk(basys_clk),
        .btnU(btnU), 
        .btnD(btnD), 
        .btnL(btnL), 
        .btnR(btnR), 
        .oled_sig(oled_sig),
        .fishing_view(fishing_view),
        .char_x(char_x), 
        .char_y(char_y),
        .facing_down(facing_down),
        .facing_up(facing_up),
        .facing_left(facing_left),
        .facing_right(facing_right),
        .farming_view(farming_view),
        .fishing_start_pbC(fishing_start_pbC),
        
        .fish(fish),
        .gobackFarmFromFish(gobackFarmFromFish),
        .btnC(btnC)
        );
    
    
    
    // Pushbutton_debouncer
    wire pbC_sig;
    wire values_sig;
    my_pushbutton_debouncer pdC (
        .basys_clk(basys_clk), 
        .btn(btnC), 
        .fishing_start_pbC(fishing_start_pbC),
        .bait_count(input_bait_count),
        .rod_num(rod_num),
        .debounced_sig(pbC_sig),
        .oled_sig(oled_sig),
        .values_sig(values_sig)
        );
    
    // Clock mux for Random number generator 
    wire rgn_clk;
    my_rgn_clock_mux rcm (
        .basys_clk(basys_clk), 
        .debounced_sigC(pbC_sig), 
        .output_clock(rgn_clk)
        );
        
    // Random number generator
    wire [3:0] rng_output;
    my_lfsr_rng rng (
        .input_clk(rgn_clk), 
        .output_num(rng_output)
        );
        
    // Value changer
    wire [1:0] fish_num;
    assign fish_num[1:0] = rng_output[1:0];
    my_fishing_change_values fcv(
        .values_sig(values_sig),
        .fish_num(fish_num),
        .output_bait_count(output_bait_count),
        .output_carp_count(output_carp_count),
        .output_bluetang_count(output_bluetang_count),
        .output_koi_count(output_koi_count),
        .input_bait_count(input_bait_count),
        .input_carp_count(input_carp_count),
        .input_bluetang_count(input_bluetang_count),
        .input_koi_count(input_koi_count)
    );
        

    
    // Fishing sequence counter
    wire [4:0] sequence;
    my_fishing_sequence_counter fsc(
        .basys_clk(basys_clk),
        .fishing_start_pbC(fishing_start_pbC),
        .oled_sig(oled_sig),
        .my_sequence(sequence)
        );
    
    // Fishing frame counter
    wire [1:0] zoom_in;
    wire [1:0] man_frame;
    wire [3:0] rod_frame;
    wire bait_frame;
    wire fish_frame;
    wire submerged;
    wire [6:0] x_zichar;
    wire [5:0] y_zichar;
    wire [6:0] x_bait;
    wire [6:0] y_bait;
    wire [6:0] x_fish;
    wire [5:0] y_fish;
    wire bait_ripple;
    wire [1:0]rod_ripple;
    my_fishing_frame_counter ffc(
        .my_sequence(sequence),        
        .zoom_in(zoom_in),
        .man_frame(man_frame),
        .rod_frame(rod_frame),
        .bait_frame(bait_frame),
        .fish_frame(fish_frame),
        .submerged(submerged),
        .x_zichar(x_zichar),
        .y_zichar(y_zichar),
        .x_bait(x_bait),
        .y_bait(y_bait),
        .x_fish(x_fish),
        .y_fish(y_fish),
        .bait_ripple(bait_ripple),
        .rod_ripple(rod_ripple)
        );
        
    
    
    // OLED DISPLAY
    wire [15:0] fishing1_oled_data;
    wire [15:0] fishing2_oled_data;
    wire [15:0] fishing3_oled_data;
    
    my_fishing_display3 fd3 (
            .basys_clk(basys_clk), 
            .sw(sw), 
            .x(x), 
            .y(y), 
            .char_x(char_x), 
            .char_y(char_y),
            .facing_down(facing_down),
            .facing_up(facing_up),
            .facing_left(facing_left),
            .facing_right(facing_right),
            .oled_data(fishing3_oled_data)
            );
    
    my_fishing_display1 fd1 (
        .basys_clk(basys_clk), 
        .sw(sw), 
        .x(x), 
        .y(y), 
        .oled_data(fishing1_oled_data)
        );
        
    my_fishing_display2 fd2 (
        .basys_clk(basys_clk), 
        .sw(sw), 
        .x(x), 
        .y(y), 
        .fish_num(fish_num), 
        .rod_num(rod_num), 
        .man_frame(man_frame),
        .rod_frame(rod_frame),
        .bait_frame(bait_frame),
        .fish_frame(fish_frame),
        .submerged(submerged),
        .x_zichar(x_zichar),
        .y_zichar(y_zichar),
        .x_bait(x_bait),
        .y_bait(y_bait),
        .x_fish(x_fish),
        .y_fish(y_fish),
        .bait_ripple(bait_ripple),
        .rod_ripple(rod_ripple),
        .oled_data(fishing2_oled_data)
        );

        
    always @ (*) 
        begin
            if(zoom_in == 0)
                begin
                   oled_data[15:0] <= fishing3_oled_data[15:0];
                  led[15:12] <= output_bait_count;
                   led[11:8] <= output_carp_count;
                   led[7:4] <= output_bluetang_count;
                   led[3:0] <= output_koi_count;
                end
            else if(zoom_in == 2)
                begin
                   oled_data[15:0] <= fishing1_oled_data[15:0];
                   led[15:12] <= output_bait_count;
                   led[11:8] <= output_carp_count;
                  led[7:4] <= output_bluetang_count;
                   led[3:0] <= output_koi_count;
                end
            else if(zoom_in == 1)
                begin
                   oled_data[15:0] <= fishing2_oled_data[15:0];
                   led[15:12] <= output_bait_count;
                   led[11:8] <= output_carp_count;
                   led[7:4] <= output_bluetang_count;
                   led[3:0] <= output_koi_count;
                end
        end 
    

    endmodule
