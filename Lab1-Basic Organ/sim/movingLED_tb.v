module movingLED_tb();
    reg clk;
    wire [7:0] led;

    movingLED DUT(.clk(clk), .led(led));

    initial forever begin
       clk = 1'b0; #1;
       clk = 1'b1; #1;
    end

endmodule
