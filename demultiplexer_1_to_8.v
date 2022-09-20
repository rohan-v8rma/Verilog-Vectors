module demultiplexer_1_to_8(in, select_lines, output_lines);
    input in; // 1-bit vector for input
    input[2:0] select_lines; // 3-bit vector for select lines
    
    output[7:0] output_lines;  // 8-bit vector for output lines

    //In DEMUX, If we just used case statement and made specific output lines connected to input BASED on the values of select lines, the other lines would be neither 1 nor 0, when they are not connected to input.
    
    assign output_lines[0] = in & ~(select_lines[2]) & ~(select_lines[1]) & ~(select_lines[0]),
           output_lines[1] = in & ~(select_lines[2]) & ~(select_lines[1]) & (select_lines[0]), 
           output_lines[2] = in & ~(select_lines[2]) & (select_lines[1]) & ~(select_lines[0]),
           output_lines[3] = in & ~(select_lines[2]) & (select_lines[1]) & (select_lines[0]),
           output_lines[4] = in & (select_lines[2]) & ~(select_lines[1]) & ~(select_lines[0]),
           output_lines[5] = in & (select_lines[2]) & ~(select_lines[1]) & (select_lines[0]),
           output_lines[6] = in & (select_lines[2]) & (select_lines[1]) & ~(select_lines[0]),
           output_lines[7] = in & (select_lines[2]) & (select_lines[1]) & (select_lines[0]);
endmodule

module demuxtest_1_to_8;
    reg in;
    reg[2:0] select_lines;
    wire[7:0] output_lines;
    demultiplexer_1_to_8 wire_driver(in, select_lines, output_lines);
    
    initial begin
          
          in = 1; 
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


