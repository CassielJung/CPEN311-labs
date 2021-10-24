module addrCal_tb();
	reg clk, startCal, direction, restart;
        wire [22:0] addr;


	addrCal DUT(.clk(clk), .startCal(startCal), .direction(direction), .restart(restart), .addr(addr));
	initial forever begin
		clk = 1'b1; #1;
		clk = 1'b0; #1;
	end

	initial forever begin
		startCal = 1'b1; #100;
		startCal = 0; #6;
			
	end
	
	initial begin
		startCal = 1; direction = 1; restart = 0;
	end

	initial forever begin
		direction = 1; #20;
		direction = 0; #30;
		restart = 1; #10;
		restart = 0;
		direction = 1; #20;
	end
endmodule
