module shuffle_array_fsm_tb();

reg clk, stop_write, rst;
reg [7:0] in_data;
reg [23:0] secret_key;
wire [7:0] mem_address, out_data;
wire wren, shuffle_array_fsm_done;

shuffle_array_fsm DUT(.clk(clk),
                        .rst(rst),
                        .stop_write(stop_write),
                        .secret_key(secret_key),
                        .mem_address(mem_address),
                        .out_data(out_data),
                        .in_data(in_data),
                        .wren(wren),
                        .shuffle_array_fsm_done(shuffle_array_fsm_done));


initial forever begin
    clk = 1'b0;
    #1;
    clk = 1'b1;
    #1;
end

initial begin
    stop_write = 1'b0;
    secret_key = 24'h249;
    in_data = 8'd30; 
    rst = 1'b0;
    #4;

    stop_write = 1'b1; 
    #150;
    stop_write = 1'b0;
    #5;
    stop_write = 1'b1;
    #30;

    rst = 1'b1;
end
endmodule