module speedControl (
    input logic clk,
    input logic speedUp, speedDown, speedReset,
    output logic [31:0] half_cycle
);
    reg [31:0] next_half_cycle = 32'd1227;

    always_ff @(posedge clk) begin
        casez ({speedUp, speedDown, speedReset})
            3'b??1: next_half_cycle <= 32'd1227;
            3'b?1?: next_half_cycle <= next_half_cycle + 32'h5;
            3'b1??: next_half_cycle <= next_half_cycle - 32'h5;
            default: next_half_cycle <= next_half_cycle;
        endcase
    end

    assign half_cycle = next_half_cycle;

endmodule
