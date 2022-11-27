// Optimization over implementation A. 4 variables replaced with 1 4-bit variable.

module demultiplexer_1_to_4_behavioral_B(in, select_lines, out);
    input in; // 1-bit vector for input
    input[1:0] select_lines; // 2-bit vector for select lines
    output reg[3:0] out; // 4-bit vector for output lines

    //* Behavioral modelling
    always @(select_lines or in) begin 
        case(select_lines) 
            2'b00: begin 
                out[0] = in; 
                out[1] = 1'bx; 
                out[2] = 1'bx; 
                out[3] = 1'bx; 
            end
            2'b01: begin 
                out[0] = 1'bx; 
                out[1] = in; 
                out[2] = 1'bx; 
                out[3] = 1'bx; 
            end
            2'b10: begin 
                out[0] = 1'bx; 
                out[1] = 1'bx; 
                out[2] = in; 
                out[3] = 1'bx; 
            end
            2'b11: begin 
                out[0] = 1'bx; 
                out[1] = 1'bx;
                out[2] = 1'bx;
                out[3] = in;
            end
            default: begin
                out[0] = 1'bx;
                out[1] = 1'bx;
                out[2] = 1'bx;
                out[3] = 1'bx;
            end
        endcase

        $display("Input: %b\nSelect lines: %b\nOutput lines: %b\n", in, select_lines, out);
    end 

    

endmodule


module demultiplexer_1_to_4_behavioral_B_test;
    reg in;
    reg[1:0] select_lines;
    wire[3:0] out;
    
    demultiplexer_1_to_4_behavioral_B wire_driver(in, select_lines, out);
    
    initial begin
          
          in = 1; 
          select_lines = 2'b00;
      #20 select_lines = 2'b01;
      #20 select_lines = 2'b10;
      #20 select_lines = 2'b11;
      #20 $finish;
    end
      
endmodule


