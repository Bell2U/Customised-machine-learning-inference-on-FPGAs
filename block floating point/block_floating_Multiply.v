`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2022 10:16:45 PM
// Design Name: 
// Module Name: block_floating_Multiply
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


module block_floating_Multiply
#(parameter FractionSize = 11, ExpSize = 5)
(
    input [FractionSize-1:0] factor1, factor2,
    input [ExpSize-1:0] exp,
    output [FractionSize-1:0] product,
    output [ExpSize-1:0] exp2
    );
    assign product = factor1 * factor2;
    assign exp2 = exp * exp;
endmodule
