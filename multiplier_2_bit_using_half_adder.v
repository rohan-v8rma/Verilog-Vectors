module adder_half(x,y,sum,carry);
    input x,y;
    output sum, carry;

    //* Gate level modelling
    and(carry, x, y);
    xor(sum, x, y);
endmodule

module multiplier_2_bit_using_half_adder(num1, num2, product);
    input[1:0] num1, num2;
    output[3:0] product;

    and(product[0], num1[0], num2[0]);

    wire andout_1;
    and(andout_1, num1[0], num2[1]);

    wire andout_2;
    and(andout_2, num1[1], num2[0]);

    wire c1;
    adder_half wire_driver_1(andout_1, andout_2, product[1], c1);

    wire andout_3;
    and(andout_3, num1[1], num2[1]);

    adder_half wire_driver_2(c1, andout_3, product[2], product[3]);

    always @(num1 or num2)
        #0 $display("%b x %b = %b\n", num1, num2, product); 
        // TODO: Why do we need this #0? Without it we are shown xxxx as output

endmodule

module multiplier_2_bit_using_half_adder_test;
    reg[1:0] num1, num2;
    wire[3:0] product;

    multiplier_2_bit_using_half_adder wire_driver_3(num1, num2, product);

    initial begin 
        num1 = 2'b11;
        num2 = 2'b11;

        #15
        num1 = 2'b10;
        num2 = 2'b11;

        #15
        num1 = 2'b01;
        num2 = 2'b11;
    end

endmodule


