module register_storage_PIPO_4_bit(clk, clear, parallel_in, parallel_out);

    input clk, clear;
    input[3:0] parallel_in;
    output reg[3:0] parallel_out;


    always @(posedge clk) begin
        if(clear)
            parallel_out <= 4'b0000;
        else
            parallel_out <= parallel_in;
    
        //? Delay of #1 in order to show the correct output of the non-blocking assignment above.
        #1 $display("clear : %b\nparallel_in : %b\nparallel_out : %b\n", clear, parallel_in, parallel_out);
    end
endmodule

// Test bench
module register_storage_PIPO_4_bit_test;
    
    reg clk, clear;
    reg[3:0] parallel_in;
    wire[3:0] parallel_out;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk; // Initially, after 5ns, positive edge of clock is reached. The positive edge is reached every 10ns, so it is reached at 5, 15, 25ns....
        end
    end

    register_storage_PIPO_4_bit wire_driver(.clk(clk), .clear(clear), .parallel_in(parallel_in), .parallel_out(parallel_out));

    initial begin
        // For every rising edge, the value is different, since 10ns is the length of the clock pulse
        
            clear = 1'b1; parallel_in = 4'b1101;  // Values at rising edge at 5ns
        #10 clear = 1'b0; parallel_in = 4'b1011;  // Values at rising edge at 15ns
        #10 clear = 1'b0; parallel_in = 4'b1010;  // Values at rising edge at 25ns
        #10 clear = 1'b0; parallel_in = 4'b0110;  // Values at rising edge at 35ns
        #10 clear = 1'b1; parallel_in = 4'b0101;  // Values at rising edge at 45ns
        #10 clear = 1'b0; parallel_in = 4'b1111;  // Values at rising edge at 55ns
        #10 $finish;
    end
    

endmodule