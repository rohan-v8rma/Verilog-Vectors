module modelthree(f, a, b, c, d);
  input a, b, c, d;
  output f;  
  
  wire i,j,k,l,m;
 
  xor(j, a, b);
  
  not(i, a);
  
  and(k, i, c);
  
  nand(l, b, d);
  
  or(m, j, k);
  
  or(f, m, l);

endmodule

module testbenchformodelthree;
  reg a, b, c, d;
  wire out;
  modelthree m1(out, a, b, c, d); // we are creating an object h1 using half_adder
  initial
  begin
  // change default runtime from Simulate --> Runtime options 
  // #100 means perform the operation after 100 ps.
  
  // 1'b0 is register 0 , 1'b1 is register 1
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
  end
endmodule





