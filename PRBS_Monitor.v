`timescale 1ns/1ps
`define OUTLENGTH 8

module PRBS_Monitor (
	input 							Clock,
	input 							Reset,
	input 	 [`OUTLENGTH-1:0]		LFSR,
	output reg						lock,
	output reg						bit_error 							  
);

reg [`OUTLENGTH-1:0]  	LFSR_m;
reg [`OUTLENGTH-1:0]	counter;



always @(posedge Clock or negedge Reset) begin 
	if(~Reset) begin
		LFSR_m <= 0;
		lock <= 0;
		counter <= 0;
		bit_error <= 0;
	end else begin
		// shift <= LFSR;
		LFSR_m <= { LFSR[`OUTLENGTH-1:0], ~(LFSR_m[`OUTLENGTH/2-1] ^ LFSR_m[`OUTLENGTH/2-2] ^ LFSR_m[`OUTLENGTH/2-3]) } ;
		$display("Monitor %h",LFSR_m);
		if (LFSR_m == LFSR) begin
			lock <=1;
			counter <= counter + 1;
			bit_error <= 0;
		end
		else begin 
			lock <=0;
			counter <= 0;
			if (counter >= 3)
				bit_error <=1;
		end
			

	end
end

endmodule
