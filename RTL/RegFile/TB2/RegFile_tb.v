module RegFile_tb ();

//parameters
parameter WIDTH = 16 ; 
parameter ADDR = 3 ;

//Testbench Signals
reg                 clk_TB;
reg                 rst_TB;
reg                 RdEn_TB;
reg                 WrEn_TB;
reg    [ADDR-1:0]   Address_TB;
reg    [WIDTH-1:0]  WrData_TB;
wire   [WIDTH-1:0]  RdData_TB;



//Initial 
initial
 begin

//initialization
initialize() ;


//Reset the design
reset();

//Register Write Operations

do_write('b111,'b01) ;             // first argument is the write address & second argument is the data

do_write('b001,'b11100) ;

do_write('b101,'b1010) ;



//Register Read Operations

do_read_and_check ('b111,'b01) ;    // first argument is the read address & second argument is the expected data

do_read_and_check ('b001,'b11100) ;

do_read_and_check ('b101,'b1010) ;
   

#100

$stop ;

end


////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
 begin
  clk_TB = 1'b0  ; 
  RdEn_TB = 1'b0 ;
  WrEn_TB = 1'b0 ;
 end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
 begin
  rst_TB = 1'b1  ;  
  #5
  rst_TB = 1'b1  ;  
  #5
  rst_TB = 1'b1  ;  
 end
endtask

////////////////// Do write Operation ////////////////////

task do_write ;
 input  [ADDR-1:0]     address ;
 input  [WIDTH-1:0]    data ;
 
 begin
  #10
  WrEn_TB = 1'b1;
  RdEn_TB = 1'b0 ;
  Address_TB = address;
  WrData_TB = data;
 end
endtask

/////////////// Do read Operation & Check /////////////////

task do_read_and_check ;
 input  [ADDR-1:0]     address ;
 input  [WIDTH-1:0]    expected_data ;
 
 begin

 #10
 WrEn_TB = 1'b0 ;
 RdEn_TB = 1'b1 ;
 Address_TB = address;
 #10
  if(RdData_TB != expected_data)
    $display("READ Operation IS Failed");
  else
   $display("READ Operation IS Passed");
 
 end
endtask


////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #5 clk_TB = ~clk_TB ;


////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////
RegFile DUT (
.clk(clk_TB),
.rst(rst_TB),
.RdEn(RdEn_TB),
.WrEn(WrEn_TB),
.Address(Address_TB),
.WrData(WrData_TB),
.RdData(RdData_TB)
);

endmodule