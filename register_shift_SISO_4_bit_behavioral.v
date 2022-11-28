module register_shift_SISO_4_bit(clk, clear, serial_in, serial_out);
    input clk, clear, serial_in;
    output reg serial_out;

    reg[3:0] output_stream;

    always @(posedge clk) begin

        if (clear) begin 
            output_stream = 4'b0000;
            serial_out = 1'b0;
        end else begin 
            serial_out = output_stream[3];
            output_stream = output_stream << 1;
            output_stream[0] = serial_in;
        end

        #0 $display("clear : %b\nserial_in : %b\noutput_stream : %b\nserial_out : %b\n", clear, serial_in, output_stream, serial_out);
    end

endmodule

module register_shift_SISO_4_bit_test;
    reg clk;
    reg clear;
    reg serial_in;

    wire serial_out;

    initial begin
        serial_in = 1'b0;
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin 
        #0 clear = 1;
        #10 clear = 0; serial_in  = 1;
        #10 clear = 0; serial_in  = 1; 
        #10 clear = 0; serial_in  = 1;
        #10 clear = 0; serial_in  = 0;
        #10 clear = 0; serial_in  = 0;
        #10 clear = 0; serial_in  = 0;
        #10 clear = 0; serial_in  = 1;
        #10 clear = 0; serial_in  = 0;
        #10 clear = 0; serial_in  = 1;
        #10 $finish;
    end

    register_shift_SISO_4_bit wire_driver(clk, clear, serial_in, serial_out);

endmodule