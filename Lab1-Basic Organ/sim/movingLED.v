// This module turn led on and off based on the clk signal
// Every 1 posedge of clk, led move from left to right and come back
// Input
//   clk: clock frequency which determine when to turn on and off LED
// Output
//   led: 8 bit signal that connects to LED
module movingLED(clk, led);
     input clk;
     output reg [7:0] led;

     reg [3:0] counter = 1'b0;

     always @(posedge clk) begin
        counter <= counter + 1'b1;
        if(counter >= 4'b1101) counter <= 1'b0;
        
        case (counter)
           4'b0000: led = 8'b0000_0001;
           4'b0001: led = 8'b0000_0010;
           4'b0010: led = 8'b0000_0100;
           4'b0011: led = 8'b0000_1000;
           4'b0100: led = 8'b0001_0000;
           4'b0101: led = 8'b0010_0000;
           4'b0110: led = 8'b0100_0000;
           4'b0111: led = 8'b1000_0000;
           4'b1000: led = 8'b0100_0000;
           4'b1001: led = 8'b0010_0000;
           4'b1010: led = 8'b0001_0000;
           4'b1011: led = 8'b0000_1000;
           4'b1100: led = 8'b0000_0100;
           4'b1101: led = 8'b0000_0010;
           default: led = 8'b0000_0000;
        endcase
     end
        
endmodule
