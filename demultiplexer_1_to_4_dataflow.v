module demultiplexer_1_to_4_dataflow(in, select_lines, output_lines);
    input in; // 1-bit vector for input
    input[1:0] select_lines; // 2-bit vector for select lines
    
    output[3:0] output_lines;  // 4-bit vector for output lines

    //In DEMUX, If we just used case statement and made specific output lines connected to input BASED on the values of select lines, the other lines would be neither 1 nor 0 (UNDEFINED), when they are not connected to input.
    
    //* Data-flow modelling
    assign output_lines[0] = in & ~(select_lines[1]) & ~(select_lines[0]),
           output_lines[1] = in & ~(select_lines[1]) & (select_lines[0]), 
           output_lines[2] = in & (select_lines[1]) & ~(select_lines[0]),
           output_lines[3] = in & (select_lines[1]) & (select_lines[0]);    

    always @(in or select_lines) begin
        #0 // After the time step in which 'in' or 'select_lines' is changed, allowing for assignment.
        $display("Input: %b\nSelect lines: %b\nOutput lines: %b\n", in, select_lines, output_lines);
    end

endmodule

module demultiplexer_1_to_4_dataflow_test;
    reg in;
    reg[1:0] select_lines;
    wire[3:0] output_lines;
    demultiplexer_1_to_4_dataflow wire_driver(in, select_lines, output_lines);
    
    initial begin
          
          in = 1; 
          select_lines = 2'b00;
      #20 select_lines = 2'b01;
      #20 select_lines = 2'b10;
      #20 select_lines = 2'b11;
      #20 $finish;
    end
      
endmodule


