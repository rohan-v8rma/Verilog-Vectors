module multiplier_8_bit(num1, num2, product);
    input [7:0] num1;
    input [7:0] num2;
    output [15:0] product; 
    // the product of two 8-bit (not digit) numbers can, at maximum, be a 16-bit number 
    
    //* Behavioral Modelling
    assign product = (num1 * num2);
endmodule

module testbenchformultiplier;
    reg[7:0] num1, num2;
    wire [15:0] product; 

    multiplier_8_bit wire_driver(num1, num2, product);

    initial begin
        #20 num1 = 8'b10100000; num2 = 8'b00000010;
        #20 num1 = 8'b00111000; num2 = 8'b00100110;
        #20 $finish;
    end
endmodule

