module	SA21#(
  parameter DEPTH=8,
  parameter WIDTH=3,
  parameter DATASIZE=40  //src:4bit, dst:4bit, timestamp:8bit, data:22bit, type:2bit
  )(
  	input	wire	clk,
  	input	wire	rst_n,


  	input	wire[3:0]	L_label,
		input	wire[3:0]	N_label,
		input	wire[3:0]	E_label,
//		input	wire[3:0]	S_label,
		input	wire[3:0]	W_label,


	input	wire[DATASIZE-1:0]	L_data_in,
	input	wire[DATASIZE-1:0]	E_data_in,
//	input	wire[DATASIZE-1:0]	S_data_in,
	input	wire[DATASIZE-1:0]	W_data_in,
	input	wire[DATASIZE-1:0]	N_data_in,


	input	wire	N_full,
//	input	wire	S_full,
	input	wire	E_full,
	input	wire	W_full,

	output	wire	N_ready,
//	output	wire	S_ready,
	output	wire	E_ready,
	output	wire	W_ready,
	output	wire	L_ready,

	output	wire	L_data_valid,
	output	wire	E_data_valid,
//	output	wire	S_data_valid,
	output	wire	W_data_valid,
	output	wire	N_data_valid,

	output	wire[DATASIZE-1:0]	L_data_out,
	output	wire[DATASIZE-1:0]	E_data_out,
//	output	wire[DATASIZE-1:0]	S_data_out,
	output	wire[DATASIZE-1:0]	W_data_out,
	output	wire[DATASIZE-1:0]	N_data_out

  );


  wire[3:0]		L_arb_res;
	wire[3:0]		E_arb_res;
//	wire[3:0]		S_arb_res;
	wire[3:0]		W_arb_res;
	wire[3:0]		N_arb_res;

	wire[3:0]		grant_L;
	wire[3:0]		grant_N;
//	wire[3:0]		grant_S;
	wire[3:0]		grant_W;
	wire[3:0]		grant_E;


  	arbiter4 arbiterL(
		.clk(clk),
		.rst_n(rst_n),
		.grant(grant_L),
		.arbitration(L_arb_res)
		);

  	arbiter4 arbiterN(
		.clk(clk),
		.rst_n(rst_n),
		.grant(grant_N),
		.arbitration(N_arb_res)
		);


  	arbiter4 arbiterW(
		.clk(clk),
		.rst_n(rst_n),
		.grant(grant_W),
		.arbitration(W_arb_res)
		);

  	arbiter4 arbiterE(
		.clk(clk),
		.rst_n(rst_n),
		.grant(grant_E),
		.arbitration(E_arb_res)
		);



  	switch_alloc21	#(
    	.DEPTH(DEPTH),
    	.WIDTH(WIDTH),
    	.DATASIZE(DATASIZE)
    	) switch_alloc(

    	.clk(clk),
  		.rst_n(rst_n),
  
		.L_label(L_label),
		.N_label(N_label),
		.E_label(E_label),
//		.S_label(S_label),
		.W_label(W_label),


		.L_data_in(L_data_in),
		.W_data_in(W_data_in),
		.N_data_in(N_data_in),
		.E_data_in(E_data_in),
//		.S_data_in(S_data_in),


		.N_full(N_full),
//		.S_full(S_full),
		.E_full(E_full),
		.W_full(W_full),


		.L_arb_res(L_arb_res),
		.E_arb_res(E_arb_res),
//		.S_arb_res(S_arb_res),
		.W_arb_res(W_arb_res),
		.N_arb_res(N_arb_res),

		.grant_L(grant_L),
		.grant_N(grant_N),
//		.grant_S(grant_S),
		.grant_W(grant_W),
		.grant_E(grant_E),

		.N_ready(N_ready),
		.L_ready(L_ready),
		.E_ready(E_ready),
//		.S_ready(S_ready),
		.W_ready(W_ready),

		.L_data_valid(L_data_valid),
		.W_data_valid(W_data_valid),
		.N_data_valid(N_data_valid),
		.E_data_valid(E_data_valid),
//		.S_data_valid(S_data_valid),


		.L_data_out(L_data_out),
		.W_data_out(W_data_out),
		.N_data_out(N_data_out),
		.E_data_out(E_data_out)
//		.S_data_out(S_data_out)
    );

endmodule