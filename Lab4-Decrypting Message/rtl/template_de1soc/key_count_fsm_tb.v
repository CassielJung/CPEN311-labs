module key_count_fsm_tb();

reg fail_sig, clk ;

wire [23:0] key;
wire rst, led9;

key_count_fsm DUT(.clk(clk),
                  .fail_sig(fail_sig),
                  .rst(rst),
                  .key(key),
                  .led9);

initial forever begin 
    clk = 1'b0;
    #1;
    clk = 1'b1;
    #1;
end

initial forever begin
  fail_sig = 1'b0;
  #10;
  fail_sig = 1'b1;
  #10;
end

endmodule 