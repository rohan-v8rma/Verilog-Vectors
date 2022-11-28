module sequence_detector_behavioral_1101(in, out, clk); // Clock is need just like in regular sequence detector
    input in, clk;
    output reg out;

    reg[1:0] state0 = 2'b00;
    reg[1:0] state1 = 2'b01;
    reg[1:0] state2 = 2'b10;
    reg[1:0] state3 = 2'b11;
    
    reg[1:0] state;

    initial begin
        state = 2'b00;  
        #0;
    end

    always @(posedge clk) begin
        case(state) 
            // state 0 detected
            state0: begin
                case(in)
                    1'b0: begin
                        state <= state0;
                        out <= 1'b0;
                    end
                    1'b1: begin
                        state <= state1;   
                        out <= 1'b0;
                    end
                endcase
            end

            // state 1 detected
            state1: begin
                case(in)
                    1'b0: begin
                        state <= state0;
                        out <= 1'b0;
                    end
                    1'b1: begin
                        state <= state2;   
                        out <= 1'b0;
                    end
                endcase
            end

            // state 2 detected
            state2: begin 
                case(in)
                    1'b0: begin
                        state <= state3;
                        out <= 1'b0;
                    end
                    1'b1: begin
                        state <= state2;   
                        out <= 1'b0;
                    end
                endcase
            end
            
            // state 3 detected
            state3: begin
                case(in)
                    1'b0: begin
                        state <= state0;
                        out <= 1'b0;
                    end
                    1'b1: begin
                        state <= state1;   
                        out <= 1'b1; // sequence detected
                    end
                endcase
            end

        endcase
        
        #1
        if(out == 1'b1) 
            $display("%b %b <--- `1101` seq. detected", in, out);
        else
            $display("%b %b", in, out);
        
    end
endmodule


module sequence_detector_behavioral_1101_test;
    reg in;
    wire out;

    reg clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    sequence_detector_behavioral_1101 wire_driver(in, out, clk);

    initial begin
            in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #200 $finish;
    end
endmodule