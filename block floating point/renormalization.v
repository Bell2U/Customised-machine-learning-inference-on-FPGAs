`timescale 1ns / 1ps

module renormalization
#(
    parameter input_sign_fraction_size = 24, input_exponent_size = 6,
    localparam input_fraction_size = input_sign_fraction_size - 1, 
    localparam output_size = 32, output_exp_size = 8
)
(
    input [ input_sign_fraction_size-1:0 ] SignFrac,
    input [ input_exponent_size-1:0 ] Exp,
    output [ output_size-1:0 ] result
    );
    
    reg [input_fraction_size-1:0] fraction;
    reg FLAG_shift_done;
    integer shift_count = 0;
    reg shifting_needed = 1'b0;
    reg [ input_exponent_size-1:0 ] exp_step1;
    
    // First step: shift the fraction and change the exponnet accordingly
    // value assign
    always @ (SignFrac) begin 
        fraction <= SignFrac[input_sign_fraction_size-2:0];
        exp_step1 <= Exp + input_fraction_size;
    end
    
    // decide whether shifting is required
    always @(fraction) begin
        FLAG_shift_done = fraction[input_fraction_size-1];
        if (!FLAG_shift_done) shifting_needed = ~shifting_needed;
    end
    
    // shift one bit to the left
    always @(shifting_needed) begin
        if (shift_count < input_fraction_size) begin 
            fraction = fraction << 1;
            exp_step1 = exp_step1 - 1;
            shift_count = shift_count + 1;
        end
    end
    
    // Step 2 Resize: add leading zeros to the exponent.
    // in our case, fraction does not need to change.
    wire [7:0] exp_step2;
    assign exp_step2[input_exponent_size-1:0] = exp_step1;
    assign exp_step2[7:input_exponent_size] = 0;
    assign result = {SignFrac[input_sign_fraction_size-1], exp_step2, fraction};
    
endmodule
