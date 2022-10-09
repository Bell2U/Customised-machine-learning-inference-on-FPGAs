`timescale 1ns / 1ps


module Adder_tree_TB;
    localparam exp_size = 5;
    localparam fraction_size = 10;
    
    reg [exp_size-1:0] exp1, exp2;
    reg [fraction_size:0] frac1, frac2, frac3, frac4, frac5, frac6, frac7, frac8;
    
    wire [exp_size:0] result_exp;
    wire [2*fraction_size+3:0] fraction_result;
    
    adder_tree #(.SignFrac_size(fraction_size+1), .exp_size(exp_size))
        AD(
        .in1(frac1), 
        .in2(frac2), 
        .in3(frac3), 
        .in4(frac4), 
        .in5(frac5), 
        .in6(frac6), 
        .in7(frac7), 
        .in8(frac8), 
        .exp1(exp1), 
        .exp2(exp2), 
        .result(fraction_result), 
        .result_exp(result_exp));
    
    initial begin 
        exp1 <= 5'b00101;
        exp2 <= 5'b10010;
        frac1 <= 11'b00001011000;
        frac2 <= 11'b00010111000;
        frac3 <= 11'b00101011010;
        frac4 <= 11'b01000110100;
        frac5 <= 11'b00000000101;
        frac6 <= 11'b00000001011;
        frac7 <= 11'b00000000001;
        frac8 <= 11'b01000110100;
    end
    
endmodule
