

module sort_top# (
 		parameter DATASIZE=40,
 		parameter SRC_MIN= 36,
		parameter SRC_MAX =39,
		parameter DATA_MIN = 2,
 		parameter DATA_MAX = 21,
 		parameter MY_ID = 4'b0000, //parameter指顺位表对应ID
    	parameter ONE_ID = 4'b0001,
    	parameter TWO_ID = 4'b0010,
    	parameter THR_ID = 4'b0100,
    	parameter FOU_ID = 4'b0101,
    	parameter FIV_ID = 4'b0110,
    	parameter SIX_ID = 4'b1000,
    	parameter SEV_ID = 4'b1001,
   		parameter EIG_ID = 4'b1010 
		)(
			input	wire 	clk,
			input	wire	rst_n,
			input	wire[DATASIZE-1:0]	data_in,
			input	wire	valid_in,
			output	reg[DATASIZE-1:0]	data_out,
			output	reg		valid_out
		);

		wire 	[DATASIZE-1:0]	data_out1;
		wire 	[DATASIZE-1:0]	data_out2;
		wire 	[DATASIZE-1:0]	data_out3;
		wire 	[DATASIZE-1:0]	data_out4;
		wire 	[DATASIZE-1:0]	data_out5;
		wire 	[DATASIZE-1:0]	data_out6;
		wire 	[DATASIZE-1:0]	data_out7;
		wire 	[DATASIZE-1:0]	data_out8;
		reg 	[DATASIZE-1:0]	data_in_d;

		wire	valid_out1;
		wire	valid_out2;
		wire	valid_out3;
		wire	valid_out4;
		wire	valid_out5;
		wire	valid_out6;
		wire	valid_out7;
		wire	valid_out8;

		reg 	valid_in_d;
		reg		valid_in1;
		reg		valid_in2;
		reg		valid_in3;
		reg		valid_in4;
		reg		valid_in5;
		reg		valid_in6;
		reg		valid_in7;
		reg		valid_in8;

		wire 	long_time5_1;
		wire 	long_time5_2;
		wire 	long_time5_3;
		wire 	long_time5_4;
		wire 	long_time5_5;
		wire 	long_time5_6;
		wire 	long_time5_7;
		wire 	long_time5_8;


		wire 	ready1;
		wire 	ready2;
		wire 	ready3;
		wire 	ready4;
		wire 	ready5;
		wire 	ready6;
		wire 	ready7;
		wire 	ready8;



		always @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin
				valid_in_d <= 0;
				valid_in1 <=0;
				valid_in2 <=0;
				valid_in3 <=0;
				valid_in4 <=0;
				valid_in5 <=0;
				valid_in6 <=0;
				valid_in7 <=0;
				valid_in8 <=0;	
				data_in_d	<=0;
			end
			else if (valid_in) begin
				valid_in_d <= valid_in;
				data_in_d	<=data_in;
				case(data_in[SRC_MAX:SRC_MIN])
					ONE_ID:begin
						valid_in1<=1;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
					end
					TWO_ID:begin
						valid_in1<=0;
						valid_in2<=1;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
					end
					THR_ID:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=1;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
					end
					FOU_ID:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=1;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
					end
					FIV_ID:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=1;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
					end
					SIX_ID:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=1;
						valid_in7<=0;
						valid_in8<=0;
					end
					SEV_ID:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=1;
						valid_in8<=0;
					end
					EIG_ID:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=1;
					end
					default:begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
					end
				endcase
			end 
			else begin
						valid_in1<=0;
						valid_in2<=0;
						valid_in3<=0;
						valid_in4<=0;
						valid_in5<=0;
						valid_in6<=0;
						valid_in7<=0;
						valid_in8<=0;
			end
		end

sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_1(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in1&valid_in_d),
    		.data_out(data_out1),
    		.valid_out(valid_out1),
    		.ready(ready1),
    		.long_time5(long_time5_1)
    );
	



sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_2(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in2&valid_in_d),
    		.data_out(data_out2),
    		.valid_out(valid_out2),
    		.ready(ready2),
    		.long_time5(long_time5_2)
    );



sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_3(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in3&valid_in_d),
    		.data_out(data_out3),
    		.valid_out(valid_out3),
    		.ready(ready3),
    		.long_time5(long_time5_3)
    );

sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_4(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in4&valid_in_d),
    		.data_out(data_out4),
    		.valid_out(valid_out4),
    		.ready(ready4),
    		.long_time5(long_time5_4)
    );

sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_5(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in5&valid_in_d),
    		.data_out(data_out5),
    		.valid_out(valid_out5),
    		.ready(ready5),
    		.long_time5(long_time5_5)
    );

sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_6(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in6&valid_in_d),
    		.data_out(data_out6),
    		.valid_out(valid_out6),
    		.ready(ready6),
    		.long_time5(long_time5_6)
    );

sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_7(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in7&valid_in_d),
    		.data_out(data_out7),
    		.valid_out(valid_out7),
    		.ready(ready7),
    		.long_time5(long_time5_7)
    );

sort2 #(
 		.DATASIZE(DATASIZE),
 		.SRC_MIN(SRC_MIN),
		.SRC_MAX(SRC_MAX),
		.DATA_MIN(DATA_MIN),
 		.DATA_MAX(DATA_MAX) 
		)  sort_8(
    		.clk(clk),
    		.rst_n(rst_n),
   		 	.data_in(data_in_d),
    		.valid_in(valid_in8&valid_in_d),
    		.data_out(data_out8),
    		.valid_out(valid_out8),
    		.ready(ready8),
    		.long_time5(long_time5_8)
    );


	wire[7:0]	grant2;
	wire[7:0]	arb_res;
	wire[7:0]	grant1;


	assign grant1 ={valid_in1,valid_in2,valid_in3,valid_in4,valid_in5,valid_in6,valid_in7,valid_in8} ;
	assign grant2 ={valid_out1,valid_out2,valid_out3,valid_out4,valid_out5,valid_out6,valid_out7,valid_out8};
	arbiter8 arbiter(
		.clk(clk),
		.rst_n(rst_n),
		.grant1(grant1),
		.grant2(grant2),
		.arbitration(arb_res)
	);

	assign ready1 = ~grant2[7] | arb_res[7];
	assign ready2 = ~grant2[6] | arb_res[6];
	assign ready3 = ~grant2[5] | arb_res[5];
	assign ready4 = ~grant2[4] | arb_res[4];
	assign ready5 = ~grant2[3] | arb_res[3];
	assign ready6 = ~grant2[2] | arb_res[2];
	assign ready7 = ~grant2[1] | arb_res[1];
	assign ready8 = ~grant2[0] | arb_res[0];

			always @(posedge clk or negedge rst_n) begin
				if(!rst_n)
					data_out <=0;
				else begin
					case({arb_res})
						8'b1000_0000:begin
							data_out<=data_out1;
						end
						8'b0100_0000:begin
							data_out<=data_out2;
						end
						8'b0010_0000:begin
							data_out<=data_out3;
						end
						8'b0001_0000:begin
							data_out<=data_out4;
						end
						8'b0000_1000:begin
							data_out<=data_out5;
						end
						8'b0000_0100:begin
							data_out<=data_out6;
						end
						8'b0000_0010:begin
							data_out<=data_out7;
						end
						8'b0000_0001:begin
							data_out<=data_out8;
						end
						default:begin
							data_out<=0;
						end
					endcase
				end
			end

		always @(posedge clk or negedge rst_n) begin
			if(!rst_n)
				valid_out <=0;
			else
				valid_out <= valid_out1|valid_out2|valid_out3|valid_out4|valid_out5|valid_out6|valid_out7|valid_out8;
		end
endmodule