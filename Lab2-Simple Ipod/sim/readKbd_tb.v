module readKbd_tb();
	reg clk; 
	reg [7:0] kbd_ascii;
        wire start, direction, restart;

	readKbd DUT(.clk(clk), .kbd_ascii(kbd_ascii), .start(start), .direction(direction), .restart(restart));

	initial forever begin
		clk = 1'b1; #5;
		clk = 1'b0; #5;
	end


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

	initial begin
		#20; kbd_ascii = char_E;
		#10; kbd_ascii = char_B;
		#10; kbd_ascii = char_F;
		#10; kbd_ascii = char_R;
		#10; kbd_ascii = char_lower_d;
		#10; kbd_ascii = char_lower_e;
		#10; kbd_ascii = char_lower_f;
		#10; kbd_ascii = char_D;
		#10; kbd_ascii = char_B;
		#10; kbd_ascii = char_E;
	end
endmodule
