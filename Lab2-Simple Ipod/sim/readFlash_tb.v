module readFlash_tb();
	reg clk, startRead, audio_clk, wait_request, read_data_valid;
        wire read, endRead;

	readFlash DUT(.clk(clk), .startRead(startRead), .audio_clk(audio_clk), .wait_request(wait_request), .read_data_valid(read_data_valid), .read(read), .endRead(endRead));

	initial forever begin
		clk = 1'b1; #1;
		clk = 1'b0; #1;
	end

	initial forever begin
		#2; audio_clk = 1'b1; #1;
		audio_clk = 1'b0; #10;
	end

	initial begin
		startRead = 1; wait_request = 0; read_data_valid = 0; #2;
		wait_request = 1; #10;
		wait_request = 0;
		read_data_valid = 1; #5;

		startRead = 0;
		
	end


endmodule
