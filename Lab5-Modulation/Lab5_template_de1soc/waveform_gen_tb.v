module waveform_gen_tb();

reg clk;
reg [31:0] phase_inc;
wire [11:0] sin_out, cos_out, saw_out, squ_out;

waveform_gen DUT(.clk(clk),
				 .reset(1'b1),
				 .en(1'b1),
				 .phase_inc(phase_inc),
				 .sin_out(sin_out),
				 .cos_out(cos_out),
				 .squ_out(squ_out),
				 .saw_out(saw_out));
                  
initial forever begin
  clk = 1'b0;
  #1;
  clk = 1'b1;
  #1;
end

initial forever begin
    phase_inc = 32'd258; #200;
    phase_inc = 32'h56; #200;
    phase_inc = 32'h1AD; #200;
end

endmodule