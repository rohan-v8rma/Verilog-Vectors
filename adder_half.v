module adder_half(x,y,sum,carry);
  input x,y;
  output sum, carry;

  //* Data-flow modelling
  assign carry = x&y;
  assign sum = x^y; // `^` is xor operation
endmodule

module testbenchforhalfadder;
  reg x, y;
  wire sum, carry;
  adder_half h1(x, y, sum, carry); // we are creating an object h1 using `adder_half` module. 
  
  /*
  As we change `x` and `y` during run-time of the program, the values of `sum` and `carry` will also change according to the logic implemented in the `adder_half` module, since those positional parameters are declared as `output`s in the `adder_half` module. 
  
  This can be viewed by adding `sum` and `carry` in the visualizer panel in any software.
  */

  //* Behavioral Modelling
  initial begin
  // change default runtime from Simulate --> Runtime options 
  // #100 means perform the operation after 100 ps.
  
  // 1'b0 is register 0 , 1'b1 is register 1
    #20    x = 1'b0 ; y = 1'b0;
    #20    x = 1'b0 ; y = 1'b1;
    #20    x = 1'b1 ; y = 1'b0;
    #20    x = 1'b1 ; y = 1'b1;
    #20    $finish;
  end
endmodule
