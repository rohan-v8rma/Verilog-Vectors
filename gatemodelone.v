module gatemodelone(a, b, c, out);
  input a, b, c;
  output out;  

  wire wire_1, wire_2;

  //* Gate-level modelling

  and(wire_2, a, b);
  
  and(wire_1, ~b, c);
  
  or(out, wire_1, wire_2);

endmodule