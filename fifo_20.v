`include "fifo_sub.v"

module fifo_20#(
  parameter DEPTH=8,
  parameter WIDTH=3,
  parameter DATASIZE=40
  )(
  output wire[DATASIZE-1:0] N_data_out,
  output wire N_valid_out,
  output wire N_full_out,
  output wire[WIDTH:0] N_pressure_out,

  input wire[DATASIZE-1:0] N_data_in,
  input wire N_valid_in,
  input wire fifo_ready_N,

  output wire[DATASIZE-1:0] E_data_out,
  output wire E_valid_out,
  output wire E_full_out,
  output wire[WIDTH:0] E_pressure_out,

  input wire[DATASIZE-1:0] E_data_in,
  input wire E_valid_in,
  input wire fifo_ready_E,

  output wire[DATASIZE-1:0] L_data_out,
  output wire L_valid_out,
  output wire L_full_out,
  output wire[WIDTH:0] L_pressure_out,

  input wire[DATASIZE-1:0] L_data_in,
  input wire L_valid_in,
  input wire fifo_ready_L,
  
  input wire fifo_clk,
  input wire rst_n
  );
  
  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_N_20 (
    .wdata(N_data_in),
    .full(N_full_out),
    .wr_en(N_valid_in),
    .rd_en(fifo_ready_N),
    .empty_n(N_valid_out),
    .rdata(N_data_out),
    .count(N_pressure_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );
  
  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_E_20 (
    .wdata(E_data_in),
    .full(E_full_out),
    .wr_en(E_valid_in),
    .rd_en(fifo_ready_E),
    .empty_n(E_valid_out),
    .rdata(E_data_out),
    .count(E_pressure_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );

  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_L_20 (
    .wdata(L_data_in),
    .full(L_full_out),
    .wr_en(L_valid_in),
    .rd_en(fifo_ready_L),
    .empty_n(L_valid_out),
    .rdata(L_data_out),
    .count(L_pressure_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );
  
endmodule