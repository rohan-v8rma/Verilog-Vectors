module d_flipflop(d, clk, q, set, clear); // Not using qbar over here, to simplify logic. 
    input d, clk, set, clear;
    output reg q;

    initial begin // Clearing the flipflop.
        q <= 0;
    end

    always @(posedge clk) begin
        if(set == 1'b1) begin
            q <= 1;
        end else if(clear == 1'b1) begin
            q <= 0;
        end else begin
            case(d)
                1'b0: q <= 0;
                1'b1: q <= 1; // Non-blocking assignment is important since we have multiple instantiations of the d flipflop, so all the changes should take place at the end of the time step, considering the present states for each of the flipflops' next states.
            endcase
        end

    end
endmodule

module counter_ring_4_bit(clk);
    input clk;

    reg s1, s2, s3, s4;
    reg c1, c2, c3, c4;

    wire d1_out, d2_out, d3_out, d4_out;
    d_flipflop d1(d4_out, clk, d1_out, s1, c1);
    d_flipflop d2(d1_out, clk, d2_out, s2, c2);
    d_flipflop d3(d2_out, clk, d3_out, s3, c3);
    d_flipflop d4(d3_out, clk, d4_out, s4, c4);

    initial begin
        #1 // Setting first flipflop and clearing the rest
        s1 = 1'b1;
        c2 = 1'b1;
        c3 = 1'b1;
        c4 = 1'b1;

        $display("Output of Ring counter : ");

        #5
        s1 = 1'b0;
        c2 = 1'b0;
        c3 = 1'b0;
        c4 = 1'b0;
    end


    always @(posedge clk) begin
        #1
        $display("%b", {d1_out, d2_out, d3_out, d4_out}); 
    end
endmodule


module counter_ring_4_bit_test;
    reg clk;
    initial begin
        clk = 0;
        forever
            #5 clk = ~clk;
    end

    counter_ring_4_bit wire_driver(clk);

    initial begin
        #50 $finish;        
    end

endmodule