module readFlash (input logic clk, audio_clk, wait_request, read_data_valid,
                  output logic read, endRead
);

    parameter idle           = 5'b000_0_0;
    parameter check_wait     = 5'b001_0_0;
    parameter trigger_read   = 5'b001_1_0;
    parameter read_data      = 5'b011_1_0;
    parameter finish         = 5'b111_0_1;

    assign read = state[1];
    assign endRead = state[0];

    logic [4:0] state = idle;

    always_ff @( posedge clk ) begin
        case (state)
            idle: if (audio_clk) state <= check_wait;
            check_wait: if (!wait_request) state <= trigger_read;
            trigger_read: state <= read_data;
            read_data: if (read_data_valid) state <= finish;
            finish: state <= idle;
            default: state <= idle;
        endcase
    end
    
endmodule