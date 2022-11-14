`include "rc_10_sub.v"
module rc_10#(
  parameter DEPTH=8,
  parameter WIDTH=3,
  parameter DATASIZE=40
  )(
  output wire[DATASIZE-1:0] data_out_1,
  output wire[3:0] direction_out_1,

  input wire[DATASIZE-1:0] N_data_in,
  input wire N_valid_in,
  input wire[WIDTH:0] N_pressure_in,
  input wire rc_ready_N,
  
  output wire[DATASIZE-1:0] data_out_2,
  output wire[3:0] direction_out_2,

  input wire[DATASIZE-1:0] E_data_in,
  input wire E_valid_in,
  input wire[WIDTH:0] E_pressure_in,
  input wire rc_ready_E,

  output wire[DATASIZE-1:0] data_out_4,
  output wire[3:0] direction_out_4,

  input wire[DATASIZE-1:0] S_data_in,
  input wire S_valid_in,
  input wire[WIDTH:0] S_pressure_in,
  input wire rc_ready_S,

  output wire[DATASIZE-1:0] data_out_5,
  output wire[3:0] direction_out_5,

  input wire[DATASIZE-1:0] L_data_in,
  input wire L_valid_in,
  input wire rc_ready_L,

  input wire rc_clk,
  input wire rst_n
  );

rc_10_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)

    ) rc_10_N (
    .data_out(data_out_1),
    .direction_out(direction_out_1),
    .data_in(N_data_in),
    .valid_in(N_valid_in),
    .rc_ready(rc_ready_N),
    .N_pressure_in(N_pressure_in),
    .E_pressure_in(E_pressure_in),
    .S_pressure_in(S_pressure_in),
    
    .rc_clk(rc_clk),
    .rst_n(rst_n)
    );

    rc_10_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)

    ) rc_10_E (
    .data_out(data_out_2),
    .direction_out(direction_out_2),
    .data_in(E_data_in),
    .valid_in(E_valid_in),
    .rc_ready(rc_ready_E),
    .N_pressure_in(N_pressure_in),
    .E_pressure_in(E_pressure_in),
    .S_pressure_in(S_pressure_in),
    
    .rc_clk(rc_clk),
    .rst_n(rst_n)
    );

    rc_10_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)

    ) rc_10_S (
    .data_out(data_out_4),
    .direction_out(direction_out_4),
    .data_in(S_data_in),
    .valid_in(S_valid_in),
    .rc_ready(rc_ready_S),
    .N_pressure_in(N_pressure_in),
    .E_pressure_in(E_pressure_in),
    .S_pressure_in(S_pressure_in),
    
    .rc_clk(rc_clk),
    .rst_n(rst_n)
    );

    rc_10_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)

    ) rc_10_L (
    .data_out(data_out_5),
    .direction_out(direction_out_5),
    .data_in(L_data_in),
    .valid_in(L_valid_in),
    .rc_ready(rc_ready_L),
    .N_pressure_in(N_pressure_in),
    .E_pressure_in(E_pressure_in),
    .S_pressure_in(S_pressure_in),
    
    .rc_clk(rc_clk),
    .rst_n(rst_n)
    );

endmodule