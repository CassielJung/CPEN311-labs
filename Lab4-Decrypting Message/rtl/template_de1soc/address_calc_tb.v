module address_calc_tb();

reg calc_next_address, rst;
wire [7:0] out_address;
wire stop_write;

address_calc DUT(.calc_next_address(calc_next_address),
                 .rst(rst),
                 .out_address(out_address),
                 .stop_write(stop_write));


initial forever begin
  calc_next_address = 1'b0;
  #1;
  calc_next_address = 1'b1;
  #1;

end

initial begin
  rst = 1'b0;
  #520;
  rst = 1'b1;
end




endmodule 