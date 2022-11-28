module t_flipflop(t, clk, q, qbar);
    input t, clk;
    output reg q, qbar;

    initial begin // clearing the flipflop
        q = 0;
        qbar = 1;
    end

    always @(posedge clk) begin
        case(t)
            1'b1: q = ~q;
            default: q = q;
        endcase
        
        qbar = ~q;
    end

endmodule

module sequence_detector_t_flipflop_1101(in, out, clk);
    input in, clk;
    output reg out;

    wire qa, qa_bar, qb, qb_bar;

    t_flipflop a((qb & in) | (qa & qb), clk, qa, qa_bar);
    t_flipflop b((qa ^ in) | (qb & ~in), clk, qb, qb_bar);
    

    always @(negedge clk) begin // We use negedge over here since we want the input and current state to influence the output. If we had used posedge, the input and the next state would have influenced the output since the state changes at 
        out = qa & qb & in;
        if(out == 1'b1) 
            $display("%b %b <--- `1101` seq. detected", in, out);
        else
            $display("%b %b", in, out);
        
    end 
endmodule

module test;
    reg in;
    wire out;

    reg clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    sequence_detector_t_flipflop_1101 wire_driver(in, out, clk);

    initial begin
            in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 $finish;
    end

endmodule