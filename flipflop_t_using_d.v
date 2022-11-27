module flipflop_d_behavioral(d, clk, q, q_inverse);

    input d, clk;
    output reg q, q_inverse;

    initial begin // Clearing the flip flop
        q = 1'b0;
        q_inverse = 1'b1;
    end

    always @(posedge clk) begin
        case(d) 
            1'b0: begin q = 0; end // Reset
            1'b1: begin q = 1; end // Set
            default: begin q = q; end
        endcase

        q_inverse = ~q;

        $display("D: %d\nQ: %d, Q_inverse: %d\n\n", d, q, q_inverse);
    end
endmodule

module flipflop_t_using_d(t, clk, q, q_inverse);

    input t, clk;
    output q, q_inverse;

    flipflop_d_behavioral wire_driver(t ^ q, clk, q, q_inverse); // d = t*(q') + (t')*q = t ^ q

endmodule

module flipflop_t_using_d_test;
    
    wire q, q_inverse;
    reg t, clk;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk; 
            // After 5ns, positive edge of clock is reached. 
            // The positive edge is reached every 10ns, so it is reached at 5, 15, 25ns....
        end
    end

    flipflop_t_using_d wire_driver(t, clk, q, q_inverse);

    initial begin
        // When at 5ns, the positive edge of the clock is reached, D is not defined, leading to x value displayed for D.
        // Thereafter for every rising edge, the value is different, since 10ns is the length of the clock pulse
        //
        #10 t = 1'b0;  // Values at rising edge at 15ns
        #10 t = 1'b0;  // Values at rising edge at 25ns
        #10 t = 1'b0;  // Values at rising edge at 35ns
        #10 t = 1'b1;  // Values at rising edge at 45ns
        #10 t = 1'b1;  // Values at rising edge at 55ns
        #10 t = 1'b1;  // Values at rising edge at 65ns
        #10 $finish;
    end

    always @(t) 
        #0 $display("T: %d", t);

endmodule