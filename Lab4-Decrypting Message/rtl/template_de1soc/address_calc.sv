module address_calc(calc_next_address, rst, out_address, stop_write);

input logic calc_next_address, rst;
output [7:0] out_address;
output stop_write;

reg [7:0] count = 8'd0;
reg stop_write = 1'd0;

always_ff @(posedge calc_next_address or posedge rst) begin
    if (rst) begin
        count <= 8'd0;
        stop_write <= 1'b0;
    end
    else if (count == 8'd255) begin
        stop_write <= 1'b1;
    end
    else begin
        if(calc_next_address) begin
            count <= count + 1;
        end
    end 
end

assign out_address = count; 

endmodule 