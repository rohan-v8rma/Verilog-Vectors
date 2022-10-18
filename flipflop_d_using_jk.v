module flipflop_jk_behavioral(j, k, clk, q, q_inverse);

    input j, k, clk;
    output q, q_inverse;

    reg q, q_inverse;

    initial begin // Clearing the flip flop
        q = 1'b0;
        q_inverse = 1'b1;
    end

    always @(posedge clk) begin
        case({j, k}) 
            2'b01: begin q = 1'b0; end
            2'b10: begin q = 1'b1; end
            2'b11: begin q = ~q; end
            default: begin q = q; end
        endcase

        q_inverse = ~q;

        $display("J: %d, K:%d\nQ: %d, Q_inverse: %d\n\n", j, k, q, q_inverse);
    end
endmodule

module flipflop_d_using_jk(d, clk, q, q_inverse);

    input d, clk;
    output q, q_inverse;

    flipflop_jk_behavioral wire_driver(d, ~d, clk, q, q_inverse);

endmodule

module flipflop_d_using_jk_test;
    
    wire q, q_inverse;
    reg d, clk;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk; 
            // After 5ns, positive edge of clock is reached. 
            // The positive edge is reached every 10ns, so it is reached at 5, 15, 25ns....
        end
    end

    flipflop_d_using_jk wire_driver(d, clk, q, q_inverse);

    initial begin
        // When at 5ns, the positive edge of the clock is reached, J and K are not defined, leading to x, x values for J and K.
        // Thereafter for every rising edge, the value is different, since 10ns is the length of the clock pulse
        //
        #10 d = 1'b1;  // Values at rising edge at 15ns
        #10 d = 1'b0;  // Values at rising edge at 25ns
        #10 d = 1'b1;  // Values at rising edge at 35ns
        #10 d = 1'b0;  // Values at rising edge at 45ns
        #10 d = 1'b1;  // Values at rising edge at 55ns
        #10 $finish;
    end
    
    always @(d) 
        $display("D: %d", d);

endmodule