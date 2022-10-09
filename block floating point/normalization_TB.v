`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2022 04:24:03 PM
// Design Name: 
// Module Name: normalization_TB
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


module normalization_TB;
    localparam element_size = 16;
    localparam exponent_size = 5;
    localparam mantissa_size = 10;
    
    reg [element_size-1:0] in1, in2, in3, in4;
    wire [ mantissa_size:0 ] sf1, sf2, sf3, sf4;
    wire [ exponent_size - 1:0 ] exp;
    
    normalization #(.input_size(element_size), .exponent_size(exponent_size), .mantissa_size(mantissa_size)) 
        Nor (
        .in1(in1), .in2(in2), .in3(in3), .in4(in4),
        .out1(sf1), .out2(sf2), .out3(sf3), .out4(sf4),
        .exponent(exp)
        );
    
    initial begin 
        in1 <= 16'b0000101011000000;
        in2 <= 16'b0000111011100000;
        in3 <= 16'b0001001010110100;
        in4 <= 16'b0001011000110100;
        #50
        in1 <= 16'b0010111011011000;
        in2 <= 16'b0011001011100000;
        in3 <= 16'b0010011111111111;
        in4 <= 16'b0100101000110100;
    end

endmodule
