module multiplexer_8_to_1_behavioral(input_lines, select_lines, out);
    input[7:0] input_lines; // 8-bit vector for input lines
    input[2:0] select_lines; // 3-bit vector for select lines
    
    output out;
    reg out;
    
    // We use the case statement over here, because there is only one output to change. In the case of de-multiplexer, we need to take care of 4-8 output lines

    always @(input_lines or select_lines) begin
      case (select_lines) 
        3'b000 : out = input_lines[0];
        3'b001 : out = input_lines[1]; 
        3'b010 : out = input_lines[2];
        3'b011 : out = input_lines[3];
        3'b100 : out = input_lines[4];
        3'b101 : out = input_lines[5]; 
        3'b110 : out = input_lines[6];
        3'b111 : out = input_lines[7];
      endcase
    end
endmodule

module muxtest_8_to_1;
    reg[7:0] input_lines;
    reg[2:0] select_lines;
    wire out;
    multiplexer_8_to_1_behavioral wire_driver(input_lines, select_lines, out);
    
    initial begin
          
          input_lines = 8'b01110001; 
          select_lines = 3'b000;
      #20 select_lines = 3'b001;
      #20 select_lines = 3'b010;
      #20 select_lines = 3'b011;
      #20 select_lines = 3'b100;
      #20 select_lines = 3'b101;
      #20 select_lines = 3'b110;
      #20 select_lines = 3'b111;
      #20 $finish;
    end
      
endmodule