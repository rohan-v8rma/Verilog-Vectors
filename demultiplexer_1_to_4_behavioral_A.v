// Most basic behavioral modelling

module demultiplexer_1_to_4_behavioral_A(in, select_lines, out_0, out_1, out_2, out_3);
    input in; // 1-bit vector for input
    input[1:0] select_lines; // 2-bit vector for select lines
    output reg out_0, out_1, out_2, out_3; // 4 1-bit vectors for output lines
    
    //* Behavioral modelling
    always @(select_lines or in) begin 
        case(select_lines) 
            2'b00: begin 
                out_0 = in; 
                out_1 = 1'bx; 
                out_2 = 1'bx; 
                out_3 = 1'bx; 
            end
            2'b01: begin 
                out_0 = 1'bx; 
                out_1 = in; 
                out_2 = 1'bx; 
                out_3 = 1'bx; 
            end
            2'b10: begin 
                out_0 = 1'bx; 
                out_1 = 1'bx; 
                out_2 = in; 
                out_3 = 1'bx; 
            end
            2'b11: begin 
                out_0 = 1'bx; 
                out_1 = 1'bx;
                out_2 = 1'bx;
                out_3 = in;
            end
            default: begin
                out_0 = 1'bx;
                out_1 = 1'bx;
                out_2 = 1'bx;
                out_3 = 1'bx;
            end
        endcase

        $display("Input: %b\nSelect lines: %b\nOutput lines: %b\n", in, select_lines, {out_3, out_2, out_1, out_0});
    end 

    

endmodule

module demultiplexer_1_to_4_behavioral_A_test;
    reg in;
    reg[1:0] select_lines;
    wire out_0, out_1, out_2, out_3;
    demultiplexer_1_to_4_behavioral_A wire_driver(in, select_lines, out_0, out_1, out_2, out_3);
    
    initial begin
          
          in = 1; 
          select_lines = 2'b00;
      #20 select_lines = 2'b01;
      #20 select_lines = 2'b10;
      #20 select_lines = 2'b11;
      #20 $finish;
    end
      
endmodule


