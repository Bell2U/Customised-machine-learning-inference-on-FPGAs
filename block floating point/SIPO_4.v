`timescale 1ns / 1ps


module SIPO_4
#(parameter bit_size = 16)
(
    input [bit_size-1:0] V,
    input clk, enable,
    output [bit_size-1:0] out3, out2, out1, out0
    );
    
    register #(.size(bit_size)) re3 (.D(V), .clk(clk), .enable(enable), .Q(out3));
    register #(.size(bit_size)) re2 (.D(out3), .clk(clk), .enable(enable), .Q(out2));
    register #(.size(bit_size)) re1 (.D(out2), .clk(clk), .enable(enable), .Q(out1));
    register #(.size(bit_size)) re0 (.D(out1), .clk(clk), .enable(enable), .Q(out0));
    
endmodule
