module clockDivisor_tb();
     reg clk_in;
     reg [31:0] half_cycle;
     wire clk_out;

     clockDivisor DUT(.clk_in(clk_in), .half_cycle(half_cycle), .clk_out(clk_out));

     // CLOCK GENERATOR
     initial forever begin
        clk_in = 1'b0; #1;
        clk_in = 1'b1; #1;
     end

     initial begin
        half_cycle = 32'h1; #20;
        half_cycle = 32'h2; #20;
        half_cycle = 32'h3; #20;
        half_cycle = 32'h4; #20;
     end
endmodule
