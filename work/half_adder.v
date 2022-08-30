module half_adder(x,y,sum,carry);
  input x,y;
  output sum, carry;
  assign carry = x&y;
  assign sum = x^y; // `^` is xor operation
endmodule

module testbenchforhalfadder;
  reg x, y;
  wire sum, carry;
  half_adder h1(x, y, sum, carry); // we are creating an object h1 using `half_adder` module. 
  
  /*
  As we change `x` and `y` during run-time of the program, the values of `sum` and `carry` will also change according to the logic implemented in the `half_adder` module, since those positional parameters are declared as `output`s in the `half_adder` module. 
  
  This can be viewed by adding `sum` and `carry` in the visualizer panel in any software.
  */

  initial begin
  // change default runtime from Simulate --> Runtime options 
  // #100 means perform the operation after 100 ps.
  
  // 1'b0 is register 0 , 1'b1 is register 1
    #20    x = 1'b0 ; y = 1'b0;
    #20    x = 1'b0 ; y = 1'b1;
    #20    x = 1'b1 ; y = 1'b0;
    #20    x = 1'b1 ; y = 1'b1;
  end
endmodule
