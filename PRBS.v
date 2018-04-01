`timescale 1ns/1ps
`define OUTLENGTH 8

module PRBS (
	input 			Clock_G,
	input 			Clock_M,
	input 			Reset,
	output     		lock,				
	output     		bit_error	
);

wire [`OUTLENGTH-1:0]  	LFSR_w;

PRBS_Gen Gen(
	Clock_G,
	Reset,
	LFSR_w
	);

PRBS_Monitor Mon(
	Clock_M,
	Reset,
	LFSR_w,
	lock,
	bit_error
	);

endmodule