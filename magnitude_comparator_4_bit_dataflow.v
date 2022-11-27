module magnitude_comparator_4_bit_dataflow(a, b, a_greater, equal, b_greater);
    input[1:0] a;
    input [1:0] b;
    output a_greater, equal, b_greater;

    assign a_greater = (a[1]&~b[1]) | (a[1]&a[0]&~b[0]) | (a[0]&~b[1]&~b[0]), 
           equal = ( a[1]& a[0]& b[1]& b[0]) | (~a[1]&~a[0]&~b[1]&~b[0]) | ( a[1]&~a[0]& b[1]&~b[0]) | (~a[1]& a[0]&~b[1]& b[0]), 
           b_greater = ( ~a[1]& b[1]) | ( ~a[1]&~a[0]& b[0]) | ( ~a[0]& b[1]& b[0]);


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

module magnitude_comparator_4_bit_dataflow_test;
    reg[1:0] a, b;
    wire a_greater, equal, b_greater;
    

    magnitude_comparator_4_bit_dataflow wire_driver(a, b, a_greater, equal, b_greater);

    initial begin
        a = 2'b11; b = 2'b10;
        #10 a = 2'b01; b = 2'b10;
        #10 a = 2'b00; b = 2'b00;

    end
endmodule