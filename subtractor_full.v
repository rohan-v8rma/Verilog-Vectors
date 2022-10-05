module subtractor_full(minuend, subtrahend, inborrow, diff, outborrow);
    input minuend, subtrahend, inborrow; 
    /*
    `inborrow` is the bit that tells us whether the previous operation required a BORROW or not. This information is impactful for the outputs of the current operation.

    inborrow = 0 means the previous operation did NOT require a BORROW. In this case, the operation would BEHAVE like in the case of HALF ADDER
    
    inborrow = 1 means the previous operation did require a BORROW, so we would add 1 to the subtrahend in order to represent this.
    */
    output diff, outborrow; 

    //* Data-flow modelling
    assign diff = minuend ^ subtrahend ^ inborrow;
    assign outborrow = ((~(minuend ^ subtrahend)) & inborrow) + ((~minuend) & subtrahend);
endmodule

module testbenchforfullsubtractor;
    reg minuend, subtrahend, inborrow;
    wire diff, outborrow;

    subtractor_full wire_driver(minuend, subtrahend, inborrow, diff, outborrow);


    //* Behavioral Modelling
    initial begin
               minuend = 1'b0; subtrahend = 1'b0; inborrow = 1'b0;
        #20    minuend = 1'b0; subtrahend = 1'b0; inborrow = 1'b1;
        #20    minuend = 1'b0; subtrahend = 1'b1; inborrow = 1'b0;
        #20    minuend = 1'b0; subtrahend = 1'b1; inborrow = 1'b1;
        #20    minuend = 1'b1; subtrahend = 1'b0; inborrow = 1'b0;
        #20    minuend = 1'b1; subtrahend = 1'b0; inborrow = 1'b1;
        #20    minuend = 1'b1; subtrahend = 1'b1; inborrow = 1'b0;
        #20    minuend = 1'b1; subtrahend = 1'b1; inborrow = 1'b1;
        #20    $finish;
    end

endmodule