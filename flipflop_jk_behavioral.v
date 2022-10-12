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
            2'b01: begin q = 1'b0; q_inverse = 1'b1; end
            2'b10: begin q = 1'b1; q_inverse = 1'b0; end
            2'b11: begin q = ~q; q_inverse = ~q_inverse; end
            default: begin q = q; q_inverse = q_inverse; end
        endcase

        $display("%d, %d, %d, %d\n", j, k, q, q_inverse);
    end
endmodule

module flipflop_jk_behavioral_test;
    
    wire q, q_inverse;
    reg j, k, clk;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk; // After 5ns, positive edge of clock is reached. The positive edge is reached every 10ns, so it is reached at 5, 15, 25ns....
        end
    end

    flipflop_jk_behavioral wire_driver(j, k, clk, q, q_inverse);

    initial begin
        // When at 5ns, the positive edge of the clock is reached, j and k are not defined, leading to x, x output 
        // Thereafter for every rising edge, the value is different, since 10ns is the length of the clock pulse
        //
        #10 j = 1'b1; k = 1'b1;  // Values at rising edge at 15ns
        #10 j = 1'b1; k = 1'b1;  // Values at rising edge at 25ns
        #10 j = 1'b1; k = 1'b1;  // Values at rising edge at 35ns
        #10 j = 1'b0; k = 1'b1;  // Values at rising edge at 45ns
        #10 j = 1'b1; k = 1'b0;  // Values at rising edge at 55ns
        #10 $finish;
    end
    

endmodule