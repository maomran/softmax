`timescale 1ns/1ps
`define DATAWIDTH 32
`define ADDRWIDTH 8
`define IDLE     2'b00
`define W_ENABLE  2'b01
`define R_ENABLE  2'b10
module APB_Slave
(
  input                         PCLK,
  input                         PRESETn,
  input        [`ADDRWIDTH-1:0] PADDR,
  input                         PWRITE,
  input                         PSEL,
  input        [`DATAWIDTH-1:0] PWDATA,
  output reg   [`DATAWIDTH-1:0] PRDATA,
  output reg                    PREADY
);

reg [`DATAWIDTH-1:0] RAM [0:2**`ADDRWIDTH -1];

reg [1:0] State;



always @(negedge PRESETn or negedge PCLK) begin
  if (PRESETn == 0) begin
    State <= `IDLE;
    PRDATA <= 0;
    PREADY <= 0;
    end

  else begin
    case (State)
      `IDLE : begin
        PRDATA <= 0;
        if (PSEL) begin
          if (PWRITE) begin
            State <= `W_ENABLE;
          end
          else begin
            State <= `R_ENABLE;
          end
        end
      end

      `W_ENABLE : begin
        if (PSEL && PWRITE) begin
          RAM[PADDR]  <= PWDATA;
          PREADY <=1;          
        end
          State <= `IDLE;
      end

      `R_ENABLE : begin
        if (PSEL && !PWRITE) begin
          PREADY <= 1;
          PRDATA <= RAM[PADDR];
        end
        State <= `IDLE;
      end
      default: begin
        State <= `IDLE;
      end
    endcase
  end
end 


endmodule