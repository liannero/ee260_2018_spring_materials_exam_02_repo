module Vr8bgcladder_tb();
  reg [7:0] A, B;
  reg CIN;
  wire [7:0] S;
  wire G, P;
  integer ai, bi, ci, errors;
  reg cout, coutuut;
  reg [7:0] sum;

  Vr8bgcladder_s UUT ( .A(A), .B(B), .CIN(CIN), .S(S), .G(G), .P(P) );
  
  initial begin
    errors = 0;
    for (ci=0; ci<=1; ci=ci+1)
      for (ai=0; ai<2**8; ai=ai+1)
        for (bi=0; bi<2**8; bi=bi+1) begin
          A = ai; B = bi; CIN = ci;  #20 ;  // Apply test vector and wait
          coutuut = G | (P & CIN) ;  // This is a hack, checks G and P indirectly but not perfectly
          sum = ai+bi+ci;  cout = ((ai+bi+ci)>=2**8);
          if ( (cout!=coutuut) || (sum!=S) ) begin
            errors = errors + 1;
            $display("ERROR: CIN,A,B = %1b,%8b,%8b, COUT,S = %1b,%8b, should be %1b,%8b",
                      CIN, A, B, coutuut, S, cout, sum );
          end
        end
    $display("Errors: %d", errors);
    $stop(1);
  end
endmodule