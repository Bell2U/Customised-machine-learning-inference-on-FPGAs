`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2022 03:59:12 PM
// Design Name: 
// Module Name: normalization
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


module normalization
#(parameter input_size=16, exponent_size=5, mantissa_size=10)
(
    input [input_size-1:0] in1, in2, in3, in4,
    output [mantissa_size:0] out1, out2, out3, out4,
    output [exponent_size-1:0] exponent
    );
    reg [mantissa_size-1:0] man1, man2, man3, man4, shifted_man1, shifted_man2, shifted_man3, shifted_man4;
    reg [exponent_size-1:0] exp1, exp2, exp3, exp4;
    
    // spit the mantissa and exponent
    always @(in1, in2, in3, in4) begin
        man1 <= in1[mantissa_size-1:0];
        man2 <= in2[mantissa_size-1:0];
        man3 <= in3[mantissa_size-1:0];
        man4 <= in4[mantissa_size-1:0];

        exp1 <= in1[input_size-2:mantissa_size];
        exp2 <= in2[input_size-2:mantissa_size];
        exp3 <= in3[input_size-2:mantissa_size];
        exp4 <= in4[input_size-2:mantissa_size];
    end
    
    // find the maximum exponent
    integer i;
    reg [exponent_size-1:0] max_exp;
    reg [exponent_size-1:0] array[1:4];
    reg FLAG_max_exp_updated = 1'b0;
    always @(exp1, exp2, exp3, exp4) begin 
        array[1] = exp1;
        array[2] = exp2;
        array[3] = exp3;
        array[4] = exp4;
        max_exp = exp1;
        for (i=1; i<4; i = i+1) begin 
            if (max_exp < array[i+1]) begin 
                max_exp = array[i+1];
            end
        end
        FLAG_max_exp_updated = ~FLAG_max_exp_updated;
    end
    
    assign exponent = max_exp;
   
    // set the maximum exponent as the exponent of the block floating point and shift the mantissa correspondingly
    integer diff[1:4];
    reg FLAG_diff_calculated = 1'b0;
    always @ (FLAG_max_exp_updated) begin 
        diff[1] = max_exp - exp1;
        diff[2] = max_exp - exp2;
        diff[3] = max_exp - exp3;
        diff[4] = max_exp - exp4;
        FLAG_diff_calculated = ~FLAG_diff_calculated;
    end
    
    always @ (FLAG_diff_calculated) begin 
        shifted_man1 <= man1 >> diff[1];
        shifted_man2 <= man2 >> diff[2];
        shifted_man3 <= man3 >> diff[3];
        shifted_man4 <= man4 >> diff[4];
    end
    
    assign out1 = {in1[input_size-1], shifted_man1};
    assign out2 = {in2[input_size-1], shifted_man2};
    assign out3 = {in3[input_size-1], shifted_man3};
    assign out4 = {in4[input_size-1], shifted_man4};
    
endmodule
