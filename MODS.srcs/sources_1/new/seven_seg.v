`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 08:43:04 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(    
    input display_clock,
    input [6:0] x,
    input [5:0] y,
    input [6:0] char_x, 
    input [5:0] char_y,
    input [12:0] pixel_index,
    input [3:0] numbervalue,
    output reg [15:0] oled_data
);

always @(posedge display_clock) begin
    oled_data <= 16'b0; 

    // Common top segment for all numbers
    if(x >= (char_x + 0) && x <= (char_x + 2) && y >= (char_y + 0) && y <= (char_y + 4))
        oled_data <= 16'b1000001110010101; 

    case (numbervalue) 
        4'd0: begin // Number 0
            if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 96 || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            pixel_index == (char_y * 96 + char_x) + 192 || 
            pixel_index == (char_y * 96 + char_x) + 194 || 
            pixel_index == (char_y * 96 + char_x) + 288 || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))
            oled_data <= 16'b00000_000000_00001; 
        end        
        4'd1: begin // Number 1
        if (pixel_index == (char_y * 96 + char_x) + 2 || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            pixel_index == (char_y * 96 + char_x) + 194 || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            pixel_index == (char_y * 96 + char_x) + 386)
                oled_data <= 16'b00000_000000_00001; 
        end
        4'd2: begin // Number 2
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) || 
            pixel_index == (char_y * 96 + char_x) + 288 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))
                oled_data <= 16'b00000_000000_00001; 
        end
        4'd3: begin // Number 3
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))
                oled_data <= 16'b00000_000000_00001; 
        end
        4'd4: begin // Number 4
        if (pixel_index == (char_y * 96 + char_x) ||
            pixel_index == (char_y * 96 + char_x) + 2 ||
            pixel_index == (char_y * 96 + char_x) + 96 ||
            pixel_index == (char_y * 96 + char_x) + 98 ||
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) ||
            pixel_index == (char_y * 96 + char_x) + 290 ||
            pixel_index == (char_y * 96 + char_x) + 386)
                oled_data <= 16'b00000_000000_00001; 
        end
        4'd5: begin // Number 5
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 96 || 
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))
                oled_data <= 16'b00000_000000_00001; 
        end
        4'd6: begin // Number 6
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 96 || 
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) || 
            pixel_index == (char_y * 96 + char_x) + 288 || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))

                oled_data <= 16'b00000_000000_00001; 
        end
        4'd7: begin // Number 7
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            pixel_index == (char_y * 96 + char_x) + 194 || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            pixel_index == (char_y * 96 + char_x) + 386)
                oled_data <= 16'b00000_000000_00001; 
        end
        4'd8: begin // Number 8
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 96 || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) || 
            pixel_index == (char_y * 96 + char_x) + 288 || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))

                oled_data <= 16'b00000_000000_00001; 
        end
        4'd9: begin // Number 9
        if (((pixel_index >= (char_y * 96 + char_x)) && (pixel_index <= (char_y * 96 + char_x) + 2)) || 
            pixel_index == (char_y * 96 + char_x) + 96 || 
            pixel_index == (char_y * 96 + char_x) + 98 || 
            ((pixel_index >= (char_y * 96 + char_x) + 192) && (pixel_index <= (char_y * 96 + char_x) + 194)) || 
            pixel_index == (char_y * 96 + char_x) + 290 || 
            ((pixel_index >= (char_y * 96 + char_x) + 384) && (pixel_index <= (char_y * 96 + char_x) + 386)))

                oled_data <= 16'b00000_000000_00001;                             
        end
        default: begin
            oled_data <= 16'b0;  // Default case to avoid unintended latches
        end
    endcase
end

endmodule
