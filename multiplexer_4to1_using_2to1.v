module multiplexer_2to1(in_2, select_1, out);
    input[1:0] in_2;
    input select_1;
    output out;

    assign out = in_2[select_1];

endmodule

module multiplexer_4to1_using_2to1(in_4, select_2, out);
    input[3:0] in_4;
    input[1:0] select_2;
    output out;

    wire out0, out1;

    multiplexer_2to1 m1(in_4[1:0], select_2[0], out0);
    multiplexer_2to1 m2(in_4[3:2], select_2[0], out1);
    multiplexer_2to1 m3({out1, out0}, select_2[1], out);


    always @(in_4, select_2)
        #0 $display("Input lines : %b\nSelect lines : %b\nOutput : %b\n", in_4, select_2, out);

endmodule


module mux_tree_test;
    reg[3:0] in_4;
    reg[1:0] select_2;
    wire out;

    multiplexer_4to1_using_2to1 wire_driver(in_4, select_2, out);

    initial begin
        in_4 = 4'b1101;
            select_2 = 2'b00;
        #10 select_2 = 2'b01;
        #10 select_2 = 2'b10;
        #10 select_2 = 2'b11;



    end

endmodule
