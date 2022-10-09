`timescale 1ns / 1ps

module register 
#(parameter size = 2) 
(
    input [size-1:0] D,
    input clk, enable,
    output reg [size-1:0] Q
    );
    
    always @(posedge clk) begin 
    if (enable)
        Q <= D;
    end
endmodule
