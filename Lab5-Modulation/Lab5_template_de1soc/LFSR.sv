module LFSR (input logic clk,
			 input logic reset,
			 output logic [4:0] lfsr);

    logic feedback;

    logic [4:0] init_lfsr = 5'b00010;       
    always_ff @(posedge clk, posedge reset)
        if (reset) begin
            init_lfsr <= 5'h1F; 
        end
        else begin
            init_lfsr[4] <= feedback;
            init_lfsr[3] <= init_lfsr[4];
            init_lfsr[2] <= init_lfsr[3];
            init_lfsr[1] <= init_lfsr[2];
            init_lfsr[0] <= init_lfsr[1];
        end 

    assign feedback = init_lfsr[0] ^ init_lfsr[2];
    assign lfsr = init_lfsr;
    
endmodule

