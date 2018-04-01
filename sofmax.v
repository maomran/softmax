`timescale 1ns / 1ps
`define DATALENGTH 32
`define INPUTMAX 5 
`define IDLE 			2'b00
`define INPUTSTREAM 	2'b01
`define OP 				2'b10

module softmax(
		input wire 						Clock,
		input wire 						Reset,
		input signed [`DATALENGTH-1:0] 	Datain,
		input wire	[`INPUTMAX-1:0]		N,
		output signed [`DATALENGTH-1:0] Dataout
		);

reg [`DATALENGTH-1:0]	Dataout;
reg	[`DATALENGTH-1:0] 	LocalBuffer[`INPUTMAX-1:0];
reg [`INPUTMAX-1:0] 	Counter;
reg [2:0] 				CurrentState;
reg [2:0] 				NextState;

always @(posedge Clock or negedge Reset) begin
	if (Reset) begin
		// reset
		LocalBuffer <= 0;
		Counter <= 0;
		CurrentState <= `IDLE;
	end
	else
		CurrentState <= NextState;
end

always @(posedge Clock) begin
	case(CurrentState) begin
		
		`IDLE: begin
			NextState <= `INPUTSTREAM;	
		end

		`INPUTSTREAM: begin
			if (Counter<=N) begin
				LocalBuffer[Counter] <= Datain;
				Counter <= Counter + 1;
		end
			else begin
				NextState <= `OP;
			end		
			end

		`OP: begin
		
			end
		else begin
			NextState <= `IDLE;
		end


	end
end
	