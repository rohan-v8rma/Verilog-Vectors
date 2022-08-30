module logic_circuit_da_1(f, a, b, c, d);
  input a, b, c, d;
  output out;  
  
  wire wire_1, wire_2, wire_3;
 
  xor(wire_1, a, b);
  
  and(wire_2, ~a, c);
  
  nand(wire_3, b, d);
  
  or(out, wire_1, wire_2, wire_3);

endmodule

module test_bench_for_da_1;
  reg a, b, c, d;
  wire out;

  logic_circuit_da_1 test_instance(out, a, b, c, d); // we are creating an object `test_instance` using the module `logic_circuit_da_1`
  initial begin
  // change default runtime from Simulate --> Runtime options 
  // #100 means perform the operation after 100 ps.
  
  // 1'b means bit-size of 1, with binary radix. 0 and 1 after that are the values.
    #25    a = 1'b0 ; b = 1'b0; c = 1'b0; d = 1'b0;
    #25    a = 1'b1 ; b = 1'b0; c = 1'b0; d = 1'b0;
    #25    a = 1'b0 ; b = 1'b1; c = 1'b0; d = 1'b0;
    #25    a = 1'b1 ; b = 1'b1; c = 1'b0; d = 1'b0;
    #25    a = 1'b0 ; b = 1'b0; c = 1'b1; d = 1'b0;
    #25    a = 1'b1 ; b = 1'b0; c = 1'b1; d = 1'b0;
    #25    a = 1'b0 ; b = 1'b1; c = 1'b1; d = 1'b0;
    #25    a = 1'b1 ; b = 1'b1; c = 1'b1; d = 1'b0;
    #25    a = 1'b0 ; b = 1'b0; c = 1'b0; d = 1'b1;
    #25    a = 1'b1 ; b = 1'b0; c = 1'b0; d = 1'b1;
    #25    a = 1'b0 ; b = 1'b1; c = 1'b0; d = 1'b1;
    #25    a = 1'b1 ; b = 1'b1; c = 1'b0; d = 1'b1;
    #25    a = 1'b0 ; b = 1'b0; c = 1'b1; d = 1'b1;
    #25    a = 1'b1 ; b = 1'b0; c = 1'b1; d = 1'b1;
    #25    a = 1'b0 ; b = 1'b1; c = 1'b1; d = 1'b1;
    #25    a = 1'b1 ; b = 1'b1; c = 1'b1; d = 1'b1;
    #25    $finish
  end
endmodule





