`timescale 1ns / 1ps
`define DATALENGTH 32
`define INPUTMAX 5 
`define IDLE 			2'b00
`define INPUTSTREAM 	2'b01
`define OP 				2'b10
module exponential_tb ();

reg 						Clock;
reg 						Reset;
reg  [`DATALENGTH-1:0] 	Datain;
wire [`DATALENGTH-1:0]	DataOut;


exponential DUT (Clock, Reset, Datain, DataOut);
	
initial begin
	Clock = 0;
	Reset = 0;
	#10
	Reset = 1;
	@( negedge Clock) begin
	Datain = 32'd1;
	#10
	Datain = -32'd4;
	#50 
	$finish;
end
end
always 
#1 Clock = ~Clock;

endmodule 