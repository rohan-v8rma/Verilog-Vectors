module magnitude_comparator_4_bit_behavioral(a, b, a_greater, equal, b_greater);
    input[1:0] a;
    input [1:0] b;
    output reg a_greater, equal, b_greater;

    always @(a or b) begin
        #0
        $display("a : %b\nb: %b", a, b);

        if(a > b) begin 
            a_greater = 1'b1;
            b_greater = 1'b0;
            equal = 1'b0;
        end 
        else if(a < b) begin 
            a_greater = 1'b0;
            b_greater = 1'b1;
            equal = 1'b0;
        end
        else if(a == b) begin 
            a_greater = 1'b0;
            b_greater = 1'b0;
            equal = 1'b1;
        end

        if(equal) 
            $display("a is equal to b\n");
        else if (a_greater)
            $display("a is greater than b\n");
        else if (b_greater)
            $display("a is lesser than b\n");
    end
endmodule

module magnitude_comparator_4_bit_behavioral_test;
    reg[1:0] a, b;
    wire a_greater, equal, b_greater;
    

    magnitude_comparator_4_bit_behavioral wire_driver(a, b, a_greater, equal, b_greater);

    initial begin
        a = 2'b11; b = 2'b10;
        #10 a = 2'b01; b = 2'b10;
        #10 a = 2'b00; b = 2'b00;

    end
endmodule