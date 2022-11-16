module multiplexer_8_to_1_structural_or_gatelevel(select_lines, input_lines, out);
    
    input[2:0] select_lines;
    input[7:0] input_lines;
    

    output out;

    wire wire_1, wire_2, wire_3, wire_4, wire_5, wire_6, wire_7, wire_8;
    and(wire_1, input_lines[0], ~select_lines[2], ~select_lines[1], ~select_lines[0]);
    and(wire_2, input_lines[1], ~select_lines[2], ~select_lines[1],  select_lines[0]);
    and(wire_3, input_lines[2], ~select_lines[2],  select_lines[1], ~select_lines[0]);
    and(wire_4, input_lines[3], ~select_lines[2],  select_lines[1],  select_lines[0]);
    and(wire_5, input_lines[4],  select_lines[2], ~select_lines[1], ~select_lines[0]);
    and(wire_6, input_lines[5],  select_lines[2], ~select_lines[1],  select_lines[0]);
    and(wire_7, input_lines[6],  select_lines[2],  select_lines[1], ~select_lines[0]);
    and(wire_8, input_lines[7],  select_lines[2],  select_lines[1],  select_lines[0]);

    or(out, wire_1, wire_2, wire_3, wire_4, wire_5, wire_6, wire_7, wire_8);

    always @(select_lines or out) begin
        #0 
        $display("Select lines : %b\nInput lines: %b\nOutput: %b\n\n", select_lines, input_lines, out);
    end
endmodule

module multiplexer_8_to_1_structural_or_gatelevel_test;
    reg[2:0] select_lines;
    reg[7:0] input_lines;

    wire out;

    multiplexer_8_to_1_structural_or_gatelevel wire_driver(select_lines, input_lines, out);

    initial begin 
        input_lines = 8'b01011101;
        #10 select_lines = 3'b000;
        #10 select_lines = 3'b001;
        #10 select_lines = 3'b010;
        #10 select_lines = 3'b011;
        #10 select_lines = 3'b100;
        #10 select_lines = 3'b101;
        #10 select_lines = 3'b110;
        #10 select_lines = 3'b111;

    end
endmodule