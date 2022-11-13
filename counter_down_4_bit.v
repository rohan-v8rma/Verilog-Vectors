module counter_down_4_bit(input clk, output [3:0]count);
    
    reg set;
    reg[3:0] count;

    initial begin
        // MOD 16 DOWN counter (counting from 15-0)
        count = 4'd15;

        // MOD 11 DOWN counter (counting from 10-0)
        // count = 4'd10;
    end

    always @(posedge clk) begin

        $display("At time : %d; count is %d", $time, count);
        
        if(set) begin

            // MOD 16 DOWN counter (counting from 15-0)
            count = 4'd15;

            // MOD 5 DOWN counter (counting from 10-0)
            // count = 3'd10;

            set = 1'b0;
            
        end else begin 
            
            count = count - 4'd1;
            
            if(count == 4'd0) set = 1'b1; // Print the count 0 at the next posedge, and then SET the count to highest value
            
        end
        
    end
endmodule

module counter_up_4_down_test;
    
    wire[3:0] count_variable;
    reg clk;

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk;
        end
        
    end
    
    counter_down_4_bit wire_driver(clk, count_variable);

    initial begin 
        #200 $finish;
    end    
    
endmodule