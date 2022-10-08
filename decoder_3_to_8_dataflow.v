module decoder_3_to_8_dataflow(in_lines, out_lines);
    
    input[2:0] in_lines;
    output[7:0] out_lines;

    //* Data-flow modelling
    assign out_lines[0] = ~in_lines[2] & ~in_lines[1] & ~in_lines[0],
           out_lines[1] = ~in_lines[2] & ~in_lines[1] &  in_lines[0],
           out_lines[2] = ~in_lines[2] &  in_lines[1] & ~in_lines[0],
           out_lines[3] = ~in_lines[2] &  in_lines[1] &  in_lines[0],
           out_lines[4] =  in_lines[2] & ~in_lines[1] & ~in_lines[0],
           out_lines[5] =  in_lines[2] & ~in_lines[1] &  in_lines[0],
           out_lines[6] =  in_lines[2] &  in_lines[1] & ~in_lines[0],
           out_lines[7] =  in_lines[2] &  in_lines[1] &  in_lines[0];
    
    // Output may be a bit faulty because everytime a single bit of `out_lines` is being changed, the values are being displayed
    always @(out_lines) begin
        $display("%b: %b", in_lines, out_lines);
    end
endmodule

module decoder_3_to_8_dataflow_test;

    reg[2:0] in_lines;
    wire[7:0] out_lines;
    
    decoder_3_to_8_dataflow wire_driver(in_lines, out_lines);
    
    initial begin
            in_lines = 3'b000;
        #20 in_lines = 3'b001;
        #20 in_lines = 3'b010;
        #20 in_lines = 3'b011;
        #20 in_lines = 3'b100;
        #20 in_lines = 3'b101;
        #20 in_lines = 3'b110;
        #20 in_lines = 3'b111;
        #20 $finish;        
    end

endmodule





