module RegFile #(
parameter WIDTH = 8, 
          DEPTH = 16, 
          ADDR = 4 
) (
input wire                       CLK,
input wire                       RST,
input wire                       WrEn,
input wire                       RdEn,
input wire      [ADDR-1:0]       Address,
input wire      [WIDTH-1:0]      WrData,

output reg      [WIDTH-1:0]      RdData,
output reg                       RdData_VLD,
output wire     [WIDTH-1:0]      REG0,
output wire     [WIDTH-1:0]      REG1,
output wire     [WIDTH-1:0]      REG2,
output wire     [WIDTH-1:0]      REG3
);

reg [WIDTH-1:0] regArr [DEPTH-1:0] ;    
integer i ;

always @(posedge CLK or negedge RST)
begin
   if(!RST)  
    begin
        RdData_VLD <= 1'b0;
	    RdData     <= 1'b0 ;
        for (i=0 ; i<DEPTH ; i=i+1)
        begin
            if (i==2) 
            begin
                regArr[i] <= 'b001000_01;
            end else if (i==3) 
            begin
                regArr[i] <= 'b0000_1000;
            end
            regArr[i] <= 'b0 ;
        end
    end
   else if (WrEn && !RdEn) 
    begin
      regArr[Address] <= WrData ;
    end
   else if (RdEn && !WrEn) 
    begin    
       RdData <= regArr[Address] ;
       RdData_VLD <= 1'b1;
    end
    else 
    begin
        RdData_VLD <= 1'b0;
    end        
end


assign REG0 = regArr[0] ;
assign REG1 = regArr[1] ;
assign REG2 = regArr[2] ;
assign REG3 = regArr[3] ;


endmodule