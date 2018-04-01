`timescale 1ns/1ps
`define OUTLENGTH 8

module PRBS_Gen (
	input 							Clock,
	input 							Reset,
	output reg [`OUTLENGTH-1:0]  	LFSR  
);


always @(posedge Clock or negedge Reset) begin 
	if(~Reset) begin
		LFSR <= 0;
	end else begin
		LFSR <= { LFSR[`OUTLENGTH-1:0], ~(LFSR[`OUTLENGTH-1] ^ LFSR[`OUTLENGTH/2-1]) } ;
		$display("Monitor %h",LFSR);

	end
end
endmodule