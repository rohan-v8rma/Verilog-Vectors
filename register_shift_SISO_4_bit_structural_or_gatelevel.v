module d_flipflop(d, clk, q); // Not using qbar over here, to simplify logic. 
    input d, clk;
    output reg q;

    initial begin // Clearing the flipflop.
        q = 0;
    end

    always @(posedge clk) begin
        case(d)
            1'b0: q <= 0;
            1'b1: q <= 1; // Non-blocking assignment is important since we have multiple instantiations of the d flipflop, so all the changes should take place at the end of the time step, considering the present states for each of the flipflops' next states.
        endcase

    end
endmodule

module register_shift_SISO_4_bit_structural_or_gatelevel(serial_in, serial_out, clk);
    input serial_in, clk;
    output serial_out;

    wire d1_out, d2_out, d3_out;
    d_flipflop d1(serial_in, clk, d1_out);
    d_flipflop d2(d1_out, clk, d2_out);
    d_flipflop d3(d2_out, clk, d3_out);
    d_flipflop d4(d3_out, clk, serial_out);

    always @(posedge clk) begin
        #1
        $display("%b--->%b--->%b\n", serial_in, d2_out, serial_out); // We are only displaying d2_out, since after the posedge of the clk, `d1_out = serial_in` and `serial_out = d3`.
        
    end
endmodule


module register_shift_SISO_4_bit_structural_or_gatelevel_test;
    reg clk;
    initial begin
        clk = 0;
        forever
            #5 clk = ~clk;
    end

    reg serial_in;
    wire serial_out;

    register_shift_SISO_4_bit_structural_or_gatelevel wire_driver(serial_in, serial_out, clk);

    initial begin
            serial_in = 1'b1;
        #10 serial_in = 1'b1;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b1;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b1;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b1;
        #40 $finish;

        
    end

endmodule