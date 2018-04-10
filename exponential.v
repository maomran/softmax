`timescale 1ns / 1ps
`define DATALENGTH 32
`define INPUTMAX 5 
`define IDLE 			2'b00
`define INPUTSTREAM 	2'b01
`define OP 				2'b10
module exponential (
		input 	wire 				Clock,
		input 	wire				Reset,
		input	    	[`DATALENGTH-1:0] 	Datain,
		output  reg	[`DATALENGTH-1:0]	DataOut
	
);
wire [`DATALENGTH-1:0] one, six;
reg [`DATALENGTH-1:0]	T0,T1,T2,Ts,Td,Tc;
wire wa_add_1,wb_add_1,wz_add_1;
wire wa_add_2,wb_add_2,wz_add_2;
wire wa_add_3,wb_add_3,wz_add_3;
wire wa_mul_1,wb_mul_1,wz_mul_1;
wire wa_mul_2,wb_mul_2,wz_mul_2;
wire wa_div_1,wb_div_1,wz_div_1;

assign one = 32'h3f800000;
assign six = 32'h40c00000 ;

adder A1 (        
        one,
        T0,
        1,
        1,
        1,
        Clock,
        Reset,
        T1,
        wz_add_1,
        wa_add_1,
        wb_add_1);
multiplier Ms (        
        T0,
        T0,
        wa_add_1,
        wb_add_1,
        wz_add_1,
        Clock,
        Reset,
        Ts,
        wz_mul_1,
        wb_mul_2,
        wa_mul_1);

adder A2 (        
        T1,
        Ts >> 2,
        wa_mul_1,
        wb_mul_1,
        wz_mul_1,
        Clock,
        Reset,
        T2,
        wz_add_2,
        wa_add_2,
        wb_add_2);

multiplier Mc (        
        Ts,
        Ts,
        wa_add_2,
        wb_add_2,
        wz_add_2,
        Clock,
        Reset,
        Tc,
        wz_mul_2,
        wa_mul_2,
        wb_mul_2);

divider D1 (
        Tc,
        six,
        wa_mul_2,
        wb_mul_2,
        wz_mul_2,
        Clock,
        Reset,
        Td,
        wz_div_1,
        wa_div_1,
        wb_div_1
        );

adder A3 (        
        Td,
        T2,
        wa_div_1,
        wb_div_1,
        wz_div_1,
        Clock,
        Reset,
        DataOut,
        wz_add_3,
        wa_add_3,
        wb_add_3);

always @(posedge Clock or negedge Reset) begin 
	if(~Reset) begin
                T0 <= 0;
                T1 <= 0;
                T2 <= 0;
                Ts <= 0;
                Tc <= 0;
                Td <= 0;
		DataOut <= 0;
	end else begin
		T0 <= Datain;
		// T1 <= T0 + 1 ;
		// Ts <= T0 * T0;
		// T2 <= T1 + (Ts >> 2);
		// Tc <= Ts* T0; 
		// DataOut <= T2 + (Tc /6);

	end
end

endmodule
