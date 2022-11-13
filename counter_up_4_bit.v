module counter_up_4_bit(input clk, output [3:0]count);
    
    reg clear;
    reg[3:0] count;

    initial begin
        count = 4'b000;
    end

    always @(posedge clk) begin

        $display("At time : %d; count is %d", $time, count);
        
        if(clear) begin
            count = 4'd0;
            clear = 1'b0;
        end else begin 

            count = count + 4'd1;
            
            // MOD 16 UP counter (Counting from 0-15. So, when count is 10, we print it on the next iteration, and clear the flipflops)
            if(count == 4'd15) clear = 1'b1;
            // MOD 11 UP counter (Counting from 0-10. So, when count is 10, we print it on the next iteration, and clear the flipflops)
            // if(count == 4'd10) clear = 1'b1;
        end
        
    end
endmodule

module counter_up_4_bit_test;
    
    wire[3:0] count_variable;
    reg clk;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk;
        end
        
    end
    
    counter_up_4_bit wire_driver(clk, count_variable);

    initial begin 
        #200 $finish;
    end    
    
endmodule