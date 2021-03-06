module readKbd ( input logic clk,
                 input logic [7:0] kbd_ascii,
                 output logic start, direction, restart
);

    parameter char_E = 8'h45;
    parameter char_B = 8'h42;
    parameter char_D = 8'h44;
    parameter char_F = 8'h46;
    parameter char_R = 8'h52;
    parameter char_lower_e = 8'h65;
    parameter char_lower_b = 8'h62;
    parameter char_lower_d = 8'h64;
    parameter char_lower_f = 8'h66;
    parameter char_lower_r = 8'h72;

    logic next_start = 1'b0, next_direction = 1'b1, next_restart = 1'b0;
    always_ff @ (posedge clk)
        case (kbd_ascii)
            char_E, char_lower_e: begin next_start <= 1'b1; next_restart = 1'b0; end
            char_D, char_lower_d: begin next_start <= 1'b0; next_restart = 1'b0; end
            char_B, char_lower_b: begin next_direction <= 1'b0; next_restart = 1'b0; end
            char_F, char_lower_f: begin next_direction <= 1'b1; next_restart = 1'b0; end
            char_R, char_lower_r: next_restart <= 1'b1;
            default: begin next_start <= start; next_direction <= direction; next_restart <= 1'b0; end 
        endcase

    assign start = next_start;
    assign direction = next_direction;
    assign restart = next_restart;

endmodule
