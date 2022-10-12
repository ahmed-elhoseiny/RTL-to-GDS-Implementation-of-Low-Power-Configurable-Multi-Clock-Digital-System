`timescale 1us/1ns

module ALU_tb ();


  reg [15:0] A_TB;
  reg [15:0] B_TB;
  reg [3:0] ALU_FUN_TB;
  reg CLK_TB;
  wire Arith_Flag_TB;
  wire Logic_Flag_TB; 
  wire CMP_Flag_TB; 
  wire Shift_Flag_TB;
  wire [15:0] ALU_OUT_TB ;
 
  
//concatenate flags
  wire [3:0] Flags ;


  
// parameters
parameter  CLK_PERIOD = 10 ; 
  
  
  
assign Flags = {Arith_Flag_TB, Logic_Flag_TB , CMP_Flag_TB , Shift_Flag_TB};
  
 
  
initial
  begin
    $dumpfile("ALU.vcd");
    $dumpvars ;
    
//initial values
CLK_TB = 1'b0;
    
    $display ("*** TEST CASE 1 ***");
    
A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0000; 

#CLK_PERIOD
    
   if (ALU_OUT_TB == 16'd25 && Flags == 4'd8)
       $display ("Addition IS PASSED") ;
   else
      begin
       $display ("Addition IS FAILED") ;
      end
    
    

    $display ("*** TEST CASE 2 ***") ;

A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0001; 

#CLK_PERIOD
    
   if (ALU_OUT_TB == 16'd25 && Flags == 4'd8)      
      $display ("Subtraction IS FAILED") ; 
   else
      $display ("Subtraction IS PASSED") ;

    
    $display ("*** TEST CASE 3 ***") ;

A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0010; 

#CLK_PERIOD
    
    if (ALU_OUT_TB == 16'd150 && Flags == 4'd8)         
    $display ("Multiplication IS PASSED") ; 
   else
     $display ("Multiplication IS PASSED") ;
    
    
    $display ("*** TEST CASE 4 ***") ;
    
A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0011;     

#CLK_PERIOD
    
   if (ALU_OUT_TB == 16'd1 && Flags == 4'd8)         
    $display ("Division IS PASSED") ; 
   else
     $display ("Division IS FAILED") ;   

    
    $display ("*** TEST CASE 5 ***") ;
 
A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b0100;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b0001 && Flags == 4'd4)     
    $display ("ANDING IS PASSED") ; 
   else
     $display ("ANDING IS FAILED") ;

    
    $display ("*** TEST CASE 6 ***") ;

A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b0101;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b1011 && Flags == 4'd4)   
    $display ("ORING IS PASSED") ; 
   else
     $display ("ORING IS FAILED") ;

    
    $display ("*** TEST CASE 7 ***") ;
 
A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b0110;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'hfffe && Flags == 4'd4)      
    $display ("NANDING IS PASSED") ; 
   else
     $display ("NANDING IS FAILED") ;

    
    $display ("*** TEST CASE 8 ***") ;

A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b0111;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'hfff4 && Flags == 4'd4)   
    $display ("NORING IS PASSED") ; 
   else
     $display ("NORING IS FAILED") ;

    
    $display ("*** TEST CASE 9 ***") ;

A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1000;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b1010 && Flags == 4'd4)    
    $display ("XORING IS PASSED") ; 
   else
     $display ("XORING IS FAILED") ;


    $display ("*** TEST CASE 10 ***") ;

A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1001;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'hfff5 && Flags == 4'd4)    
     $display ("XNORING IS PASSED") ; 
   else
     $display ("XNORING IS FAILED") ;
    
    
    $display ("*** TEST CASE 11 ***") ;

A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1010;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0000 && Flags == 4'd2)   
    $display ("CMP_EQ IS PASSED") ; 
   else
     $display ("CMP_EQ IS FAILED") ;

    
    $display ("*** TEST CASE 12 ***") ;

A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1011;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0010 && Flags == 4'd2) 
    $display ("CMP_GR IS PASSED") ; 
   else
     $display ("CMP_GR IS FAILED") ;

    
    $display ("*** TEST CASE 13 ***") ;
 
A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1100;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0000 && Flags == 4'd2)  
    $display ("CMP_SM IS PASSED") ; 
   else
     $display ("CMP_SM IS FAILED") ;

    
    $display ("*** TEST CASE 14 ***") ;
 
A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1101;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0100 && Flags == 4'd1)    
    $display ("SFT_R IS PASSED") ; 
   else
     $display ("SFT_R  IS FAILED") ;

    
    $display ("*** TEST CASE 15 ***") ;
 
A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1110;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b10010 && Flags == 4'd1)    
    $display ("SFT_L IS PASSED") ; 
   else
     $display ("SFT_L IS FAILED") ;	 

    
    $display ("*** TEST CASE 16 ***") ;
 
A_TB = 16'b1001;
B_TB = 16'b0011;
ALU_FUN_TB = 4'b1111;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b0000 && Flags == 4'd0)    
    $display ("NO_FUN IS PASSED") ; 
   else
     $display ("NO_FUN IS FAILED") ;	 
	 
   #100 $finish;  //finished with simulation 
  end
  

// Clock Generator with 100 KHz (10 us)
  always  #(CLK_PERIOD/2) CLK_TB = ~ CLK_TB;  

// instantiate Design Unit
ALU DUT (
.A(A_TB), 
.B(B_TB),
.ALU_FUN(ALU_FUN_TB),
.CLK(CLK_TB),
.Arith_Flag(Arith_Flag_TB), 
.Logic_Flag(Logic_Flag_TB), 
.CMP_Flag(CMP_Flag_TB), 
.Shift_Flag(Shift_Flag_TB),
.ALU_OUT(ALU_OUT_TB)
);

endmodule