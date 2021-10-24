module addrCal (input logic clk, startCal, direction, restart,
                output logic [22:0] addr);

    parameter idle = 3'b000;
    parameter check_dir = 3'b001;
    parameter forward = 3'b011;
    parameter backward = 3'b101;
    parameter finish = 3'b111;

    parameter init_addr = 23'h0;
    parameter max_addr = 23'h7FFFF;

    // calculate address
    logic [2:0] state = idle;
    logic [22:0] next_addr = init_addr;

    always_ff @ (posedge clk) begin
        case (state)
            idle: if (startCal) state <= check_dir;       // wait until readFlash tells to calculate
            check_dir: if (direction) state <= forward;   // move to different state based on the direction 
                       else state <= backward;
            forward: begin state <= finish;               // increment address in forward direction
			    if (restart || next_addr == max_addr)
                    next_addr <= init_addr;
			    else next_addr <= next_addr + 1'b1;
	        end
            backward: begin state <= finish;              // decrement address in backward direction
			    if (restart || next_addr == init_addr)
                    next_addr <= max_addr;
			    else next_addr <= next_addr - 1'b1;
	        end
            finish: state <= idle;
            default: state <= idle;
        endcase
    end

    assign addr = next_addr;

endmodule