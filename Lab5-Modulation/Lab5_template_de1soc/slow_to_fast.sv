module slow_to_fast (fast_clk, slow_clk, data_in, data_out);

input fast_clk, slow_clk;
input data_in;
output reg data_out; // synchronized data_in signal

reg q1, q2;
reg q, en;

always_ff @(posedge slow_clk) begin
    q1 <= data_in;
end

always_ff @( posedge ~fast_clk ) begin
    q <= slow_clk;
    en <= q;
end

always_ff @( posedge fast_clk ) begin
    if (en) begin
       q2 <= q1; 
    end

    data_out <= q2;    
end

endmodule 