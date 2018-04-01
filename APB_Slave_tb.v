`timescale 1ns/1ps
`define DATAWIDTH 32
`define ADDRWIDTH 8
`define IDLE     2'b00
`define W_ENABLE  2'b01
`define R_ENABLE  2'b10
module APB_Slave_tb ();

  reg                         PCLK;
  reg                         PRESETn;
  reg        [`ADDRWIDTH-1:0] PADDR;
  reg                         PWRITE;
  reg                         PSEL;
  reg     	 [`DATAWIDTH-1:0] PWDATA;
  wire 	  	 [`DATAWIDTH-1:0] PRDATA;
  wire	                      PREADY;

integer i;
integer j;


initial begin
    PCLK = 0;
    PRESETn = 0;
    #10  
    PRESETn = 1;
    PSEL = 0;
    #10
    Write;
    Read;
    #20;
    #10000; 
     $finish;
  end
  
  always  #1  PCLK = ~PCLK;
 
  APB_Slave DUT(PCLK,
				PRESETn,
				PADDR,
				PWRITE,
				PSEL,
				PWDATA,
				PRDATA,
				PREADY    );

 task Write;
 begin
 	// #1;
	for (i = 0; i < 2**`ADDRWIDTH; i=i+1) begin
	@(negedge PCLK) begin
	// @(negedge PCLK) begin
	 	PSEL = 1;
	 	PWRITE = 1;
		PADDR = i;
		PWDATA = i;
	$display("PADDR %h, PWDATA %h  ",PADDR,PWDATA);
	 // end 
	 end
		// #2;
	 	// PSEL = 0; 
	end
    // PSEL = 0;
end
endtask

		 
task Read;
begin 
	for (j = 0;  j< 2**`ADDRWIDTH; j= j+1) begin
	@(negedge PCLK) begin
	 	PSEL = 1;
	 	PWRITE = 0;
	// @(negedge PCLK) begin
	 // end
	 // @(negedge PCLK) begin
		PADDR = j;
	 	// PSEL = 0;
	$display("PADDR %h, PRDATA %h  ",PADDR,PRDATA);
	 // end
	 end
end
end
 endtask
 		
 endmodule