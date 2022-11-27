// Optimization over implementation C. Assignment in behavioral block simplified. Ideal solution.

module demultiplexer_1_to_4_behavioral_C(in, select_lines, out);
    input in; // 1-bit vector for input
    input[1:0] select_lines; // 2-bit vector for select lines
    output reg[3:0] out; // 4-bit vector for output lines

    //* Behavioral modelling
    always @(select_lines or in) begin 
        
        out = 4'bxxxx;

        case(select_lines) 
            2'b00: begin 
                out[0] = in;
            end
            2'b01: begin 
                out[1] = in;
            end
            2'b10: begin
                out[2] = in;
            end
            2'b11: begin 
                out[3] = in;
            end
        endcase

        $display("Input: %b\nSelect lines: %b\nOutput lines: %b\n", in, select_lines, out);
    end 

    

endmodule


module demultiplexer_1_to_4_behavioral_C_test;
    reg in;
    reg[1:0] select_lines;
    wire[3:0] out;
    
    demultiplexer_1_to_4_behavioral_C wire_driver(in, select_lines, out);
    
    initial begin
          in = 1;
           
          select_lines = 2'b00;
      #20 select_lines = 2'b01;
      #20 select_lines = 2'b10;
      #20 select_lines = 2'b11;
      #20 $finish;
    end
      
endmodule


