module router21#(
  parameter DEPTH=8,
  parameter WIDTH=3,
  parameter DATASIZE=40  //src:4bit, dst:4bit, timestamp:8bit, data:22bit, type:2bit
  )(
	input 	wire	clk,
	input 	wire	rst_n,
  output  wire  full,

	input	wire	[DATASIZE-1:0]	L_data_in,
	input	wire	[DATASIZE-1:0]	W_data_in,
	input	wire	[DATASIZE-1:0]	E_data_in,
	input	wire	[DATASIZE-1:0]	N_data_in,



	output	wire	[DATASIZE-1:0]	L_data_out,
	output	wire	[DATASIZE-1:0]	W_data_out,

	output	wire	[DATASIZE-1:0]	E_data_out,
	output	wire	[DATASIZE-1:0]	N_data_out,


	input	wire	L_valid_in,
	input	wire	W_valid_in,
	input	wire	E_valid_in,
	input	wire	N_valid_in,



	output	wire	L_valid_out,
	output	wire	W_valid_out,
	output	wire	E_valid_out,
	output	wire	N_valid_out,


	input	wire[WIDTH:0]	W_prussure_in,
	input	wire[WIDTH:0]	E_prussure_in,
	input	wire[WIDTH:0]	N_prussure_in,

	output	wire[WIDTH:0]	W_prussure_out,
	output	wire[WIDTH:0]	E_prussure_out,
	output	wire[WIDTH:0]	N_prussure_out,
  output  wire[WIDTH:0] L_prussure_out,

	input	wire	W_full_in,
	input	wire	E_full_in,
	input	wire	N_full_in,

	output	wire	W_full_out,
	output	wire	E_full_out,
	output	wire	N_full_out
);


  wire	[DATASIZE-1:0]  L_data_out_fifo;
  wire	[DATASIZE-1:0]  W_data_out_fifo;
 
  wire	[DATASIZE-1:0]  E_data_out_fifo;
  wire	[DATASIZE-1:0]  N_data_out_fifo;


  wire	L_valid_out_fifo;
  wire	W_valid_out_fifo;

  wire	E_valid_out_fifo;
  wire	N_valid_out_fifo;

  wire  L_ready;
  wire  W_ready;
 
  wire  E_ready;
  wire  N_ready;




  fifo_21	#(
      .DEPTH(DEPTH),
      .WIDTH(WIDTH),
      .DATASIZE(DATASIZE)
      ) fifo(
  	

      .E_data_out(E_data_out_fifo),
      .E_valid_out(E_valid_out_fifo),
      .E_full_out(E_full_out),
      .E_pressure_out(E_prussure_out),
      .E_data_in(E_data_in),
      .E_valid_in(E_valid_in),
      .fifo_ready_E(E_ready),

      .N_data_out(N_data_out_fifo),
      .N_valid_out(N_valid_out_fifo),
      .N_full_out(N_full_out),
      .N_pressure_out(N_prussure_out),
      .N_data_in(N_data_in),
      .N_valid_in(N_valid_in),
      .fifo_ready_N(N_ready),

      .W_data_out(W_data_out_fifo),
      .W_valid_out(W_valid_out_fifo),
      .W_full_out(W_full_out),
      .W_pressure_out(W_prussure_out),
      .W_data_in(W_data_in),
      .W_valid_in(W_valid_in),
      .fifo_ready_W(W_ready),

      .L_data_out(L_data_out_fifo),
      .L_valid_out(L_valid_out_fifo),
      .L_full_out(full),
      .L_pressure_out(L_prussure_out),
      .L_data_in(L_data_in),
      .L_valid_in(L_valid_in),
      .fifo_ready_L(L_ready),
  
      .fifo_clk(clk),
      .rst_n(rst_n)
  );


    wire[3:0] L_label;
  
    wire[3:0] E_label;
    wire[3:0] N_label;
    wire[3:0] W_label;


    wire  [DATASIZE-1:0]  L_data_out_rc;
    wire  [DATASIZE-1:0]  W_data_out_rc;
  
    wire  [DATASIZE-1:0]  E_data_out_rc;
    wire  [DATASIZE-1:0]  N_data_out_rc;


   rc_21 #(
      .DEPTH(DEPTH),
      .WIDTH(WIDTH),
      .DATASIZE(DATASIZE)
      ) RC(

     
  
      .data_out_2(E_data_out_rc),
      .direction_out_2(E_label),
      .E_data_in(E_data_out_fifo),
      .E_valid_in(E_valid_out_fifo),
      .E_pressure_in(E_prussure_in),
      .rc_ready_E(E_ready),

      .data_out_3(W_data_out_rc),
      .direction_out_3(W_label),
      .W_data_in(W_data_out_fifo),
      .W_valid_in(W_valid_out_fifo),
      .W_pressure_in(W_prussure_in),
      .rc_ready_W(W_ready),

      .data_out_1(N_data_out_rc),
      .direction_out_1(N_label),
      .N_data_in(N_data_out_fifo),
      .N_valid_in(N_valid_out_fifo),
      .N_pressure_in(N_prussure_in),
      .rc_ready_N(N_ready),

      .data_out_5(L_data_out_rc),
      .direction_out_5(L_label),
      .L_data_in(L_data_out_fifo),
      .L_valid_in(L_valid_out_fifo),
      .rc_ready_L(L_ready),

      .rc_clk(clk),
      .rst_n(rst_n)
  );



   SA21 #(
      .DEPTH(DEPTH),
      .WIDTH(WIDTH),
      .DATASIZE(DATASIZE)
  ) SA(

    .clk(clk),
    .rst_n(rst_n),

    .L_label(L_label),
    .W_label(W_label),
  
    .E_label(E_label),
    .N_label(N_label),

    .L_data_in(L_data_out_rc),
    .W_data_in(W_data_out_rc),
   
    .E_data_in(E_data_out_rc),
    .N_data_in(N_data_out_rc),


  
    .N_full(N_full_in),
    .E_full(E_full_in),
    .W_full(W_full_in),

  
    .W_ready(W_ready),
    .E_ready(E_ready),
    .N_ready(N_ready),
    .L_ready(L_ready),


    .L_data_valid(L_valid_out),
    .W_data_valid(W_valid_out),
  
    .E_data_valid(E_valid_out),
    .N_data_valid(N_valid_out),

    .L_data_out(L_data_out),
    .E_data_out(E_data_out),
    .N_data_out(N_data_out),
    .W_data_out(W_data_out)
 

  );


endmodule