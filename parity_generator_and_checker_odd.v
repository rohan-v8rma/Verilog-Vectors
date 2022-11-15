module parity_generator_odd(input[3:0] original_message, output[4:0] parity_message);
    reg[4:0] parity_message;

    wire wire_1, parity_bit;
    xor(wire_1, original_message[3], original_message[2], original_message[1], original_message[0]);
    not(parity_bit, wire_1);

    always @(original_message) begin
        parity_message[3:0] = original_message[3:0];
        #0 parity_message[4] = parity_bit;
    end
endmodule


module parity_checker_odd(input[4:0] parity_message, output error_present);
    wire wire_2, error_present;
    xor(wire_2, parity_message[4], parity_message[3], parity_message[2], parity_message[1], parity_message[0]);    
    not(error_present, wire_2);
endmodule

module parity_generator_and_checker_test;
    
    reg[3:0] original_message;
    wire[4:0] parity_message;
    wire error_present;

    parity_generator_odd wire_driver_1(original_message, parity_message);

    parity_checker_odd wire_driver_2(parity_message, error_present);

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
    parity_checker_odd wire_driver_3(user_defined_parity_message, error_present_in_user_defined);

    
    initial begin 
        original_message = 4'b1010;
        #10 original_message = 4'b1110;
    end


    initial begin 
        user_defined_parity_message = 5'b01010;
    end
endmodule
