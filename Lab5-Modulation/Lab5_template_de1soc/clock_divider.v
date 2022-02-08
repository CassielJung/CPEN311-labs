module clock_divider( clk, new_clk, clk_div); // clock divider module
input clk;
input [31:0] clk_div;
output reg new_clk = 0;


reg [31:0] count = 1; // initialize count to 1 because it checks 1 cycle after count increses by 1

always@ (posedge clk)
  if (count == clk_div) // when count reaches the clk_div value, reset count
    begin
      count = 1;
      new_clk = ~new_clk; //toggle new_clk on and off when count resets
    end
  else 
    begin
      count = count + 1; // count increments on every positive edge of clk
    end
endmodule 