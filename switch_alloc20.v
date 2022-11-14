module switch_alloc20#(
  parameter DEPTH=8,
  parameter WIDTH=3,
  parameter DATASIZE=40  //src:4bit, dst:4bit, timestamp:8bit, data:22bit, type:2bit
  )(

  input	wire	clk,
  input	wire	rst_n,

	input	wire[3:0]	L_label,
	input	wire[3:0]	N_label,
	input	wire[3:0]	E_label,
//	input	wire[3:0]	S_label,
//	input	wire[3:0]	W_label,


	input	wire[DATASIZE-1:0]	L_data_in,
	input	wire[DATASIZE-1:0]	E_data_in,
//	input	wire[DATASIZE-1:0]	S_data_in,
//	input	wire[DATASIZE-1:0]	W_data_in,
	input	wire[DATASIZE-1:0]	N_data_in,


	input	wire	N_full,
//	input	wire	S_full,
	input	wire	E_full,
//	input	wire	W_full,


	input 	wire[2:0]		L_arb_res,
	input		wire[2:0]		E_arb_res,
//	input		wire[2:0]		S_arb_res,
//	input 	wire[2:0]		W_arb_res,
	input 	wire[2:0]		N_arb_res,

	output	wire	[2:0]	grant_L,
	output	wire	[2:0]	grant_N,
//	output	wire	[2:0]	grant_S,
//	output	wire	[2:0]	grant_W,
	output	wire	[2:0]	grant_E,

	output	wire	N_ready,
//	output	wire	S_ready,
	output	wire	E_ready,
//	output	wire	W_ready,
	output	wire	L_ready,

	output	reg		L_data_valid,
	output	reg		E_data_valid,
//	output	reg		S_data_valid,
//	output	reg		W_data_valid,
	output	reg		N_data_valid,

	output	reg[DATASIZE-1:0]	L_data_out,
	output	reg[DATASIZE-1:0]	E_data_out,
//	output	reg[DATASIZE-1:0]	S_data_out,
//	output	reg[DATASIZE-1:0]	W_data_out,
	output	reg[DATASIZE-1:0]	N_data_out

	);


	//grant:D0D1D2D3D4, where D0 = local, D1 = W, D2 = N, D3 = E,D4 = S.

	wire	L_label_valid;
	wire	N_label_valid;
//	wire	S_label_valid;
//	wire	W_label_valid;
	wire	E_label_valid;


	assign  L_label_valid	= 	~(&L_label);
	assign  N_label_valid	= 	~(&N_label);
//	assign  S_label_valid	= 	~(&S_label);
//	assign  W_label_valid	= 	~(&W_label);
	assign  E_label_valid	= 	~(&E_label);


//	assign grant_W = {L_label[3]&L_label_valid, W_label[3]&W_label_valid, E_label[3]&E_label_valid, S_label[3]&S_label_valid};	//left(west)

	assign grant_N = {L_label[2]&L_label_valid,N_label[2]&N_label_valid,E_label[2]&E_label_valid};	//up

	assign grant_E = {L_label[1]&L_label_valid,N_label[1]&N_label_valid,E_label[1]&E_label_valid};	//right

//	assign grant_S = {L_label[0]&L_label_valid,E_label[0]&E_label_valid,S_label[0]&S_label_valid};	//down

	assign grant_L = {~(|L_label),~(|N_label),~(|E_label)};	//local


	reg[DATASIZE-1:0]	L_data_src;
	reg[DATASIZE-1:0]	E_data_src;
//	reg[DATASIZE-1:0]	S_data_src;
//	reg[DATASIZE-1:0]	W_data_src;
	reg[DATASIZE-1:0]	N_data_src;


	reg	L_port_valid;
	reg	N_port_valid;
	reg	E_port_valid;
//	reg	W_port_valid;
//	reg	S_port_valid;

	assign 	 L_ready =  ~L_label_valid | L_arb_res[2] |  (N_arb_res[2] & ~N_full)| (E_arb_res[2] & ~E_full);

//	assign 	 W_ready =  ~W_label_valid | L_arb_res[2] | (W_arb_res[2] & ~W_full)| (E_arb_res[2] & ~E_full)|  (S_arb_res[2] & ~S_full);
	
	assign 	 N_ready =  ~N_label_valid | L_arb_res[1] | (N_arb_res[1] & ~N_full)| (E_arb_res[1] & ~E_full);
	
	assign 	 E_ready =  ~E_label_valid | L_arb_res[0] |  (N_arb_res[0] & ~N_full)|  (E_arb_res[0] & ~E_full);

//	assign 	 S_ready =  ~S_label_valid | L_arb_res[0] |  (E_arb_res[0] & ~E_full)|  (S_arb_res[0] & ~S_full);


	always @(*) begin
		case(L_arb_res)
			3'b001:begin
				L_data_src = E_data_in;
				L_port_valid = 1;
			end
			3'b010:begin
				L_data_src= N_data_in;
				L_port_valid=1;
			end
			3'b100:begin
				L_data_src=L_data_in;
				L_port_valid=1;
			end

			default:begin
				L_data_src	=	'hdeadface;
				L_port_valid=0;
			end
			endcase
	end


		always @(*) begin
		case(E_arb_res)
			3'b001:begin
				E_data_src = E_data_in;
				E_port_valid = 1;
			end
			3'b010:begin
				E_data_src= N_data_in;
				E_port_valid=1;
			end
			3'b100:begin
				E_data_src=L_data_in;
				E_port_valid=1;
			end

			default:begin
				E_data_src	=	'hdeadface;
				E_port_valid=0;
			end
			endcase
	end



		always @(*) begin
		case(N_arb_res)
			3'b001:begin
				N_data_src = E_data_in;
				N_port_valid = 1;
			end
			3'b010:begin
				N_data_src= N_data_in;
				N_port_valid=1;
			end
			3'b100:begin
				N_data_src=L_data_in;
				N_port_valid=1;
			end

			default:begin
				N_data_src	=	'hdeadface;
				N_port_valid=0;
			end
			endcase
	end



		always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin

					L_data_valid	<=		0;
					L_data_out	<=		0;
			end
			else begin
					L_data_valid	<=		L_port_valid;
					L_data_out	<=		L_data_src;
			end
		end




		always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin

					E_data_valid	<=		0;
					E_data_out	<=		0;
			end
			else if(!E_full)begin
					E_data_valid		<=		E_port_valid;
					E_data_out			<=		E_data_src;
			end
			else begin
					E_data_valid		<=		E_data_valid;
					E_data_out			<=		E_data_out;
			end
		end



		always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin

					N_data_valid	<=		0;
					N_data_out	<=		0;
			end
			else if(!N_full)begin
					N_data_valid		<=		N_port_valid;
					N_data_out			<=		N_data_src;
			end
			else begin
					N_data_valid		<=		N_data_valid;
					N_data_out			<=		N_data_out;
			end
		end


endmodule