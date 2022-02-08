module key_count_fsm(clk, led9, fail_sig, key, rst_i, rst_d, rst_s);

input fail_sig, clk ;

output [23:0] key;
output rst_i,rst_s,rst_d, led9;

parameter [2:0] idle = 3'd0;
parameter [2:0] display_hex = 3'd1;
parameter [2:0] wait_fail = 3'd2;
parameter [2:0] count_key = 3'd3;
parameter [2:0] reset_initial_fsm = 3'd4;
parameter [2:0] reset_shuffle_fsm = 3'd5;
parameter [2:0] reset_decrypt_fsm = 3'd6;

reg rst_i = 1'b0;
reg [2:0] state = idle;
reg [23:0] key_count = 24'd0;
reg led9 = 1'b0;
reg rst_s = 1'b0;
reg rst_d = 1'b0;

always_ff @(posedge clk)begin
    case(state)
        idle: begin
            state <= display_hex;
            rst_i <= 1'b0;
            rst_s <= 1'b0;
            rst_d <= 1'b0;
        end
        display_hex: begin
            state <= wait_fail;
        end
        wait_fail: begin
            if (!fail_sig) begin
                state <= wait_fail;
            end
            else begin
                state <= count_key;
            end
        end
        count_key: begin
            if(key_count == 24'h3FFFFF) begin //0x3FFFFF = maximum possible key value
                state <= count_key;
                led9 <= 1'b1;
            end
            else begin
                state <= reset_initial_fsm;
                key_count <= key_count + 1'b1;
            end
        end
        reset_initial_fsm: begin
            state <= reset_shuffle_fsm;
            rst_i <= 1'b1;
        end
        reset_shuffle_fsm: begin
            state <= reset_decrypt_fsm;
            rst_s <= 1'b1;
        end
        reset_decrypt_fsm: begin
            state <= idle;
            rst_d = 1'b1;
        end
    endcase
end

assign key = key_count;

endmodule 