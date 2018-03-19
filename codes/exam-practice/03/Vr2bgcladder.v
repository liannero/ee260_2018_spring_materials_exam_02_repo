module Vr2bgcladder(A, B, CIN, S, G, P);
  input [1:0] A, B;
  input CIN;
  output [1:0] S;
  output G, P;
  wire [1:0] Gi, Pi;

  assign Gi = A & B;
  assign Pi = A | B;
  assign S = A + B + CIN;
  assign G = Gi[1] | (Pi[1] & Gi[0]);
  assign P = Pi[1] & Pi[0];
endmodule