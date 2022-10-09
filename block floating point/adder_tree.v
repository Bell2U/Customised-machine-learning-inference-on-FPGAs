`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2022 08:16:45 PM
// Design Name: 
// Module Name: adder_tree
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


module adder_tree
#(parameter SignFrac_size = 11, exp_size = 5,
localparam fraction_size = SignFrac_size - 1
)
(
    input [SignFrac_size-1:0] in1, in2, in3, in4, in5, in6, in7, in8,
    input [exp_size-1:0] exp1, exp2, 
    output [ 2*fraction_size+3:0 ] result,
    output [ exp_size:0 ] result_exp
    );
    
    wire [fraction_size-1:0] frac1, frac2, frac3, frac4, frac5, frac6, frac7, frac8;
    wire [2*fraction_size+2:0] frac_result;
    
    assign frac1 = in1[fraction_size-1:0];
    assign frac2 = in2[fraction_size-1:0];
    assign frac3 = in3[fraction_size-1:0];
    assign frac4 = in4[fraction_size-1:0];
    assign frac5 = in5[fraction_size-1:0];
    assign frac6 = in6[fraction_size-1:0];
    assign frac7 = in7[fraction_size-1:0];
    assign frac8 = in8[fraction_size-1:0];
    
    assign frac_result = frac1*frac5 + frac2*frac6 + frac3*frac7 + frac4*frac8;
    assign result = {1'b0, frac_result};    // no negative numbers for now
    assign result_exp = exp1 + exp2 - fraction_size - fraction_size;
endmodule
