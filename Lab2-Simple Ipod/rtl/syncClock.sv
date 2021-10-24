// Flip-flop with asynchronous reset
module FDC (input logic clk, clr, d,
            output logic q);
     always_ff @(posedge clk or posedge clr)
        if(clr) q <= 1'b0;
        else q <= d;
endmodule

// synchronize async_sig to outclk
// used to avoid metastability
module synchClock (input logic VCC, gnd, async_sig, outclk,
                   output logic out_sync_sig);

     wire q1, q2, q3, q4;

     // Instantiate FDCs
     FDC FDC_1 (.clk(~outclk), .clr(gnd), .d(q4), .q(q1));
     FDC FDC_2 (.clk(async_sig), .clr(q1), .d(VCC), .q(q2));
     FDC FDC_3 (.clk(outclk), .clr(gnd), .d(q2), .q(q3));
     FDC FDC_4 (.clk(outclk), .clr(gnd), .d(q3), .q(q4));

     assign out_sync_sig = q4;

endmodule