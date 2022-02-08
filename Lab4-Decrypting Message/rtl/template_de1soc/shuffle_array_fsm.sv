module shuffle_array_fsm (clk, rst, stop_write, in_data, secret_key, mem_address, out_data, wren, shuffle_array_fsm_done);
    input logic clk, rst, stop_write;
    input logic [7:0] in_data;
    input logic [23:0] secret_key;
    output logic [7:0] mem_address, out_data;
    output logic wren, shuffle_array_fsm_done;

    parameter [5:0] idle = 6'b000000;
    parameter [5:0] read_from_i = 6'b000001;
    parameter [5:0] wait_read_i = 6'b000010;
    parameter [5:0] save_data_i = 6'b000011;
    parameter [5:0] calc_secret_key = 6'b000100;
    parameter [5:0] calc_j = 6'b000101;
    parameter [5:0] read_from_j = 6'b000110;
    parameter [5:0] wait_read_j = 6'b000111;
    parameter [5:0] save_data_j = 6'b001000;
    parameter [5:0] write_i_to_j = 6'b001001;
    parameter [5:0] write_j_to_i = 6'b001010;
    parameter [5:0] calc_i = 6'b001011;
    parameter [5:0] finish = 6'b001100;

    // Initiallize signals
    reg [5:0] state = idle;
    reg [7:0] data_i = 8'd0;
    reg [7:0] data_j = 8'd0;
    reg [7:0] i = 8'd0;  
    reg [7:0] j = 8'd0;
    reg end_signal = 1'b0;
    
    parameter keylength = 8'd3;
    reg [7:0] add_secret;

    assign shuffle_array_fsm_done = end_signal;

    always_ff @( posedge clk or posedge rst) begin 
        if (rst) begin
            state <= idle;
            data_i <= 8'd0;
            data_j <= 8'd0;
            i <= 8'd0;
            j <= 8'd0;
            end_signal <= 1'b0;
        end
        else begin
            case(state) 
                // Wait until initialization of memory is done
                idle: if (stop_write) state <= read_from_i;
                // read s[i]
                read_from_i: begin
                    state <= wait_read_i;
                    mem_address <= i;
                    wren <= 1'b0;
                end
                // wait one cycle for reading
                wait_read_i: begin
                    state <= save_data_i;
                end
                // save s[i]
                save_data_i: begin
                    state <= calc_secret_key;
                    data_i <= in_data;
                end
                // calculate secret_key based on i % 3
                calc_secret_key: begin
                    case (i % keylength)
                        2'd0: add_secret <= secret_key[23:16];
                        2'd1: add_secret <= secret_key[15:8];
                        2'd2: add_secret <= secret_key[7:0];
                    endcase
                    state <= calc_j;
                end
                // calculate j using s[i] and secret_key
                calc_j: begin
                    j <= (j + data_i + add_secret);
                    state <= read_from_j; 
                end
                // read s[j]
                read_from_j: begin
                    state <= wait_read_j;
                    mem_address <= j;
                    wren <= 1'b0;
                end
                // wait one cycle for reading
                wait_read_j: begin
                    state <= save_data_j;
                end
                // save s[j]
                save_data_j: begin
                    state <= write_i_to_j;
                    data_j <= in_data;
                end
                // swap s[i] and s[j]
                write_i_to_j: begin
                    state <= write_j_to_i;
                    out_data <= data_i;
                    mem_address <= j;
                    wren <= 1'b1;
                end
                // swap s[i] and s[j]
                write_j_to_i: begin
                    state <= calc_i;
                    out_data <= data_j;
                    mem_address <= i;
                    wren <= 1'b1;
                end
                // increment i
                calc_i: begin 
                    if (i == 8'd255) begin
                        state <= calc_i; // stay in this state
                        end_signal <= 1'b1;
                        wren <= 1'b0;
                    end 
                    else begin
                        state <= finish;
                        i <= i + 1'b1;
                        wren <= 1'b0;
                    end
                end
                finish: state <= idle;
                default: state <= state;
            endcase  
        end
    end
    
endmodule
