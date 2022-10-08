module encoder_4_to_2_gatelevel(in_lines, out_lines);
    input[3:0] in_lines; // 8-bit vector for input lines
    output[1:0] out_lines; // 3-bit vector for output lines
    
    //* Gate-level Modelling
    or(out_lines[1], in_lines[3], in_lines[2]);
    or(out_lines[0], in_lines[3], in_lines[1]);

    //? $display should be in procedural block
    always @(out_lines[1] or out_lines[0]) begin
        $display("%b: %b", in_lines, out_lines);      
    end
endmodule


module encoder_4_to_2_gatelevel_test;
    reg[3:0] in_lines;
    
    wire[1:0] out_lines;
    
    encoder_4_to_2_gatelevel wire_driver(in_lines, out_lines);
    
    initial begin
            in_lines = 4'b0001;
      #20   in_lines = 4'b0010;
      #20   in_lines = 4'b0100;
      #20   in_lines = 4'b1000;
      #20 $finish;
    end
      
endmodule