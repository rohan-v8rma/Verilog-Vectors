module priority_encoder_4_to_2_behavioral(in_lines, out_lines);
    input[3:0] in_lines; // 4-bit vector for input lines
    output[1:0] out_lines; // 2-bit vector for output lines
    
    // It is important to declare reg of the same size as the output vector.
    reg[1:0] out_lines;

    //* Behavioral Modelling
    always @(in_lines) begin

      //? Using if-else, from MSB to LSB
      if(in_lines[3] == 1'b1)
        out_lines = 2'b11;
      else if(in_lines[2] == 1'b1)
        out_lines = 2'b10;
      else if(in_lines[1] == 1'b1)
        out_lines = 2'b01;
      else if(in_lines[0] == 1'b1)
        out_lines = 2'b00;
      else 
        out_lines = 2'bxx; // Undefined behavior case

      //! Case-statement like this doesn't work
      // case (in_lines)
      //   4'b1xxx : out_lines = 2'b11;
      //   4'b01xx : out_lines = 2'b10;
      //   4'b0010 : out_lines = 2'b01;
      //   4'b0001 : out_lines = 2'b00;
      //   default : out_lines = 2'bxx; // Undefined behavior case
      // endcase

      $display("%b: %b", in_lines, out_lines);
    end



endmodule


module priority_encoder_4_to_2_behavioral_test;
    reg[3:0] in_lines;
    
    wire[1:0] out_lines;
    
    priority_encoder_4_to_2_behavioral wire_driver(in_lines, out_lines);
    
    initial begin
     
      in_lines = 4'b0000;
      #20   in_lines = 4'b0001;
      #20   in_lines = 4'b0011;
      #20   in_lines = 4'b0101;
      #20   in_lines = 4'b1011;
      #20 $finish;
    end
      
endmodule
