module CLK_GATE (
input wire       CLK, 
input wire       CLK_EN,

output wire      CLK_GATE
);
/*
reg              Latch_Out;

always @(*) 
begin
  if(!CLK)
  begin
    Latch_out <= CLK_EN ;
  end
end

assign  GATED_CLK = CLK && Latch_Out ;
*/

TLATNCAX12M U0_TLATNCAX12M (
.E(CLK_EN),
.CK(CLK),
.ECK(GATED_CLK)
);


endmodule