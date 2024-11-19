`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Yar Xin Ning
//  STUDENT B NAME: Ong Zheng Kai
//  STUDENT C NAME: Viswanathan Ravisankar
//  STUDENT D NAME: Ng Chee Fong
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
input MAIN_CLK, //100MHZ
input btnU ,btnD ,btnC ,btnL ,btnR ,
input [7:0] sw,
input [7:0] selector,
output reg [3:0]an = 4'b1110,
output reg [6:0]seg = 0,
output [7:0]JC,
output [7:0]JXADC
//output [7:0]led
);
//assign led = fishcarp_count_out;

wire fb, sending_pixels, sample_bits;
wire fb2, sending_pixels2, sample_bits2;
wire [12:0] pixel_index;  // 12-bit pixel index for 64x64 resolution
wire [12:0] pixel_index2;  // 12-bit pixel index for 64x64 resolution
wire [15:0] oled_data1;     // 16-bit color data
wire [15:0] oled_data2;     // 16-bit color data

wire [15:0] oled_dataFarm;
wire [15:0] oled_dataShop;
wire [15:0] oled_dataFish;
wire [15:0] oled_dataHome;
wire [15:0] oled_dataWin;

wire [6:0] x;
wire [5:0] y;
wire [6:0] x2;
wire [5:0] y2;
reg signed [1:0] rod_num = 2'b01;
wire signed [1:0] rod_num_out1;
wire clk6p25m;
reg [3:0] an_state = 4'b1110;
reg signed [15:0] current;
wire signed [15:0] current_out;
wire [6:0] digit_output1 = 0;
wire [6:0] digit_output2 = 0;
wire [6:0] digit_output3 = 0;
wire [6:0] digit_output4 = 0;
wire sell_mode;
wire buy_mode;
reg signed [4:0] carp_count;
wire signed [4:0] carp_count_out;
reg signed [4:0] bluetang_count;
wire signed  [4:0] bluetang_count_out;
reg signed [4:0] koi_count;
wire signed [4:0] koi_count_out;
reg signed [4:0] pumpkin_count;
wire signed [4:0] pumpkin_count_out;
reg signed [4:0] wheat_count;
wire signed [4:0] wheat_count_out;
reg signed [4:0] pumpkinseed_count;
wire signed [4:0] pumpkinseed_count_out;
reg signed [4:0] wheatseed_count;
wire signed [4:0] wheatseed_count_out;
reg signed [4:0] bait_count;
wire signed [4:0] bait_count_out;
wire clk200;
wire item_code;

/*
input signed [4:0] pumpkin_count,
         output reg signed [4:0] pumpkin_count_out = 5,
         input signed [4:0] wheat_count,
         output reg signed [4:0] wheat_count_out = 5,*/

flexible_clock First_CLK(.basys_clock(MAIN_CLK),.count(7),.SLOW_CLOCK(clk6p25m));
flexible_clock Fir_CLK(.basys_clock(MAIN_CLK), .count(249_999), .SLOW_CLOCK(clk200));    


wire btnCFarm;
wire btnUFarm;
wire btnDFarm;
wire btnLFarm;
wire btnRFarm;

wire btnCShop;
wire btnUShop;
wire btnDShop;
wire btnLShop;
wire btnRShop;

wire btnCFish;
wire btnUFish;
wire btnDFish;
wire btnLFish;
wire btnRFish;

wire btnCHome;
wire btnUHome;
wire btnDHome;
wire btnLHome;
wire btnRHome;

wire shop;
wire fish;
wire home;

assign x = pixel_index % 96;
assign y = pixel_index / 96;
assign x2 = pixel_index2 % 96;
assign y2 = pixel_index2 / 96;
assign JC[2] = 0;

wire [2:0] currentTaskA;

//assign currentTask = (sw[7]) ? 1 : 0;

MapMUX(
.currentTask(currentTask),
.oled_dataFarm(oled_dataFarm),
.oled_dataShop(oled_dataShop),
.oled_dataFish(oled_dataFish),
.oled_dataHome(oled_dataHome),
.btnC(btnC),
.btnU(btnU),
.btnD(btnD),
.btnL(btnL),
.btnR(btnR),
.btnCFarm(btnCFarm),
.btnUFarm(btnUFarm), 
.btnDFarm(btnDFarm),
.btnLFarm(btnLFarm),
.btnRFarm(btnRFarm),
.btnCShop(btnCShop),
.btnUShop(btnUShop), 
.btnDShop(btnDShop),
.btnLShop(btnLShop),
.btnRShop(btnRShop),
.btnCFish(btnCFish),
.btnUFish(btnUFish), 
.btnDFish(btnDFish),
.btnLFish(btnLFish),
.btnRFish(btnRFish),
.btnCHome(btnCHome),
.btnUHome(btnUHome), 
.btnDHome(btnDHome),
.btnLHome(btnLHome),
.btnRHome(btnRHome),
.oled_data(oled_data1),
.shop(shop),
.fish(fish),
.home(home),
.current(current),
.oled_dataWin(oled_dataWin),
.btnCWin(btnCWin),
.dismissed(dismissed)
    );
    
    wire btnCWin;
    wire dismissed;
    
my_winning_frame Win(
        .basys_clk(MAIN_CLK), 
        .x(x),
        .y(y),
        .btnC(btnCWin),
        .dismissed(dismissed),
        .oled_data(oled_dataWin)
    );

    

Farm farm(
    .MAIN_CLK(MAIN_CLK), //100MHZ
    .sw(sw),
    .btnU(btnUFarm) ,.btnD(btnDFarm) ,.btnC(btnCFarm) ,.btnL(btnLFarm) ,.btnR(btnRFarm) ,
    .pixel_index(pixel_index),
    .oled_data(oled_dataFarm),
    .shop(shop),
    .fish(fish),
    .home(home),
    .gobackFarm(gobackFarm),
    .gobackFarmFromFish(gobackFarmFromFish),
    .gobackFarmFromHome(gobackFarmFromHome),
    .wheat_count(wheat_count),
    .wheat_output(wheat_output),
    .pumpkin_count(pumpkin_count),
    .pumpkin_output(pumpkin_output),
    .day(day)
);

wire [31:0] day;

Home home1(
.MAIN_CLK(MAIN_CLK), //100MHZ
.btnC(btnCHome), .btnU(btnUHome), .btnD(btnDHome), .btnL(btnLHome), .btnR(btnRHome),
.pixel_index(pixel_index),
.home(home),
.oled_data(oled_dataHome),
.gobackFarmFromHome(gobackFarmFromHome),
.day(day));

wire [4:0] fishbait_count_out;
wire [4:0] fishcarp_count_out;
wire [4:0] fishbluetang_count_out;
wire [4:0] fishkoi_count_out;

wire [4:0] wheat_output;
wire [4:0] pumpkin_output;

FishingTop fishing(.MAIN_CLK(MAIN_CLK), //100MHZ
.sw(sw), .btnC(btnCFish), .btnU(btnUFish), .btnD(btnDFish), .btnL(btnLFish), .btnR(btnRFish), .pixel_index(pixel_index),
.oled_data(oled_dataFish), 
.fish(fish),
.gobackFarmFromFish(gobackFarmFromFish),
//Added
.input_bait_count(bait_count),
.output_bait_count(fishbait_count_out),
.input_carp_count(carp_count),
.output_carp_count(fishcarp_count_out),
.input_bluetang_count(bluetang_count),
.output_bluetang_count(fishbluetang_count_out),
.input_koi_count(koi_count),
.output_koi_count(fishkoi_count_out)
    ); 
    

    
wire gobackFarm;
wire gobackFarmFromFish;

    D_Milestone Milestonel (
        .pixel_index(pixel_index),
        .start_task(1),
        .x(x),
        .y(y),
        .basys_clock(MAIN_CLK),
        .display_clock(clk6p25m),
        .btnU(btnUShop), 
        .btnD(btnDShop),
        .btnC(btnCShop), 
        .btnL(btnLShop), 
        .btnR(btnRShop),
        .rod_num(rod_num),
        .rod_num_out(rod_num_out1),
        .oled_data(oled_dataShop),
        .sell_mode(sell_mode),
        .buy_mode(buy_mode),
        .current(current),
        .current_out(current_out),
        .item_code(item_code),
        .carp_count(carp_count),
        .carp_count_out(carp_count_out),
                .bluetang_count(bluetang_count),
                .bluetang_count_out(bluetang_count_out),
                .koi_count(koi_count),
                .koi_count_out(koi_count_out),
                .pumpkin_count(pumpkin_count),
                .pumpkin_count_out(pumpkin_count_out),
                .wheat_count(wheat_count),
                .wheat_count_out(wheat_count_out),
                .pumpkinseed_count(pumpkinseed_count),
                .pumpkinseed_count_out(pumpkinseed_count_out),
                .wheatseed_count(wheatseed_count),
                .wheatseed_count_out(wheatseed_count_out),
                .bait_count(bait_count),
                .selector(selector),
                .bait_count_out(bait_count_out),
        
        .shop(shop),
        .gobackFarm(gobackFarm)
        //.inputcurrentTaskB(currentTask),
       // .outputcurrentTaskB(outputcurrentTaskB)
    );
    
    Inventory inventory(
    .pixel_index2(pixel_index2),   // Pixel index (0-8191 for 96x64 screen)
    .start_task(1),
    .x(x2),              // x-coordinate (0-95)
    .y(y2),              // y-coordinate (0-63)
    .basys_clock(MAIN_CLK),
    .display_clock(clk6p25m),
    .rod_num(rod_num),    
    .selector(selector),
    .sell_mode(sell_mode),
    .buy_mode(buy_mode),
    .oled_data2(oled_data2),
    .carp_count(carp_count),
        .bluetang_count(bluetang_count),
        .koi_count(koi_count),
        .pumpkin_count(pumpkin_count),
        .wheat_count(wheat_count),
        .pumpkinseed_count(pumpkinseed_count),
        .wheatseed_count(wheatseed_count),
        .bait_count(bait_count)
        );


Oled_Display OLED(
    .clk(clk6p25m), 
    .reset(0), 
    .frame_begin(fb), 
    .sending_pixels(sending_pixels),
    .sample_pixel(sample_bits), 
    .pixel_index(pixel_index), 
    .pixel_data(oled_data1), 
    .cs(JC[0]), 
    .sdin(JC[1]), 
    .sclk(JC[3]), 
    .d_cn(JC[4]), 
    .resn(JC[5]), 
    .vccen(JC[6]),
    .pmoden(JC[7])
  );
  
  
  Oled_Display OLED2(
      .clk(clk6p25m), 
      .reset(0), 
      .frame_begin(fb2), 
      .sending_pixels(sending_pixels2),
      .sample_pixel(sample_bits2), 
      .pixel_index(pixel_index2), 
      .pixel_data(oled_data2), 
      .cs(JXADC[0]), 
      .sdin(JXADC[1]), 
      .sclk(JXADC[3]), 
      .d_cn(JXADC[4]), 
      .resn(JXADC[5]), 
      .vccen(JXADC[6]),
      .pmoden(JXADC[7])
    );
    
        // Separate each digit by dividing `current` appropriately
    reg [3:0] digit1;              // Units place
    reg [3:0] digit2;        // Tens place
    reg [3:0] digit3;      // Hundreds place
    reg [3:0] digit4;     // Thousands place
    
   // assign led = carp_count;
    /*
    seven_seg num1(
    .basys_clock(MAIN_CLK),
    .value(2),
    .seg(digit_output1)
        ); 
    seven_seg num2(
    .basys_clock(MAIN_CLK),
    .value(2),
    .seg(digit_output2)
        ); 
    seven_seg num3(
    .basys_clock(MAIN_CLK),
    .value(2),
    .seg(digit_output3)
        ); 
    seven_seg num4(
    .basys_clock(MAIN_CLK),
    .value(2),
    .seg(digit_output4)
        ); 
         */
//assign rod_num = rod_num_out1;


always @(posedge clk6p25m) begin
    rod_num <= rod_num_out1;// Separate each digit by dividing `current` appropriately
    current <= current - (current - current_out);
    //carp_count <= carp_count - (carp_count - carp_count_out) + (carp_count - carp_count_out);
    //bluetang_count <= bluetang_count - (bluetang_count - bluetang_count_out) + (bluetang_count - bluetang_count_out);
    //koi_count <= koi_count - (koi_count - koi_count_out) + fishkoi_count_out;
    carp_count <= carp_count - (carp_count - carp_count_out);
    // - (carp_count - fishcarp_count_out);
   bluetang_count <= bluetang_count - (bluetang_count - bluetang_count_out);
   // - (bluetang_count - fishbluetang_count_out);
    koi_count <= koi_count - (koi_count - koi_count_out);
    //- (koi_count - fishkoi_count_out);
    pumpkin_count <= pumpkin_count - (pumpkin_count - pumpkin_count_out);
    // - (pumpkin_count - pumpkin_output);
    wheat_count <= wheat_count - (wheat_count - wheat_count_out);
    // - (wheat_count - wheat_output);
    pumpkinseed_count <= pumpkinseed_count - (pumpkinseed_count - pumpkinseed_count_out);
    wheatseed_count <= wheatseed_count - (wheatseed_count - wheatseed_count_out);
    bait_count <= bait_count - (bait_count - bait_count_out);
    // - (bait_count - fishbait_count_out);
    digit1 <= current % 10;               // Units place
    digit2 <= (current / 10) % 10;        // Tens place
    digit3 <= (current / 100) % 10;       // Hundreds place
    digit4 <= (current / 1000) % 10;      // Thousands place    
    
end

always @ (posedge clk200) begin

    case(an_state)
        4'b1110: begin 
            an <= 4'b1110;
            case (digit1)
                4'b0000: seg <= 7'b1000000;
                4'b0001: seg <= 7'b1111001;
                4'b0010: seg <= 7'b0100100;
                4'b0011: seg <= 7'b0110000;
                4'b0100: seg <= 7'b0011001;
                4'b0101: seg <= 7'b0010010;
                4'b0110: seg <= 7'b0000010;
                4'b0111: seg <= 7'b1111000;
                4'b1000: seg <= 7'b0000000;
                4'b1001: seg <= 7'b0011000;
            endcase
            an_state <= 4'b1101;
        end
        4'b1101: begin 
            an <= 4'b1101;
                case (digit2)
                4'b0000: seg <= 7'b1000000;
                4'b0001: seg <= 7'b1111001;
                4'b0010: seg <= 7'b0100100;
                4'b0011: seg <= 7'b0110000;
                4'b0100: seg <= 7'b0011001;
                4'b0101: seg <= 7'b0010010;
                4'b0110: seg <= 7'b0000010;
                4'b0111: seg <= 7'b1111000;
                4'b1000: seg <= 7'b0000000;
                4'b1001: seg <= 7'b0011000;
            endcase
            an_state <= 4'b1011;
        end
        4'b1011: begin 
            an <= 4'b1011;
                case (digit3)
                4'b0000: seg <= 7'b1000000;
                4'b0001: seg <= 7'b1111001;
                4'b0010: seg <= 7'b0100100;
                4'b0011: seg <= 7'b0110000;
                4'b0100: seg <= 7'b0011001;
                4'b0101: seg <= 7'b0010010;
                4'b0110: seg <= 7'b0000010;
                4'b0111: seg <= 7'b1111000;
                4'b1000: seg <= 7'b0000000;
                4'b1001: seg <= 7'b0011000;
            endcase
            an_state <= 4'b0111;
        end
        4'b0111: begin 
            an <= 4'b0111;
                case (digit4)
                4'b0000: seg <= 7'b1000000;
                4'b0001: seg <= 7'b1111001;
                4'b0010: seg <= 7'b0100100;
                4'b0011: seg <= 7'b0110000;
                4'b0100: seg <= 7'b0011001;
                4'b0101: seg <= 7'b0010010;
                4'b0110: seg <= 7'b0000010;
                4'b0111: seg <= 7'b1111000;
                4'b1000: seg <= 7'b0000000;
                4'b1001: seg <= 7'b0011000;
            endcase
            an_state <= 4'b1110;
        end
    endcase
end


endmodule