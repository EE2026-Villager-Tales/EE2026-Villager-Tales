`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2024 09:33:07
// Design Name: 
// Module Name: my_fishing_frame_counter
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


module my_fishing_frame_counter(
    input [4:0] my_sequence,
    
    output reg [1:0] zoom_in = 0,
    
    output reg [1:0] man_frame = 0,
    output reg [3:0] rod_frame = 0,
    output reg bait_frame = 0,
    output reg fish_frame = 0,
    output reg submerged = 0,
    
    output reg [6:0] x_zichar = 35,
    output reg [5:0] y_zichar = 21,
    output reg [6:0] x_bait = 53,
    output reg [6:0] y_bait = 31,
    output reg [6:0] x_fish = 63,
    output reg [5:0] y_fish = 24,
    output reg bait_ripple,
    output reg [1:0]rod_ripple
    );
  
    always @ (*)
        begin
        case(my_sequence)
            5'b00000: begin //original zoom out 1
                          zoom_in <= 0;
                      end
            5'b00001: begin // zoom out 2
                          zoom_in <= 2;
                      end
                      
                      
            5'b00010: begin //zoom in 1 - front view man
                          zoom_in <= 1;
                          man_frame <= 1; // front view man
                          bait_frame <= 0;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            5'b00011: begin //zoom in 1 - side view man
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          bait_frame <= 0;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
                      
                      
            5'b00100: begin //zi1 - bait 1 (hold bait)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          x_bait <= 53;
                          y_bait <= 31;
                          bait_frame <= 1;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            5'b00101: begin // //zi1 - bait 2 (throw 1)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          x_bait <= 59;
                          y_bait <= 28;
                          bait_frame <= 1;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            5'b00110: begin // //zi1 - bait 2 (throw 2)
                          zoom_in <= 1;
                          man_frame[1:0] <= 2; // side view man
                          x_bait <= 66;
                          y_bait <= 27;
                          bait_frame <= 1;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            5'b00111: begin // //zi1 - bait 2 (throw 3 with ripple)
                          zoom_in = 1;
                          man_frame[1:0] <= 2; // side view man
                          x_bait <= 69;
                          y_bait <= 38;
                          bait_frame <= 1;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 1;
                          rod_ripple <= 0;
                      end
            5'b01000: begin //zoom in 1 - side view man
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          bait_frame <= 0;
                          rod_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end

                      
            5'b01001: begin //zoom in 1 - rod 1 (hold rod)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 1;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                          
                      end
            5'b01010: begin //zoom in 1 - rod 2 (cast 1)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 2;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end    
            5'b01011: begin //zoom in 1 - rod 3 (cast 2)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 3;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;  
                          bait_ripple <= 0; 
                          rod_ripple <= 0;                       
                      end                      
            5'b01100: begin //zoom in 1 - rod 4 (cast 3)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 4;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;       
                          bait_ripple <= 0;        
                          rod_ripple <= 0;           
                      end                      
                      
                      
            5'b01101: begin //zoom in 1 - rod 5 (wait 1)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;    
                          bait_ripple <= 0;        
                          rod_ripple <= 1;              
                      end                      
            5'b01110: begin //zoom in 1 - rod 5 (wait 2)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;       
                          bait_ripple <= 0;           
                          rod_ripple <= 2;        
                      end                      
            5'b01111: begin //zoom in 1 - rod 6 (wait 3)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 6;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;            
                          bait_ripple <= 0;           
                          rod_ripple <= 3;   
                      end                      
            5'b10000: begin //zoom in 1 - rod 5 (wait 2)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;          
                          bait_ripple <= 0;                
                          rod_ripple <= 2;
                      end
            5'b10001: begin //zoom in 1 - rod 5 (wait 1)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;   
                          bait_ripple <= 0;             
                          rod_ripple <= 1;          
                      end      
            5'b01110: begin //zoom in 1 - rod 5 (wait 2)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;       
                          bait_ripple <= 0;        
                          rod_ripple <= 2;           
                      end                      
            5'b01111: begin //zoom in 1 - rod 6 (wait 3)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 6;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;           
                          bait_ripple <= 0;       
                          rod_ripple <= 3;        
                      end                      
            5'b10000: begin //zoom in 1 - rod 5 (wait 2)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 2;
                      end
            5'b10001: begin //zoom in 1 - rod 5 (wait 1)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 5;
                          bait_frame <= 0;
                          fish_frame <= 0;
                          submerged <= 0;            
                          bait_ripple <= 0;             
                          rod_ripple <= 1; 
                      end


            5'b10010: begin //zoom in 1 - rod 7 (reel 1 - half fish)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 7;
                          fish_frame <=1;
                          submerged <=1;
                          x_fish <= 63;
                          y_fish <= 30;
                          bait_frame <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end                      
            5'b10011: begin //zoom in 1 - rod 8 (reel 2 - full fish)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 8;
                          fish_frame <=1;
                          submerged <=0;
                          x_fish <= 63;
                          y_fish <= 24;
                          bait_frame <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end                      
            5'b10100: begin //zoom in 1 - rod 9 (reel 3 - full fish)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 9;
                          fish_frame <=1;
                          submerged <=0;
                          x_fish <= 58;
                          y_fish <= 22;
                          bait_frame <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            5'b10101: begin //zoom in 1 - rod 10 (reel 4 - full fish)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 10;
                          fish_frame <=1;
                          submerged <=0;
                          x_fish <= 54;
                          y_fish <= 17;
                          bait_frame <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            5'b10110: begin //zoom in 1 - rod 1 (hold rod)
                          zoom_in <= 1;
                          man_frame <= 2; // side view man
                          rod_frame <= 1;
                          fish_frame <=0;
                          bait_frame <= 0;
                          bait_ripple <= 0;
                          rod_ripple <= 0;
                      end
            
            
            5'b10111: begin // zoom out 2
                          zoom_in <= 2;
                      end
            5'b11000: begin //original zoom out 1
                          zoom_in <= 0;
                      end
            endcase
        end
    
endmodule
