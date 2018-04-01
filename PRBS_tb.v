`timescale 1ns/1ps
`define OUTLENGTH 8

module PRBS_tb ();

 reg Clock_G;
 reg Clock_M;
 reg Reset;
 wire lock;
 wire bit_error;


initial begin
//	$monitor("Reset %b, Output %b",Reset,LFSR);
    Clock_G = 0;
    Clock_M = 0;
    Reset = 0;
    #10  
    Reset = 1;
    #1000000
    $finish;
  end
  
  always  #1  Clock_M = ~Clock_M;
 
  always  #1  Clock_G = ~Clock_G;

  PRBS DUT(
  	Clock_G,
    Clock_M,
  	Reset,
  	lock,
  	bit_error
    );
 
 endmodule