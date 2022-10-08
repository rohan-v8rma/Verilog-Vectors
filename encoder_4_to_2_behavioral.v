module encoder_4_to_2_behavioral(in_lines, out_lines);
    input[3:0] in_lines; // 8-bit vector for input lines
    output[1:0] out_lines; // 3-bit vector for output lines
    
    // It is important to declare 'reg' of the same size as the output vector.
    reg[1:0] out_lines;
    
    //* Behavioral Modelling
    always @(in_lines) begin
      case (in_lines) 
        4'b0001 : out_lines = 2'b00;
        4'b0010 : out_lines = 2'b01;
        4'b0100 : out_lines = 2'b10;
        4'b1000 : out_lines = 2'b11;
        default : out_lines = 2'bxx; // Since behavior for cases other than the ones mentioned above is NOT defined in encoder.
      endcase
    end
endmodule


module encoder_4_to_2_behavioral_test;
    reg[3:0] in_lines;
    
    wire[1:0] out_lines;
    
    encoder_4_to_2_behavioral wire_driver(in_lines, out_lines);
    
    initial begin
            in_lines = 4'b0001;
      #20   in_lines = 4'b0010;
      #20   in_lines = 4'b0100;
      #20   in_lines = 4'b1000;
      #20 $finish;
    end
      
endmodule