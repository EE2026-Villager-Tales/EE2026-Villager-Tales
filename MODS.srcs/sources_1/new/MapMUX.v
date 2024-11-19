`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2024 23:40:13
// Design Name: 
// Module Name: MapMUX
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


module MapMUX(
input [2:0] currentTask, 
input shop,
input fish,
input home,
input [15:0] current,

input [15:0] oled_dataWin,
input [15:0] oled_dataFarm, input [15:0] oled_dataShop,
input [15:0] oled_dataFish, input [15:0] oled_dataHome,
input btnC, input btnU, input btnD, input btnL, input btnR,
output btnCFarm, output btnUFarm, output btnDFarm, output btnLFarm, output btnRFarm,
output btnCShop, output btnUShop, output btnDShop, output btnLShop, output btnRShop,
output btnCFish, output btnUFish, output btnDFish, output btnLFish, output btnRFish,
output btnCHome, output btnUHome, output btnDHome, output btnLHome, output btnRHome,
output btnCWin,
input dismissed,
output [15:0] oled_data
    );
    
    assign oled_data = (current > 9000 && !dismissed) ? oled_dataWin : (home == 1) ? oled_dataHome : (fish == 1) ? oled_dataFish : (shop == 0) ? oled_dataFarm : oled_dataShop;
        
        assign btnCWin = (current > 9000 && !dismissed) ? btnC : 0;
        
        assign btnCFarm = (shop == 0) ? btnC : 0;
        assign btnUFarm = (shop == 0) ? btnU : 0;
        assign btnDFarm = (shop == 0) ? btnD : 0;
        assign btnLFarm = (shop == 0) ? btnL : 0;
        assign btnRFarm = (shop == 0) ? btnR : 0;
        
        assign btnCShop = (shop == 1) ? btnC : 0;
        assign btnUShop = (shop == 1) ? btnU : 0;
        assign btnDShop = (shop == 1) ? btnD : 0;
        assign btnLShop = (shop == 1) ? btnL : 0;
        assign btnRShop = (shop == 1) ? btnR : 0;
        
        assign btnCFish = (fish == 1) ? btnC : 0;
        assign btnUFish = (fish == 1) ? btnU : 0;
        assign btnDFish = (fish == 1) ? btnD : 0;
        assign btnLFish = (fish == 1) ? btnL : 0;
        assign btnRFish = (fish == 1) ? btnR : 0;
        
        assign btnCHome = (home == 1) ? btnC : 0;
        assign btnUHome = (home == 1) ? btnU : 0;
        assign btnDHome = (home == 1) ? btnD : 0;
        assign btnLHome = (home == 1) ? btnL : 0;
        assign btnRHome = (home == 1) ? btnR : 0;
    
/*    assign oled_data = (currentTask == 0) ? oled_dataFarm : oled_dataShop;
    assign btnCFarm = (currentTask == 0) ? btnC : 0;
    assign btnUFarm = (currentTask == 0) ? btnU : 0;
    assign btnDFarm = (currentTask == 0) ? btnD : 0;
    assign btnLFarm = (currentTask == 0) ? btnL : 0;
    assign btnRFarm = (currentTask == 0) ? btnR : 0;
    
    assign btnCShop = (currentTask == 1) ? btnC : 0;
    assign btnUShop = (currentTask == 1) ? btnU : 0;
    assign btnDShop = (currentTask == 1) ? btnD : 0;
    assign btnLShop = (currentTask == 1) ? btnL : 0;
    assign btnRShop = (currentTask == 1) ? btnR : 0; */
    
  /*  assign btnCFish = (currentTask == 2) ? btnC : 0;
    assign btnUFish = (currentTask == 2) ? btnU : 0;
    assign btnDFish = (currentTask == 2) ? btnD : 0;
    assign btnLFish = (currentTask == 2) ? btnL : 0;
    assign btnRFish = (currentTask == 2) ? btnR : 0; */
    
    
endmodule
