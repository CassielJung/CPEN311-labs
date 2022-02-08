module ksa (
    input logic CLOCK_50,
    input logic [3:0] KEY,
    input logic [9:0] SW,
    output logic [9:0] LEDR,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    // Task 1
    wire stop_write, calc_next_address, initialize_wren;
    wire [7:0] read_address, initialize_address;
    wire [7:0] read_data;
    reg [7:0] data_to_write;
    reg [7:0] addr_to_read_write;
    reg enable_write;

    // Task 2a
    wire shuffle_wren, shuffle_array_fsm_done;
    wire [7:0] shuffle_out_data, shuffle_address;

    // Task 2b
    wire [7:0] encrypted_read_data, decrypt_address_d, decrypt_address_s, decrypt_address_m, decrypt_out_data_d, decrypt_out_data_s;
    wire decrypt_wren_d, decrypt_wren_s, decrypt_message_fsm_done;

    // Task 3
    wire rst_s, rst_i, rst_d, fail_sig;
    wire [23:0] secret_key;

    // Instantiate to s_memory
    s_memory memory_s(.address(addr_to_read_write),
                      .clock(CLOCK_50),
                      .data(data_to_write),
                      .wren(enable_write),
                      .q(read_data));

    // Assign arguments for s_memory
    always_comb begin
        case ({stop_write, shuffle_array_fsm_done})
            2'b00: begin
                {data_to_write, addr_to_read_write, enable_write} = {initialize_address, initialize_address, initialize_wren};
            end
            2'b10: begin
                {data_to_write, addr_to_read_write, enable_write} = {shuffle_out_data, shuffle_address, shuffle_wren};
            end 
            2'b11: begin
                {data_to_write, addr_to_read_write, enable_write} = {decrypt_out_data_s, decrypt_address_s, decrypt_wren_s};
            end
            default: begin
                data_to_write = 8'd0;
                addr_to_read_write = 8'd0;
                enable_write = 1'b1;
            end
        endcase
    end

    // Task 1
    mem_write initialize_mem(.clk(CLOCK_50),
                             .rst(rst_i),
                             .stop_write(stop_write),
                             .calc_next_address(calc_next_address),
                             .wren(initialize_wren),
                             .output_address(initialize_address),
                             .in_address(read_address));

    address_calc calc_address(.calc_next_address(calc_next_address),
                              .rst(rst_i),
                              .out_address(read_address),
                              .stop_write(stop_write));

    // Task 2a
    shuffle_array_fsm shuffle_array(.clk(CLOCK_50),
                                    .rst(rst_s),
                                    .stop_write(stop_write),
                                    .in_data(read_data), 
                                    .secret_key(secret_key),
                                    .mem_address(shuffle_address), 
                                    .out_data(shuffle_out_data), 
                                    .wren(shuffle_wren),
                                    .shuffle_array_fsm_done(shuffle_array_fsm_done));

    // Task 2b
    decrypt_message_fsm decrypt_message(.clk(CLOCK_50),
                                        .rst(rst_d),
                                        .shuffle_array_fsm_done(shuffle_array_fsm_done),
                                        .in_data_s(read_data),
                                        .in_data_m(encrypted_read_data),
                                        .led0(LEDR[0]),
                                        .wren_s(decrypt_wren_s),
                                        .wren_d(decrypt_wren_d),
                                        .fail_sig(fail_sig),
                                        .mem_address_s(decrypt_address_s),
                                        .mem_address_m(decrypt_address_m),
                                        .mem_address_d(decrypt_address_d),
                                        .out_data_s(decrypt_out_data_s),
                                        .out_data_d(decrypt_out_data_d));

    // Instantiate ROM with encrypted messgae and RAM for decrypted message
    encrypt_ROM encrypted_memory (.address(decrypt_address_m),
                                  .clock(CLOCK_50),
                                  .q(encrypted_read_data));

    decrypt_memory decrypt_mem (.address(decrypt_address_d),
                                .clock(CLOCK_50),
                                .data(decrypt_out_data_d),
                                .wren(decrypt_wren_d),
                                .q());

    // Task 3
    key_count_fsm key_count (.clk(CLOCK_50),
                             .fail_sig(fail_sig),
                             .led9(LEDR[9]),
                             .key(secret_key),
                             .rst_i(rst_i),
                             .rst_s(rst_s),
                             .rst_d(rst_d));

    SevenSegmentDisplayDecoder display_HEX5(.ssOut(HEX5), .nIn(secret_key[23:20]));
    SevenSegmentDisplayDecoder display_HEX4(.ssOut(HEX4), .nIn(secret_key[19:16]));
    SevenSegmentDisplayDecoder display_HEX3(.ssOut(HEX3), .nIn(secret_key[15:12]));
    SevenSegmentDisplayDecoder display_HEX2(.ssOut(HEX2), .nIn(secret_key[11:8]));
    SevenSegmentDisplayDecoder display_HEX1(.ssOut(HEX1), .nIn(secret_key[7:4]));
    SevenSegmentDisplayDecoder display_HEX0(.ssOut(HEX0), .nIn(secret_key[3:0]));

endmodule