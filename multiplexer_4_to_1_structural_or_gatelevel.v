module multiplexer_4_to_1_structural_or_gatelevel(select_lines, input_lines, out);
    
    input[1:0] select_lines;
    input[3:0] input_lines;
    

    output out;

    wire wire_1, wire_2, wire_3, wire_4;
    and(wire_1, input_lines[0], ~select_lines[1], ~select_lines[0]);
    and(wire_2, input_lines[1], ~select_lines[1], select_lines[0]);
    and(wire_3, input_lines[2], select_lines[1], ~select_lines[0]);
    and(wire_4, input_lines[3], select_lines[1], select_lines[0]);

    or(out, wire_1, wire_2, wire_3, wire_4);

    always @(select_lines or out) begin
        #0 
        $display("Select lines : %b\nInput lines: %b\nOutput: %b\n\n", select_lines, input_lines, out);
    end
endmodule

module multiplexer_4_to_1_structural_or_gatelevel_test;
    reg[1:0] select_lines;
    reg[3:0] input_lines;

    wire out;

    multiplexer_4_to_1_structural_or_gatelevel wire_driver(select_lines, input_lines, out);

    initial begin 
        input_lines = 4'b1101;
        #10 select_lines = 2'b00;
        #10 select_lines = 2'b01;
        #10 select_lines = 2'b10;
        #10 select_lines = 2'b11;

    end
endmodule