module ALU #( parameter OPER_WIDTH = 8,
                        OUT_WIDTH = OPER_WIDTH*2
)
(
input wire                  CLK,
input wire                  RST, 
input wire [OPER_WIDTH-1:0] A, 
input wire [OPER_WIDTH-1:0] B,
input wire                  EN,
input wire [3:0]            ALU_FUN, 

output reg [OUT_WIDTH-1:0]  ALU_OUT,
output reg                  OUT_VALID  
);
  
reg [OUT_WIDTH-1:0] ALU_OUT_Comb;
reg                 OUT_VALID_Comb;
  

localparam  Addition = 4'b0000 ,
            Subtraction = 4'b0001 , 
            Multiplication = 4'b0010 ,
            Division = 4'b0011 ,
            AND = 4'b0100 ,
            OR = 4'b0101 ,
            NAND = 4'b0110 ,
            NOR = 4'b0111 ,
            XOR = 4'b1000 ,
            XNOR = 4'b1001 ,
            equalution = 4'b1010 ,
            greater = 4'b1011 ,
            smaller = 4'b1100 ,
            shift_right_1 = 4'b1101 ,
            shift_left_1 = 4'b1110 ;

always @(posedge CLK or negedge RST)
begin
  if(!RST)
   begin
    ALU_OUT   <= 'b0 ;
    OUT_VALID <= 1'b0 ;	
   end
  else 
   begin  
    ALU_OUT   <= ALU_OUT_Comb ;
    OUT_VALID <= OUT_VALID_Comb ;
   end	
end  
 
always @(*)
begin
   OUT_VALID_Comb = 1'b0 ;
   ALU_OUT_Comb   = 1'b0 ;
   if(EN)
    begin   
	 OUT_VALID_Comb = 1'b1 ;
     case (ALU_FUN) 
     Addition: begin
               ALU_OUT_Comb = A+B;
              end
     Subtraction: begin
               ALU_OUT_Comb = A-B;
              end
     Multiplication: begin
               ALU_OUT_Comb = A*B;
              end
     Division: begin
               ALU_OUT_Comb = A/B;
              end
     AND: begin
               ALU_OUT_Comb = A & B;
              end
     OR: begin
               ALU_OUT_Comb = A | B;
              end
     NAND: begin
               ALU_OUT_Comb = ~ (A & B);
              end
     NOR: begin
               ALU_OUT_Comb = ~ (A | B);
              end     
     XOR: begin
               ALU_OUT_Comb =  (A ^ B);
              end
     XNOR: begin
               ALU_OUT_Comb = ~ (A ^ B);
              end           
     equalution: begin
              if (A==B)
                 ALU_OUT_Comb = 'b1;
              else
                 ALU_OUT_Comb = 'b0;
              end
     greater: begin
               if (A>B)
                 ALU_OUT_Comb = 'b10;
               else
                 ALU_OUT_Comb = 'b0;
              end 
     smaller: begin
               if (A<B)
                 ALU_OUT_Comb = 'b11;
               else
                 ALU_OUT_Comb = 'b0;
              end     
     shift_right_1: begin
               ALU_OUT_Comb = A>>1;
              end
     shift_left_1: begin 
               ALU_OUT_Comb = A<<1;
              end
    default: begin
               ALU_OUT_Comb = 'b0;
             end
    endcase
   end
  else
   begin
	 OUT_VALID_Comb = 1'b0 ;
   end   
end  
  
  

endmodule