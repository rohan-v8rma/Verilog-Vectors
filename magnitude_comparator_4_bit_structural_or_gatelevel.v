module magnitude_comparator_4_bit_structural_or_gatelevel(a, b, a_greater, equal, b_greater);
    input[1:0] a;
    input [1:0] b;
    output a_greater, equal, b_greater;

    // Gate-level modelling for `a` greater than `b`
    wire wire_1, wire_2, wire_3;
    and(wire_1, a[1], ~b[1]);
    and(wire_2, a[1],  a[0], ~b[0]);
    and(wire_3, a[0], ~b[1], ~b[0]);
    or(a_greater, wire_1, wire_2, wire_3);

    
    // Gate-level modelling for a equal to b
    wire wire_4, wire_5, wire_6, wire_7;
    and(wire_4,  a[1],  a[0],  b[1],  b[0]);
    and(wire_5, ~a[1], ~a[0], ~b[1], ~b[0]);
    and(wire_6,  a[1], ~a[0],  b[1], ~b[0]);
    and(wire_7, ~a[1],  a[0], ~b[1],  b[0]);
    or(equal, wire_4, wire_5, wire_6, wire_7);

    // Gate-level modelling for `a` lesser than `b`
    wire wire_8, wire_9, wire_10;
    and(wire_8,  ~a[1],  b[1]);
    and(wire_9,  ~a[1], ~a[0],  b[0]);
    and(wire_10, ~a[0],  b[1],  b[0]);
    or(b_greater, wire_8, wire_9, wire_10);

    always @(a or b) begin
        #0
        $display("a : %b\nb: %b", a, b);

        if(equal) 
            $display("a is equal to b\n");
        else if (a_greater)
            $display("a is greater than b\n");
        else if (b_greater)
            $display("a is lesser than b\n");
    end
endmodule

module magnitude_comparator_4_bit_structural_or_gatelevel_test;
    reg[1:0] a, b;
    wire a_greater, equal, b_greater;
    

    magnitude_comparator_4_bit_structural_or_gatelevel wire_driver(a, b, a_greater, equal, b_greater);

    initial begin
        a = 2'b11; b = 2'b10;
        #10 a = 2'b01; b = 2'b10;
        #10 a = 2'b00; b = 2'b00;

    end
endmodule