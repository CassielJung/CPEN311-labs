// This module divide input clock frequency by divisor which equals half_cycle*2
//
// input 
//   clk_in: input clock to divide the frequency
//   half_cycle: used to decide when to change clk_out value
//               used half_cycle as an input rather than divisor to avoid use of division
// output 
//   clk_out: divided frequency
module clockDivisor (clk_in, half_cycle, clk_out);
    input clk_in;
    input [31:0] half_cycle;
    output reg clk_out;

    // variable to count number of rising edge of clk_in
    reg [31:0] counter = 32'b1;

    wire [31:0] divisor = half_cycle * 2;

    always @(posedge clk_in) begin 
       if (counter >= divisor) counter <= 1'b1;
       else counter <= counter + 1'b1;
       clk_out <= (counter <= half_cycle) ? 1'b0 : 1'b1;
    end
       
endmodule