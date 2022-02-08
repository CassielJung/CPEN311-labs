module mem_write(clk, in_address, stop_write, rst, wren, calc_next_address, output_address);

input [7:0] in_address;
input clk, rst, stop_write;
output calc_next_address, wren;
output [7:0] output_address;

parameter [5:0] idle = 6'b0000_001;
parameter [5:0] write_data = 6'b0001_01;
parameter [5:0] calc_address = 6'b0010_10;
parameter [5:0] finished = 6'b0011_00;

reg [5:0] state = idle;

always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= idle;
    end
    else begin
        case(state) 
        idle: begin
            if (!stop_write) state <= write_data;
        end
        write_data: begin
            state <= calc_address;
        end
        calc_address: begin
            state <= finished;
        end
        finished: begin
            state <= idle;
        end
        default: state <= idle;
        endcase
    end
    
end

assign output_address = state[0] ? in_address : 8'd0;
assign wren = state[0];
assign calc_next_address = state[1];

endmodule 