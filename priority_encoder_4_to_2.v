module priority_encoder_4_to_2(in_lines, out_lines);
    input[3:0] in_lines; // 4-bit vector for input lines
    output[1:0] out_lines; // 2-bit vector for output lines
    
    assign out_lines = (in_lines[3] == 1'b1) ? 2'b11 : 
                       (in_lines[2] == 1'b1) ? 2'b10 :  
                       (in_lines[1] == 1'b1) ? 2'b01 : 
	                     (in_lines[0] == 1'b1) ? 2'b00 : 2'bxx;
endmodule


module priority_encodertest_4_to_2;
    reg[3:0] in_lines;
    
    wire[1:0] out_lines;
    
    priority_encoder_4_to_2 wire_driver(in_lines, out_lines);
    
    initial begin
     
      in_lines = 4'b0000;
      #20   in_lines = 4'b0001;
      #20   in_lines = 4'b0011;
      #20   in_lines = 4'b0101;
      #20   in_lines = 4'b1011;
      #20 $finish;
    end
      
endmodule
