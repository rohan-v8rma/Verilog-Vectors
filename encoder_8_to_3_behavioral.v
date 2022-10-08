module encoder_8_to_3_behavioral(in_lines, out_lines);
    input[7:0] in_lines; // 8-bit vector for input lines
    output[2:0] out_lines; // 3-bit vector for output lines
    
    // It is important to declare reg of the same size as the output vector.
    reg[2:0] out_lines;
    
    //* Behavioral Modelling
    always @(in_lines) begin

      //? Using case statement
      case (in_lines) 
        8'b00000001 : out_lines = 3'b000;
        8'b00000010 : out_lines = 3'b001;
        8'b00000100 : out_lines = 3'b010;
        8'b00001000 : out_lines = 3'b011;
        8'b00010000 : out_lines = 3'b100;
        8'b00100000 : out_lines = 3'b101;
        8'b01000000 : out_lines = 3'b110;
        8'b10000000 : out_lines = 3'b111;
        default : out_lines = 3'bxxx; // Since behavior for cases other than the ones mentioned above is NOT defined in encoder.
      endcase

      //? Using if-else
      // if(in_lines == 8'b00000001) 
      //   out_lines = 3'b000;
      // else if(in_lines == 8'b00000010) 
      //   out_lines = 3'b001;
      // else if(in_lines == 8'b00000100) 
      //   out_lines = 3'b010;
      // else if(in_lines == 8'b00001000) 
      //   out_lines = 3'b011;
      // else if(in_lines == 8'b00010000) 
      //   out_lines = 3'b100;
      // else if(in_lines == 8'b00100000) 
      //   out_lines = 3'b101;
      // else if(in_lines == 8'b01000000) 
      //   out_lines = 3'b110;
      // else if(in_lines == 8'b10000000) 
      //   out_lines = 3'b111;
      // else 
      //   out_lines = 3'bxxx;
      
      $display("%b: %b", in_lines, out_lines);  
    end
endmodule



module encoder_8_to_3_behavioral_test;
    reg[7:0] in_lines;
    
    wire[2:0] out_lines;
    
    encoder_8_to_3_behavioral wire_driver(in_lines, out_lines);
    
    initial begin
            in_lines = 8'b00000001;
      #20   in_lines = 8'b00000010;
      #20   in_lines = 8'b00000100;
      #20   in_lines = 8'b00001000;
      #20   in_lines = 8'b00010000;
      #20   in_lines = 8'b00100000;
      #20   in_lines = 8'b01000000;
      #20   in_lines = 8'b10000000;
      #20 $finish;
    end
      
endmodule