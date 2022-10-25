module register_shift_SIPO_4_bit(clk, clear, serial_in, parallel_out);

    input clk, clear;
    input serial_in;
    output reg[3:0] parallel_out;


    always @(posedge clk) begin
        if(clear)
            parallel_out <= 4'b0000;
        else begin
            parallel_out <= parallel_out << 1; // left shifting the value of parallel_out. So, this is a left shift register, where shifting occurs from LSB towards MSB.
            parallel_out[0] <= serial_in; // For filling the empty bit generated as a result of shifting.
        end

        //? Delay of #1 in order to show the correct output of the non-blocking assignment above.
        #1 $display("clear : %b\nserial_in : %b\nparallel_out : %b\n", clear, serial_in, parallel_out);
    end
endmodule

// Test bench
module register_shift_SIPO_4_bit_test;
    
    reg clk, clear;
    reg serial_in;
    wire[3:0] parallel_out;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk; // Initially, after 5ns, positive edge of clock is reached. The positive edge is reached every 10ns, so it is reached at 5, 15, 25ns....
        end
    end

    register_shift_SIPO_4_bit wire_driver(.clk(clk), .clear(clear), .serial_in(serial_in), .parallel_out(parallel_out));

    initial begin
        // For every rising edge, the value is different, since 10ns is the length of the clock pulse
        // `clear` is high only for the first clock pulse and low for every subsequent clock pulse
            clear = 1'b1; serial_in = 1'b1;  // Values at rising edge at 5ns
        #10 clear = 1'b0; serial_in = 1'b0;  // Values at rising edge at 15ns
        #10 clear = 1'b0; serial_in = 1'b1;  // Values at rising edge at 25ns
        #10 clear = 1'b0; serial_in = 1'b0;  // Values at rising edge at 35ns
        #10 clear = 1'b0; serial_in = 1'b0;  // Values at rising edge at 45ns
        #10 clear = 1'b0; serial_in = 1'b1;  // Values at rising edge at 55ns
        #10 $finish;
    end
    

endmodule