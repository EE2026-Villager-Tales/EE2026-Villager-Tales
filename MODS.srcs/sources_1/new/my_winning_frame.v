`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 12:37:49
// Design Name: 
// Module Name: my_winning_frame
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


module my_winning_frame(
    input basys_clk, 
    input [6:0] x,
    input [5:0] y,
    input btnC,
    output reg dismissed = 0,

    output reg [15:0] oled_data = 0
);

reg [6:0] words_x = 11;
reg [5:0] words_y = 26;


    wire clk_25MHz;
    flexible_clock fc_25MHz (.basys_clock(basys_clk),.count(2),.SLOW_CLOCK(clk_25MHz));

    wire clk_500ms;
    flexible_clock fc_500ms (.basys_clock(basys_clk),.count(25_999_999),.SLOW_CLOCK(clk_500ms));
    
    always @ (posedge clk_25MHz)
    begin
    if (btnC) dismissed = 1;
    	//Black background
        oled_data <= 16'b00000_000000_00000;

        //Words
        if (clk_500ms == 1)
            begin
                if ( ((y == words_y) && (((x >= words_x + 0) && (x <= words_x + 3)) ||        //C
                                          ((x >= words_x + 5) && (x <= words_x + 8)) ||       //0
                                          ((x == words_x + 10) || (x == words_x + 13)) ||     //N
                                          ((x >= words_x + 15) && (x <= words_x + 18)) ||     //G
                                          ((x >= words_x + 20) && (x <= words_x + 23)) ||     //R
                                          ((x >= words_x + 25) && (x <= words_x + 28)) ||     //A
                                          ((x >= words_x + 30) && (x <= words_x + 34)) ||     //T
                                          ((x == words_x + 36) || (x == words_x + 39)) ||     //U
                                          (x == words_x + 41) ||                              //L
                                          ((x >= words_x + 46) && (x <= words_x + 49)) ||     //A
                                          ((x >= words_x + 51) && (x <= words_x + 55)) ||     //T
                                          ((x >= words_x + 58) && (x <= words_x + 60)) ||     //I
                                          ((x >= words_x + 61) && (x <= words_x + 64)) ||     //0
                                          ((x == words_x + 66) || (x == words_x + 69)) ||     //N
                                          ((x >= words_x + 71) && (x <= words_x + 74)) )) ||  //S
                                          
                   ((y == words_y+1) && ((x == words_x + 0) ||      //C
                                        ((x == words_x + 5) || (x == words_x + 8)) ||       //0
                                        ((x == words_x + 10) || (x == words_x + 11) || (x == words_x + 13)) ||     //N
                                        (x == words_x + 15) ||     //G
                                        ((x == words_x + 20) || (x == words_x + 23)) ||     //R
                                        ((x == words_x + 25) || (x == words_x + 28)) ||     //A
                                        (x == words_x + 32) ||     //T
                                        ((x == words_x + 36) || (x == words_x + 39)) ||     //U
                                        (x == words_x + 41) ||                              //L
                                        ((x == words_x + 46) || (x == words_x + 49)) ||     //A
                                        (x == words_x + 53) ||     //T
                                        (x == words_x + 58) ||     //I
                                        ((x == words_x + 61) || (x == words_x + 64)) ||     //0
                                        ((x == words_x + 66) || (x == words_x + 67) || (x == words_x + 69)) ||     //N
                                        (x == words_x + 71) )) ||  //S
                                        
                   ((y == words_y+2) && ((x == words_x + 0) ||      //C
                                         (x == words_x + 5) || (x == words_x + 8) ||       //0
                                         (x == words_x + 10) || (x == words_x + 11) || (x == words_x + 11) || (x == words_x + 13) ||     //N
                                         (x == words_x + 15) ||  (x == words_x + 17) || (x == words_x + 18) ||   //G
                                         ((x >= words_x + 20) && (x <= words_x + 23)) ||     //R
                                         ((x >= words_x + 25) && (x <= words_x + 28)) ||     //A
                                         (x == words_x + 32) ||     //T
                                         (x == words_x + 36) || (x == words_x + 39) ||     //U
                                         (x == words_x + 41) ||                              //L
                                         ((x >= words_x + 46) && (x <= words_x + 49)) ||     //A
                                         (x == words_x + 53) ||     //T
                                         (x == words_x + 58) ||     //I
                                         (x == words_x + 61) || (x == words_x + 64) ||     //0
                                         ((x >= words_x + 66) && (x <= words_x + 69)) ||     //N
                                         ((x >= words_x + 71) && (x <= words_x + 74)) )) ||  //S

                   ((y == words_y+3) && ((x == words_x + 0) ||      //C
                                        ((x == words_x + 5) || (x == words_x + 8)) ||       //0
                                        ((x == words_x + 10) || (x == words_x + 12) || (x == words_x + 13)) ||     //N
                                        (x == words_x + 15) || (x == words_x + 18) ||     //G
                                        ((x == words_x + 20) || (x == words_x + 22)) ||     //R
                                        ((x == words_x + 25) || (x == words_x + 28)) ||     //A
                                        (x == words_x + 32) ||     //T
                                        ((x == words_x + 36) || (x == words_x + 39)) ||     //U
                                        (x == words_x + 41) ||                              //L
                                        ((x == words_x + 46) || (x == words_x + 49)) ||     //A
                                        (x == words_x + 53) ||     //T
                                        (x == words_x + 58) ||     //I
                                        ((x == words_x + 61) || (x == words_x + 64)) ||     //0
                                        ((x == words_x + 66) || (x == words_x + 68) || (x == words_x + 69)) ||     //N
                                        (x == words_x + 74) )) ||  //S
                                        
                ((y == words_y+4) && (((x >= words_x + 0) && (x <= words_x + 3)) ||        //C
                                  ((x >= words_x + 5) && (x <= words_x + 8)) ||       //0
                                  ((x == words_x + 10) || (x == words_x + 13)) ||     //N
                                  ((x >= words_x + 15) && (x <= words_x + 18)) ||     //G
                                  ((x == words_x + 20) || (x == words_x + 23)) ||     //R
                                  ((x == words_x + 25) || (x == words_x + 28)) ||     //A
                                  (x == words_x + 32) ||     //T
                                  ((x >= words_x + 36) && (x <= words_x + 39)) ||     //U
                                  ((x >= words_x + 41) && (x <= words_x + 44)) ||     //L
                                  ((x == words_x + 46) || (x == words_x + 49)) ||     //A
                                  (x == words_x + 53) ||     //T
                                  ((x >= words_x + 58) && (x <= words_x + 60)) ||     //I
                                  ((x >= words_x + 61) && (x <= words_x + 64)) ||     //0
                                  ((x == words_x + 66) || (x == words_x + 69)) ||     //N
                                  ((x >= words_x + 71) && (x <= words_x + 74)) )) )  //S
                    begin
                        oled_data <= 16'b11000_100101_00010; // Dark Yellow
                    end
            
            end
            
    end
endmodule
