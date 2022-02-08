module decrypt_message_fsm (
    input logic clk, rst, shuffle_array_fsm_done,
    input logic [7:0] in_data_s, in_data_m,
    output logic wren_s, wren_d, 
    output logic [7:0] mem_address_s, mem_address_m, mem_address_d, out_data_s, out_data_d,
    output logic fail_sig, led0
);
    
parameter [4:0] idle = 5'd0;                        // Wait for shuffle_array_fsm to be done
parameter [4:0] calc_i = 5'd1;                      // Increment i
parameter [4:0] read_from_i = 5'd2;                 // Read s[i]
parameter [4:0] wait_read_i = 5'd3;                 // Wait for reading to be done
parameter [4:0] save_data_i = 5'd4;                 // Save s[i] to data_i
parameter [4:0] calc_j = 5'd5;                      // Calculate j <= j + s[i]
parameter [4:0] read_from_j = 5'd6;                 // Read s[j] 
parameter [4:0] wait_read_j = 5'd7;                 // Wait for reading to be done
parameter [4:0] save_data_j = 5'd8;                 // Save s[j] to data_j
parameter [4:0] write_i_to_j = 5'd9;                // Write s[i] to address j
parameter [4:0] write_j_to_i = 5'd10;               // Write s[j] to address i
parameter [4:0] read_for_f = 5'd11;                 // Read s[s[i]+s[j]]
parameter [4:0] wait_read_f = 5'd12;                // Wait for reading to be done
parameter [4:0] save_data_f = 5'd13;                // Save s[s[i]+s[j]] to data_f
parameter [4:0] read_encrypted = 5'd14;             // Read m[k]
parameter [4:0] wait_read_encrypted = 5'd15;        // Wait for reading to be done
parameter [4:0] write_decrytped = 5'd16;            // Write decrypted message to memory d
parameter [4:0] check_if_fail = 5'd17;              // check if decrypted message is valid character
parameter [4:0] calc_k = 5'd18;                     // Increment k
parameter [4:0] finish = 5'd19;                     // 

// Initialization
reg [4:0] state = idle;
reg [7:0] data_i = 8'd0;
reg [7:0] data_j = 8'd0;
reg [7:0] data_f = 8'd0; 
reg [7:0] i = 8'd0;
reg [7:0] j = 8'd0;
reg [7:0] k = 8'd0;
reg next_fail_sig = 1'b0;
reg next_led0 = 1'b0;

assign fail_sig = next_fail_sig;
assign led0 = next_led0;

always_ff @( posedge clk or posedge rst) begin 
    if (rst) begin
        state <= idle;
        data_i <= 8'd0;
        data_j <= 8'd0;
        data_f <= 8'd0;
        i <= 8'd0;
        j <= 8'd0;
        k <= 8'd0;
        next_fail_sig <= 1'b0;
    end
    else begin
        case (state)
            idle: if (shuffle_array_fsm_done) state <= calc_i;
            calc_i: begin
                i <= i + 1'b1;
                state <= read_from_i;
            end
            read_from_i: begin
                wren_s <= 1'b0;
                mem_address_s <= i;
                state <= wait_read_i;
            end
            wait_read_i: state <= save_data_i;
            save_data_i: begin
                data_i <= in_data_s;
                state <= calc_j;
            end
            calc_j: begin
                j <= j + data_i;
                state <= read_from_j;
            end
            read_from_j: begin
                wren_s <= 1'b0;
                mem_address_s <= j;
                state <= wait_read_j;
            end
            wait_read_j: state <= save_data_j;
            save_data_j: begin
                data_j <= in_data_s;
                state <= write_i_to_j;
            end
            write_i_to_j: begin
                wren_s <= 1'b1;
                out_data_s <= data_i;
                mem_address_s <= j;
                state <= write_j_to_i;
            end
            write_j_to_i: begin
                wren_s <= 1'b1;
                out_data_s <= data_j;
                mem_address_s <= i;
                state <= read_for_f;
            end
            read_for_f: begin
                wren_s <= 1'b0;
                mem_address_s <= (data_i + data_j);
                state <= wait_read_f;
            end
            wait_read_f: state <= save_data_f;
            save_data_f: begin
                data_f <= in_data_s;
                state <= read_encrypted;
            end
            read_encrypted: begin
                mem_address_m <= k;
                state <= wait_read_encrypted;
            end
            wait_read_encrypted: state <= write_decrytped;
            write_decrytped: begin
                wren_d <= 1'b1;
                mem_address_d <= k;
                out_data_d <= (data_f ^ in_data_m);
                state <= check_if_fail;
            end
            check_if_fail: begin
                if (out_data_d >= 8'h61 && out_data_d <= 8'h7A) begin
                    state <= calc_k;
                end
                else if (out_data_d == 8'h20) begin
                    state <= calc_k;
                end
                else begin
                    next_fail_sig <= 1'b1;
                    wren_d <= 1'b0;
                    state <= check_if_fail;
                end
            end
            calc_k: begin
                if (k == 5'd31) begin                // INIFITE LOOP TO STAY AFTER WE FOUND THE KEY
                    state <= calc_k;                 // TURN ON LED0 TO SHOW SUCCESS
                    wren_d <= 1'b0; 
                    next_led0 <= 1'b1;
                end
                else begin
                    state <= finish;
                    wren_d <= 1'b0;
                    k <= k + 1;
                end
            end
            finish: begin
                state <= idle;
            end
            default: state <= state;
        endcase
    end
end

endmodule