`timescale 1ns / 100ps
module Vr8inprior3_tb();
  reg [7:0] I;
  wire [2:0] A;
  wire IDLE;
  integer ii, errors;

  Vr8inprior3 UUT ( .I(I), .A(A), .IDLE(IDLE) );

  initial begin
    errors = 0;
    for (ii=0; ii<512; ii=ii+1) begin
      I = ii;
      #10 ;
      if (                                   // Identify all error cases
           ( (I==8'b0) && (IDLE!==1'b1) )    // Should be idle
        || ( (I==8'b0) && (A!==3'b000)  )    // A should be 0 when idle
        || ( (I>8'b0)  && (IDLE===1'b1) )    // Should not be idle
        || ( (I==8'b0) && (^A===1'bx)   )    // Be sure no x's in A, else the 
                                             //   next two tests are never true
        || ( (I>8'b0)  && (I<2**A     ) )    // I should be at least 2**A
        || ( (I>8'b0)  && (I>=2**(A+1)) ) )  //   but less than 2**(A+1)
        begin
          errors = errors+1;
          $display("Error: I=%b, A=%b, IDLE=%b",I,A,IDLE);
        end
      end
    $display("Test done, %d errors\n",errors);
  end
endmodule