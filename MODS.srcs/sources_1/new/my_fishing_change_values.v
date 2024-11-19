`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2024 19:56:32
// Design Name: 
// Module Name: my_fishing_change_values
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


module my_fishing_change_values(
    input values_sig,
    input [1:0] fish_num,
    output reg signed[4:0] output_bait_count,    
    output reg signed [4:0] output_carp_count,
    output reg signed [4:0] output_bluetang_count,
    output reg signed [4:0] output_koi_count,
    
    input signed [4:0] input_bait_count,
    input signed [4:0] input_carp_count,
    input signed [4:0] input_bluetang_count,
    input signed [4:0] input_koi_count
    
    );
    
    always @ (posedge values_sig)
    begin
        output_bait_count <= input_bait_count - 1;
        if (fish_num == 1)
              output_carp_count <= input_carp_count + 1;
        else if(fish_num == 2)
              output_bluetang_count <= input_bluetang_count + 1;
        else if(fish_num == 3)
              output_koi_count <= input_koi_count +1;
    end
    
endmodule
