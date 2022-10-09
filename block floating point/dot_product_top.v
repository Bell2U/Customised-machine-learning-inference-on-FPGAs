`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 07:49:17 AM
// Design Name: 
// Module Name: dot_product_top
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


module dot_product_top
#(parameter input_size = 16, mantissa_size = 10, exponent_size = 5, output_size = 32)
(
    input [input_size-1:0] v1, v2,
    input clk, enable,
    output [output_size-1:0] final_result
    );
    wire [input_size-1:0] f11, f12, f13, f14, f21, f22, f23, f24;
    wire [mantissa_size:0] b11, b12, b13, b14, b21, b22, b23, b24;
    wire [exponent_size-1:0] exp1, exp2;
    wire [2*mantissa_size+3:0] addittion_result;
    wire [exponent_size:0] result_exp;
    
    SIPO_4 #(.bit_size(input_size)) S1 (.V(v1), .clk(clk), .enable(enable), .out0(f11), .out1(f12), .out2(f13), .out3(f14) );
    SIPO_4 #(.bit_size(input_size)) S2 (.V(v2), .clk(clk), .enable(enable), .out0(f21), .out1(f22), .out2(f23), .out3(f24) );
    
    normalization #(.input_size(input_size), .mantissa_size(mantissa_size), .exponent_size(exponent_size))
        Nor1 (.in1(f11), .in2(f12), .in3(f13), .in4(f14),
            .out1(b11), .out2(b12), .out3(b13), .out4(b14),
            .exponent(exp1)
            );
    normalization #(.input_size(input_size), .mantissa_size(mantissa_size), .exponent_size(exponent_size))
        Nor2 (.in1(f21), .in2(f22), .in3(f23), .in4(f24),
            .out1(b21), .out2(b22), .out3(b23), .out4(b24),
            .exponent(exp2)
            );
            
    adder_tree #(.SignFrac_size(mantissa_size+1), .exp_size(exponent_size))
        ADT( .in1(b11), .in2(b12), .in3(b13), .in4(b14), .in5(b21), .in6(b22), .in7(b23), .in8(b24), 
        .exp1(exp1),.exp2(exp2), 
        .result(addittion_result), 
        .result_exp(result_exp));
    renormalization RE (.SignFrac(addittion_result), .Exp(result_exp), .result(final_result));
    
endmodule
