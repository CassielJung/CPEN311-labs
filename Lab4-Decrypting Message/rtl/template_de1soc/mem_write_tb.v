module mem_write_tb ();
    reg clk, stop_write, rst;
    reg [7:0] in_address;
    wire wren, calc_next_address;
    wire [7:0] output_address;

    mem_write DUT (.clk(clk),
                   .in_address(in_address),
                   .stop_write(stop_write),
                   .rst(rst),
                   .wren(wren),
                   .calc_next_address(calc_next_address),
                   .output_address(output_address));

    initial forever begin
        clk = 1'b0; #1;
        clk = 1'b0; #1;
    end

    initial begin
        rst = 1'b0; stop_write = 1'b0;
        in_address = 1'd0; #8;
        in_address = 1'd1; #8;
        in_address = 1'd2; #8;
        in_address = 1'd3; #8;
        in_address = 1'd4; #8;

        stop_write = 1'b1; #4;

        rst = 1'b1; #2;
        stop_write = 1'b0;
    end
endmodule