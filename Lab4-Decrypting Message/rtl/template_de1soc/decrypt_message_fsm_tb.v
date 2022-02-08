module decrypt_message_fsm_tb();

reg clk, shuffle_array_fsm_done,rst;
reg [7:0] in_data_s, in_data_m;
wire wren_s, wren_d, fail_sig, led0;
wire [7:0] mem_address_s, mem_address_m, mem_address_d, out_data_s, out_data_d;

decrypt_message_fsm DUT (.clk(clk),
                         .rst(rst),
                         .shuffle_array_fsm_done(shuffle_array_fsm_done),
                         .in_data_s(in_data_s),
                         .in_data_m(in_data_m),
                         .wren_s(wren_s),
                         .wren_d(wren_d),
                         .mem_address_s(mem_address_s),
                         .mem_address_m(mem_address_m),
                         .mem_address_d(mem_address_d),
                         .out_data_s(out_data_s),
                         .out_data_d(out_data_d),
                         .fail_sig(fail_sig),
                         .led0(led0));



initial forever begin
    clk = 1'b0;
    #1;
    clk = 1'b1;
    #1;
end

initial begin
    shuffle_array_fsm_done = 1'b0; #4;

    rst = 1'b0;
    shuffle_array_fsm_done = 1'b1;
    in_data_s = 8'd97;
    in_data_m = 8'd0;

    #50;
    rst = 1'b1;
    #4;
    rst = 1'b0;
    #2000;
    in_data_s = 8'd1;
    in_data_m = 8'd1;

end

endmodule 