`timescale 1ns / 100ps
module Vr7seg_tb ();
reg EN;
reg [3:0] DIG;
wire SEGA, SEGB, SEGC, SEGD, SEGE, SEGF, SEGG;
integer i;
    
Vr7seg UUT (.DIG(DIG), .EN(EN), SEGA(SEGA), .SEGB(SEGB), .SEGC(SEGC),
            .SEGD(SEGD), .SEGE(SEGE), .SEGF(SEGF), .SEGG(SEGG) );
                 
initial begin
    EN = 1; // Enable all
  for (i=0; i<16; i=i+1) begin
      DIG = i;
      #5 ;
      $write("Iteration = %0d\n", i);
      if (SEGA) $write(" __\n"); else $write("\n");
      if (SEGF) $write("|"); else $write(" ");
      if (SEGG) $write("__"); else $write("  ");
      if (SEGB) $write("|\n"); else $write("\n");
      if (SEGE) $write("|"); else $write(" ");
      if (SEGD) $write("__"); else $write("  ");
      if (SEGC) $write("|\n"); else $write("\n");
    end
  $write("Done\n");
end

endmodule