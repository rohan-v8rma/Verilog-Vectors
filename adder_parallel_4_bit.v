module adder_full(sum, outcarry, a, b, incarry);
    input a, b, incarry;
    output sum, outcarry;

    //* Data-flow modelling
    assign sum = ( (a ^ b) ^ incarry );
    assign outcarry = ( ( (a ^ b) & incarry ) | (a & b) );
endmodule

// The outcarry[3] bit from this module can act as an `incarry` bit for another adder
// The value of sum, represents the sum of both the numbers.
module adder_parallel_4_bit(sum, outcarry, num1, num2, incarry);
    input[3:0] num1, num2;
    input incarry;

    wire[3:0] carry_bits;

    output[3:0] sum;
    output outcarry;

    adder_full wire_driver_0(sum[0], carry_bits[0], num1[0], num2[0], incarry);
    adder_full wire_driver_1(sum[1], carry_bits[1], num1[1], num2[1], carry_bits[0]);
    adder_full wire_driver_2(sum[2], carry_bits[2], num1[2], num2[2], carry_bits[1]);
    adder_full wire_driver_3(sum[3], carry_bits[3], num1[3], num2[3], carry_bits[2]);

    assign outcarry = carry_bits[3];
endmodule

module testbenchforparalleladder;
    reg[3:0] num1, num2;
    reg incarry;
    
    wire[3:0] sum;
    wire outcarry;

    adder_parallel_4_bit wire_driver(sum, outcarry, num1, num2, incarry);

    initial begin
        #30 num1 = 4'b1101; num2 = 4'b1111; incarry = 1'b0;
        #0 $display("Sum of %b and %b, with incarry : (%b) is %b, with outcarry : (%b)", num1, num2, incarry, sum, outcarry);
        
        #30 num1 = 4'b1000; num2 = 4'b0101; incarry = 1'b1;
        #0 $display("Sum of %b and %b, with incarry : (%b) is %b, with outcarry : (%b)", num1, num2, incarry, sum, outcarry);
        
        #30 $finish;
    end
endmodule


