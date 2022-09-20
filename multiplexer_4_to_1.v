module multiplexer_4_to_1(input_lines, select_lines, out);
    input[3:0] input_lines; // 4-bit vector for input lines
    input[1:0] select_lines; // 2-bit vector for select lines
    
    output out;
    reg out;
    
    // We use the case statement over here, because there is only one output to change. In the case of de-multiplexer, we need to take care of 4-8 output lines
    
    always @(input_lines or select_lines) begin
      case (select_lines) 
        2'b00 : out = input_lines[0];
        2'b01 : out = input_lines[1]; 
        2'b10 : out = input_lines[2];
        2'b11 : out = input_lines[3];
      endcase
    end
endmodule

module muxtest_4_to_1;
    reg[3:0] input_lines;
    reg[1:0] select_lines;
    wire out;
    multiplexer_4_to_1 wire_driver(input_lines, select_lines, out);
    
    initial begin
          
          input_lines = 4'b0101; select_lines = 2'b00;
      #20 select_lines = 2'b01;
      #20 select_lines = 2'b10;
      #20 select_lines = 2'b11;
      
      
      #20 $finish;
    end
endmodule