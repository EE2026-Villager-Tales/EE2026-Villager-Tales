`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2024 11:56:42
// Design Name: 
// Module Name: my_pushbutton_debouncer
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


module my_pushbutton_debouncer(
    input basys_clk,
    input btn,
    input fishing_start_pbC,
    input signed[4:0] bait_count,
    input [1:0] rod_num,
    output reg debounced_sig = 0,
    output reg oled_sig = 0,
    output reg values_sig = 0
    );
    
    wire clk_1kHz;
    flexible_clock fc_1kHz (.basys_clock(basys_clk),.count(49_999),.SLOW_CLOCK(clk_1kHz));

    reg [31:0] my_count = 0;
    reg [31:0] oled_count = 0;
    
    
    
    always @ (posedge clk_1kHz)
    begin
        if (bait_count >= 1 && rod_num >= 1 && fishing_start_pbC == 1)
        begin
                if (btn && my_count == 0 && oled_count ==0)
                    begin
                        my_count <= my_count + 1;
                        debounced_sig <= 1'b0;
                    end
                 else if (my_count != 0 && oled_count == 0)
                    begin
                        if (my_count == 200 && btn == 0)
                            begin
                                my_count <= 0;
                                debounced_sig <= 1'b1;
                                oled_count <= oled_count +1;
                                oled_sig <= 1'b1;
                            end
                        else if (my_count == 200 && btn == 1 && oled_count ==0)
                            begin
                                my_count = 200;
                            end
                        else if (oled_count ==0)
                            begin
                                my_count <= my_count + 1;
                            end
                     end
        end
          if (oled_count != 0)
            begin
                if (oled_count == 150)
                    begin
                        values_sig <= 1'b1;
                        oled_count <= oled_count +1;
                    end
                else if (oled_count == 6750)
                    begin
                        oled_count <= 0;
                        oled_sig <= 1'b0;
                        values_sig <= 1'b0;
                    end
                else 
                    begin
                        oled_count <= oled_count +1;
                    end
           end
        
    end

endmodule
