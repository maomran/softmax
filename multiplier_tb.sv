`timescale 1ns/1ps
module multiplier_tb();

reg            clk;
reg            rst;
reg    [31:0]   input_a;
reg    [31:0]   input_b;
reg             input_a_stb;
reg             input_b_stb;
reg            output_z_ack;
wire            input_a_ack;
wire            input_b_ack;
wire            output_z_stb;
wire   [31:0]  output_z;
initial begin 
  clk = 1;
  rst = 1;
  input_a_stb = 0;  
  input_b_stb = 0;
  output_z_ack = 0;
  #10
  rst = 0;
////////////////////////////  
  input_a_stb = 1;  
  input_b_stb = 1;
  output_z_ack = 1;
//  #5
  input_a = 32'h3f000000;
  input_b = 32'h00000000;
  #80
  // input_a_stb = 0;  
  // input_b_stb = 0;
  // output_z_ack = 0;
  // #10
////////////////////////////  
  
  // input_a_stb = 1;  
  // input_b_stb = 1;
  // output_z_ack = 1;
  // #5 
  input_a = 32'h3e19999a;
  input_b = 32'hbe19999a;
  #80
//     input_a_stb = 0;  
//   input_b_stb = 0;
//   output_z_ack = 0;
// ////////////////////////////  
//   #10
  //   input_a_stb = 1;  
  // input_b_stb = 1;
  // output_z_ack = 1;
  // #5
  input_a = 32'h3f000000;
  input_b = 32'h3f000000;
end

multiplier DUT (        
        input_a,
        input_b,
        input_a_stb,
        input_b_stb,
        output_z_ack,
        clk,
        rst,
        output_z,
        output_z_stb,
        input_a_ack,
        input_b_ack);

always 
#5 clk = ~clk;

endmodule // multiplier_tb