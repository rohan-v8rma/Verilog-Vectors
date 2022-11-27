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

module sequence_detector_t_flipflop_1101(istream, ostream);
    input[15:0] istream;
    output reg[15:0] ostream;
    reg[15:0] count;
    
    reg clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    wire qa, qa_bar, qb, qb_bar;

    t_flipflop a((qb & in) | (qa & qb), clk, qa, qa_bar);
    t_flipflop b((qa ^ in) | (qb & ~in), clk, qb, qb_bar);

    reg break_var, in;
    always @(istream) begin
        #0
        count = 4'b1111;
        ostream = 16'b0000000000000000;
        break_var = 1'b0;
        in = istream[count];

        while(break_var != 1'b1) begin // We need to use break_var instead of count as the loop variable because if we keep the condition count != 4'b0000, then the last bit in our sequence will be missed.
            
            if(count == 4'b0000)            
                break_var = 1'b1;
            
            #10
            in = istream[count];
            ostream[count] = qa & qb & in; // We do these 2 assignments at the same timestep because the output is associated with the present state(present values of qa & qb) and present input (new value of in, we just assigned) itself, not with the next state(values of qa & qb associated with present input `in`) and present input. If that were true, we would have put a delay between `in` assignment and `ostream[count]` assignment.

            count = count - 1'b1;
        end 
        
        #10 $display("Sequence to be detected : %b\nInput bits  : %b\nOutput bits : %b\n", 4'b1101, istream, ostream);
    end 
endmodule

module test;
    reg[15:0] istream;
    wire[15:0] ostream;

    sequence_detector_t_flipflop_1101 wire_driver(istream, ostream);

    initial begin
        istream = 16'b1101101101101101;
        #400 $finish;
    end
endmodule