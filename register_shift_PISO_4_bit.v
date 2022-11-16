/* 
In PISO shift register, we have 2 modes, load mode, followed by shift mode.

During the load mode, all the parallel inputs are stored in the flipflops.

Then, shift mode is activated, which results in shifting of the stored bits, towards serial output, and within a certain number of clock pulses, the entire output is displayed by serial output.

In the below code, we consider that if load mode is ON, that is (load = 1'b1), shift mode if OFF
and if load mode is OFF, that is (load = 1'b0), shift mode is ON.

We don't take input for the shift bit because we know that it is the inverse of the load bit.
*/

module register_shift_PISO_4_bit(clk, load, parallel_in, serial_out);

    input clk, load;
    input[3:0] parallel_in;
    output reg serial_out;
    

    reg[3:0] temp_out_stream; // Temporary output stream, from which we will assign bits one-by-one to the serial output.

    always @(posedge clk) begin
        if(load) // load mode is ON 
            temp_out_stream = parallel_in;
        else begin // shift mode is ON 
            serial_out = temp_out_stream[3]; 
            // Assigning the MSB of the temporary output stream to the serial output. 
            temp_out_stream = temp_out_stream << 1; 
            // Left shifting the bits of the temporary output stream.

            // So, for a 4-bit number that is loaded, for the next 4 clock pulses the MSB to LSB will one-by-one be shown on the serial output.
        end    


        //? Delay of #0 to show the correct output of the blocking assignment above.
        #0 $display("load : %b\nparallel_in : %b\ntemp_out_stream : %b\nserial_out : %b\n", load, parallel_in, temp_out_stream, serial_out);
    end
endmodule

// Test bench
module register_shift_PISO_4_bit_test;
    
    reg clk, load;
    reg[3:0] parallel_in;
    wire serial_out;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk; // Initially, after 5ns, positive edge of clock is reached. The positive edge is reached every 10ns, so it is reached at 5, 15, 25ns....
        end
    end

    register_shift_PISO_4_bit wire_driver(.clk(clk), .load(load), .parallel_in(parallel_in), .serial_out(serial_out));

    initial begin
        // For every rising edge, the value is different, since 10ns is the length of the clock pulse
        // Load mode is ON for the first clock pulse, then shift mode is ON for the subsequent for the subsequent 4 clock pulses.

            load = 1'b1; parallel_in = 4'b1101;  // Values at rising edge at 5ns
        #10 load = 1'b0; // Values at rising edge at 15ns
        #10 load = 1'b0; // Values at rising edge at 25ns
        #10 load = 1'b0; // Values at rising edge at 35ns
        #10 load = 1'b0; // Values at rising edge at 45ns
        #10 $finish;
    end
    

endmodule