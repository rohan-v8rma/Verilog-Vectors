module half_subtractor(minuend, subtrahend, diff, outborrow);
    input minuend, subtrahend; 
    // `minuend` is the value from which the subtraction has to be done. `subtrahend` is the value that has to be subtracted.
    output diff, outborrow; 
    /* 
    `outborrow` is the bit which represents whether the completion of the operation (minuend - subtrahend) required borrowing or NOT. 
    
    outborrow = 0 means the operation did NOT require a BORROW.

    outborrow = 1 means the operation did require a BORROW.

    This `outborrow` can be fed into another HALF SUBTRACTOR.
    OR
    The `inborrow` bit of a FULL SUBTRACTOR.
    */

    //* Data flow Modelling
    assign diff = (minuend ^ subtrahend);
    assign outborrow = (~minuend) & subtrahend;
endmodule

module testbenchforhalfsubtractor;
    reg minuend, subtrahend;
    wire diff, outborrow;

    half_subtractor wire_driver(minuend, subtrahend, diff, outborrow);
    // We name the instance of the module as `wire_driver` since it is DRIVING the values of the wires `diff` and `outborrow`.

    //* Behavioral Modelling
    initial begin
             minuend = 1'b0; subtrahend = 1'b0;
        #20  minuend = 1'b0; subtrahend = 1'b1;
        #20  minuend = 1'b1; subtrahend = 1'b0;
        #20  minuend = 1'b1; subtrahend = 1'b1;
        #20  $finish;
    end
endmodule