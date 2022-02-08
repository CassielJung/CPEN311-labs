module fast_to_slow #(parameter data_width = 12) (fast_clk, slow_clk, data_in, data_out);

input fast_clk, slow_clk;
input [data_width-1:0] data_in;
output reg [data_width - 1 : 0] data_out;

reg [data_width - 1 : 0] q1, q2;
reg q, en;

always_ff @(posedge fast_clk) begin
    q1 <= data_in;

    if (en) begin
        q2 <= q1;
    end

end

always_ff @( posedge ~fast_clk ) begin
    q <= slow_clk;
    en <= q;
end

always_ff @( posedge slow_clk ) begin
    data_out <= q2;
end

endmodule 