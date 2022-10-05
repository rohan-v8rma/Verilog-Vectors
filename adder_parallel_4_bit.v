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

    output[3:0] sum, outcarry;

    adder_full wire_driver_0(sum[0], outcarry[0], num1[0], num2[0], incarry);
    adder_full wire_driver_1(sum[1], outcarry[1], num1[1], num2[1], outcarry[0]);
    adder_full wire_driver_2(sum[2], outcarry[2], num1[2], num2[2], outcarry[1]);
    adder_full wire_driver_3(sum[3], outcarry[3], num1[3], num2[3], outcarry[2]);
endmodule

module testbenchforparalleladder;
    reg[3:0] num1, num2;
    reg incarry;
    
    wire[3:0] sum, outcarry;

    adder_parallel_4_bit wire_driver(sum, outcarry, num1, num2, incarry);

    initial begin
        #30 num1 = 4'b1101; num2 = 4'b1111; incarry = 1'b0;
        #30 num1 = 4'b1000; num2 = 4'b0101; incarry = 1'b1;
        #30 $finish;
    end
endmodule


