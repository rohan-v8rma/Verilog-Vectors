module parity_generator_even(input[3:0] original_message, output[4:0] parity_message);
    reg[4:0] parity_message;

    wire parity_bit;
    xor(parity_bit, original_message[3], original_message[2], original_message[1], original_message[0]);
    
    always @(original_message) begin
        parity_message[3:0] = original_message[3:0];
        #0 parity_message[4] = parity_bit;
    end
endmodule


module parity_checker_even(input[4:0] parity_message, output error_present);
    wire error_present;
    xor(error_present, parity_message[4], parity_message[3], parity_message[2], parity_message[1], parity_message[0]);    
endmodule

module parity_generator_and_checker_test;
    
    reg[3:0] original_message;
    wire[4:0] parity_message;
    wire error_present;

    parity_generator_even wire_driver_1(original_message, parity_message);

    parity_checker_even wire_driver_2(parity_message, error_present);

    always @(parity_message) begin 
        #1
        if(error_present == 1'b0) begin 
            $display("There is no error in the message : %b", parity_message);
        end else begin
            $display("There is an error in the message : %b", parity_message);
        end
    end

    always @(user_defined_parity_message) begin 
        #1
        if(error_present_in_user_defined == 1'b0) begin 
            $display("There is no error in the user-defined message : %b", user_defined_parity_message);
        end else begin
            $display("There is an error in the user-defined message : %b", user_defined_parity_message);
        end
    end


    reg[4:0] user_defined_parity_message;
    wire error_present_in_user_defined;
    parity_checker_even wire_driver_3(user_defined_parity_message, error_present_in_user_defined);

    
    initial begin 
        original_message = 4'b1010;
        #10 original_message = 4'b1110;
    end


    initial begin 
        user_defined_parity_message = 5'b01010;
    end
endmodule
