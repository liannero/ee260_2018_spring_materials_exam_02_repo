module Vr74x182(C0, GI, PI, C, G, P);
  input C0;
  input [3:0] GI, PI;  // Note, active-high G and P in and out in this version
  output reg [3:1] C;
  reg [3:0] Ci;        // Internal version of C to facilitate behavioral for loop
  output reg G, P;
  integer i, j;

  always @ (C0 or GI or PI) begin
    Ci[0] = C0;
    for (i=0; i<=2; i=i+1) Ci[i+1] = GI[i] | (PI[i] & Ci[i]);
    C = Ci[3:1];
    G = (GI[3]|PI[3]) & (GI[3]|GI[2]|PI[2]) & (GI[3]|GI[2]|GI[1]|PI[1]) & (GI[3]|GI[2]|GI[1]|GI[0]);
    P = PI[3] & PI[2] & PI[1] & PI[0];  // Could also code this as P = &P (reduction AND)
  end
endmodule