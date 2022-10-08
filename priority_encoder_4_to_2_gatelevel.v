module priority_encoder_4_to_2_gatelevel(in_lines, out_lines);
    input[3:0] in_lines; // 4-bit vector for input lines
    output[1:0] out_lines; // 2-bit vector for output lines
    
    //* Gate-level modelling

    // Oth bit
    wire l;
    and(l, ~in_lines[2], in_lines[1]);
    or(out_lines[0], in_lines[3], l);

    // 1st bit
    or(out_lines[1], in_lines[2], in_lines[3]);
    

endmodule


module priority_encoder_4_to_2_gatelevel_test;
    reg[3:0] in_lines;
    
    wire[1:0] out_lines;
    
    priority_encoder_4_to_2_gatelevel wire_driver(in_lines, out_lines);
    
    initial begin
     
      in_lines = 4'b0000;
      #20   in_lines = 4'b0001;
      #20   in_lines = 4'b0011;
      #20   in_lines = 4'b0101;
      #20   in_lines = 4'b1011;
      #20 $finish;
    end
      
endmodule
