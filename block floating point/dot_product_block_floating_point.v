`timescale 1ns / 1ps

module dot_product_block_floating_point;
    localparam element_size = 16;
    localparam exponent_size = 5;
    localparam mantissa_size = 10;
    localparam output_size = 32;
    reg clk, enable;
    reg [element_size-1:0] v1, v2;
    wire [output_size-1:0] result;
    
    dot_product_top #(.input_size(element_size), .mantissa_size(mantissa_size), .exponent_size(exponent_size), .output_size(output_size)) 
        DP (.v1(v1), .v2(v2), .clk(clk), .enable(enable), .final_result(result));
    
    // Test case 1
    initial begin
        {clk, enable} <= 2'b01;
        v1 <= 16'b0001001010000000; // 0.111 * 2^3
        v2 <= 16'b0001011011000000; // 0.1101 * 2^4
        
        #50
        v1 <= 16'b0001001011000000;
        v2 <= 16'b0001011010000000;
        
        #50
        v1 <= 16'b0001001010000000;
        v2 <= 16'b0001011110000000;
        
        #50
        v1 <= 16'b0001001000000000;
        v2 <= 16'b0001011000000000;
        
        #30
        enable <= 0;
    end

//    // Test case 2
//    initial begin
//        {clk, enable} <= 2'b01;
//        v1 <= 16'b0010101011000000;
//        v2 <= 16'b0010111011011000;
        
//        #50
//        v1 <= 16'b0010111011100000;
//        v2 <= 16'b0011001011100000;
        
//        #50
//        v1 <= 16'b0011001010110100;
//        v2 <= 16'b0010011111111111;
        
//        #50
//        v1 <= 16'b0011011000110100;
//        v2 <= 16'b0010101000110100;
        
//        #30
//        enable <= 0;
//    end
    
    always #25 clk = ~clk;
    
endmodule
