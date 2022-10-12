module BIT_SYNC #(
   parameter NUM_STAGES = 2 ,
             BUS_WIDTH = 1
)(
input    wire                      CLK,
input    wire                      RST,
input    wire    [BUS_WIDTH-1:0]   ASYNC,

output   reg     [BUS_WIDTH-1:0]   SYNC
);

reg   [NUM_STAGES-1:0] sync_reg [BUS_WIDTH-1:0] ;

integer  i ;
always @(posedge CLK or negedge RST) 
begin
    if (!RST) 
    begin
        for (i=0 ; i<BUS_WIDTH  ; i=i+1) 
        begin
            sync_reg[i] <= 'b0 ; 
        end
    end 
    else 
    begin
        for (i=0 ; i<BUS_WIDTH  ; i=i+1) 
        begin
            sync_reg[i] <= {sync_reg[i][NUM_STAGES-2:0] , ASYNC[i]} ;
        end
    end
end
    
always @(*)
 begin
  for (i=0 ; i<BUS_WIDTH  ; i=i+1)
    SYNC[i] = sync_reg[i][NUM_STAGES-1] ; 
 end  


endmodule