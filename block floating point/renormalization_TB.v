`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2022 07:33:25 PM
// Design Name: 
// Module Name: renormalization_TB
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


module renormalization_TB
#(
    localparam input_sign_fraction_size = 24, input_exponent_size = 5, output_size = 32
);
    reg [input_sign_fraction_size-1:0] inSignFrac;
    reg [input_exponent_size-1:0] inExp;
    wire [ output_size-1:0 ] Out;
    
    renormalization RE (.SignFrac(inSignFrac), .Exp(inExp), .result(Out));
    
    initial begin 
        inSignFrac <= 24'b000000011111111111111111;
        inExp <= 6'b001000;
    end
endmodule
