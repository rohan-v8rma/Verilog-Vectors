// Values of `down_counting`
// 0 stands for up counting
// 1 stands for down counting

module counter_up_down_4_bit(input clk, input down_counting, output [3:0]count);
    
    reg set;
    reg clear;
    reg[3:0] count;

    initial begin
        set = 1'b0;
        clear = 1'b0;

        if(down_counting) begin
            // MOD 16 DOWN counter (counting from 15-0)
            count = 4'd15;

            // MOD 11 DOWN counter (counting from 10-0)
            // count = 4'd10;  
        end else begin
            count = 4'd0; 
        end
    end

    always @(posedge clk) begin

        $display("At time : %d; count is %d", $time, count);
        
        if(down_counting) begin
            if(set) begin

            // MOD 15 DOWN counter
            count = 4'd15;

            // MOD 11 DOWN counter
            // count = 4'd10;

            set = 1'b0;
            
            end else begin 
                
                count = count - 4'd1;
            
                if(count == 4'd0) set = 1'b1; // Print the count 0 at the next posedge, and then SET the count to highest value
                
            end
        end
        else begin
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
        
    end
endmodule

module counter_up_down_4_bit_test;
    
    wire[3:0] count_variable;
    reg clk;
    reg down_counting;

    initial begin
        down_counting = 1'b0; // Down Counting is OFF
        
        clk = 1'b0;
        forever begin
            #5 clk = ~clk;
        end 
    end
    
    counter_up_down_4_bit wire_driver(clk, down_counting, count_variable);

    initial begin 
        
        #200 down_counting = 1'b1; // turning ON Down Counting
        
        #200 $finish;
    end    
    
endmodule