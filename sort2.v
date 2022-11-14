module	sort2#(
 		parameter DATASIZE=40,
 		parameter SRC_MIN= 36,
		parameter SRC_MAX =39,
		parameter DATA_MIN = 2,
 		parameter DATA_MAX = 21 
		)(
	input	wire 	clk,
	input	wire	rst_n,
	input	wire[DATASIZE-1:0]	data_in,
	input	wire	valid_in,
	input	wire	ready,
	output	reg[DATASIZE-1:0]	data_out,
	output	reg		valid_out,
	output	wire	long_time5
	);

parameter EMPTY = 4'b0000;
parameter ONE = 4'b0001;
parameter TWO = 4'b0010;
parameter THREE = 4'b0011;
parameter FOUR = 4'b0100;
parameter FULL = 4'b0101;
parameter LONG_TIME1 = 4'b0110;
parameter LONG_TIME2 = 4'b0111;
parameter LONG_TIME3 = 4'b1000;
parameter LONG_TIME4 = 4'b1001;
parameter LONG_TIME5 = 4'b1010;

	reg[DATASIZE-1:0]	data_rank1;
	reg[DATASIZE-1:0]	data_rank2;
	reg[DATASIZE-1:0]	data_rank3;
	reg[DATASIZE-1:0]	data_rank4;
	reg[DATASIZE-1:0]	data_rank5;

	reg[3:0]	state;
	reg[3:0]	next_state;
	reg[4:0]	invalid_cnt;

	wire  in_leq_1;
	wire  in_leq_2;
	wire  in_leq_3;

	assign in_leq_1 = (data_in[DATA_MAX:DATA_MIN]<data_rank1[DATA_MAX:DATA_MIN])? 1:0;
	assign in_leq_2 = (data_in[DATA_MAX:DATA_MIN]<data_rank2[DATA_MAX:DATA_MIN])? 1:0;
	assign in_leq_3 = (data_in[DATA_MAX:DATA_MIN]<data_rank3[DATA_MAX:DATA_MIN])? 1:0;
	assign in_leq_4 = (data_in[DATA_MAX:DATA_MIN]<data_rank4[DATA_MAX:DATA_MIN])? 1:0;
	assign in_leq_5 = (data_in[DATA_MAX:DATA_MIN]<data_rank5[DATA_MAX:DATA_MIN])? 1:0;


	assign long_time5 = (state==LONG_TIME5 | state==FULL)? 1:0;

	always @(*) begin
		case(state)
			EMPTY:begin
					next_state = (valid_in)?	ONE:EMPTY;
				end
			ONE:begin
				if (valid_in) begin
					next_state = TWO;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME1;
				end
				else begin
					next_state = ONE;
				end
			end

			TWO:begin
				if (valid_in) begin
					next_state = THREE;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME2;
				end
				else begin
					next_state = TWO;
				end
			end

			THREE:begin
				if (valid_in) begin
					next_state = FOUR;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME3;
				end
				else begin
					next_state = THREE;
				end
			end

			FOUR:begin
				if (valid_in) begin
					next_state = FULL;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME4;
				end
				else begin
					next_state = FOUR;
				end
			end

			FULL:begin
				if (valid_in) begin
					next_state = FULL;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME5;
				end
				else begin
					next_state = FULL;
				end
			end

			LONG_TIME1:begin
				if (valid_in) begin
					next_state = TWO;
				end
				else if (invalid_cnt[4]) begin
					next_state = EMPTY;
				end
				else begin
					next_state = LONG_TIME1;
				end
			end

			LONG_TIME2:begin
				if (valid_in) begin
					next_state = THREE;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME1;
				end
				else begin
					next_state = LONG_TIME2;
				end
			end

			LONG_TIME3:begin
				if (valid_in) begin
					next_state = FOUR;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME2;
				end
				else begin
					next_state = LONG_TIME3;
				end
			end

			LONG_TIME4:begin
				if (valid_in) begin
					next_state = FULL;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME3;
				end
				else begin
					next_state = LONG_TIME4;
				end
			end

			LONG_TIME5:begin
				if (valid_in) begin
					next_state = FULL;
				end
				else if (invalid_cnt[4]) begin
					next_state = LONG_TIME4;
				end
				else begin
					next_state = LONG_TIME5;
				end
			end
			default:begin
					next_state = EMPTY;
			end

		endcase
	end 

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			invalid_cnt 	<=0;
			
		end
		else if (valid_in) begin
			invalid_cnt 	<=0;
		end
		else if(invalid_cnt==5'b10000) begin
			invalid_cnt 	<= invalid_cnt;
		end
		else if (!ready) begin
			invalid_cnt 	<= invalid_cnt;
		end
		else begin
			invalid_cnt 	<= invalid_cnt + 1'b1;
		end
	end


	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			state 	<=	EMPTY;
		end
		else if (!ready) begin
			state 	<=	state;
		end
		else begin
			state 	<=	next_state;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			data_out <=0;
			valid_out <=0;
			data_rank1 <=0;
			data_rank2 <=0;
			data_rank3 <=0;
			data_rank4 <=0;
			data_rank5 <=0;
		end
		else if (!ready) begin
			data_out <=data_out;
			valid_out <=valid_out;
			data_rank1 <=data_rank1;
			data_rank2 <=data_rank2;
			data_rank3 <=data_rank3;
			data_rank4 <=data_rank4;
			data_rank5 <=data_rank5;
		end
		else begin

			case(state)
			EMPTY:begin
				if(valid_in)begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <= data_in;
					data_rank2 <=0;
					data_rank3 <=0;
					data_rank4 <=0;
					data_rank5 <=0;
				end
				else begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=0;
					data_rank2 <=0;
					data_rank3 <=0;
					data_rank4 <=0;
					data_rank5 <=0;
				end
			end
			ONE:begin
				if (valid_in) begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=(in_leq_1)? data_in:data_rank1;
					data_rank2 <=(!in_leq_1)? data_in:data_rank1;
					data_rank3 <=0;
					data_rank4 <=0;
					data_rank5 <=0;
				end
				else begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=data_rank1;
					data_rank2 <=data_rank2;
					data_rank3 <=data_rank3;
					data_rank4 <=data_rank4;
					data_rank5 <=data_rank5;
				end
			end

			TWO:begin
				data_out <=0;
				valid_out <=0;
				if (valid_in) begin
					case({in_leq_1,in_leq_2})
						2'b11:begin
							data_rank1 <=data_in;
							data_rank2 <=data_rank1;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						2'b01:begin
							data_rank1 <=data_rank1;
							data_rank2 <=data_in;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						default:begin
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_in;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
					endcase
				end
				else begin
					data_rank1 <=data_rank1;
					data_rank2 <=data_rank2;
					data_rank3 <=data_rank3;
					data_rank4 <=data_rank4;
					data_rank5 <=data_rank5;
				end
			end

			THREE:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2,in_leq_3})
						3'b111:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_in;
							data_rank2 <=data_rank1;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						3'b011:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_in;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						3'b001:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_in;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end
						default:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_in;
							data_rank5 <=data_rank5;
						end
					endcase
				end
				else begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=data_rank1;
					data_rank2 <=data_rank2;
					data_rank3 <=data_rank3;
					data_rank4 <=data_rank4;
					data_rank5 <=data_rank5;
				end
			end

			FOUR:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2,in_leq_3,in_leq_4})
						4'b1111:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_in;
							data_rank2 <=data_rank1;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						4'b0111:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_in;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						4'b0011:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_in;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end
						4'b0001:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_in;
							data_rank5 <=data_rank4;
						end
						default:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_in;
						end
					endcase
				end
				else begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=data_rank1;
					data_rank2 <=data_rank2;
					data_rank3 <=data_rank3;
					data_rank4 <=data_rank4;
					data_rank5 <=data_rank5;
				end
			end

			FULL:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2,in_leq_3,in_leq_4,in_leq_5})
						5'b11111:begin
							data_out <=data_in;
							valid_out <=1;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end

						5'b01111:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_in;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end

						5'b00111:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_in;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						5'b00011:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_rank3;
							data_rank3 <=data_in;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						5'b00001:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_rank3;
							data_rank3 <=data_rank4;
							data_rank4 <=data_in;
							data_rank5 <=data_rank5;
						end
						default:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_rank3;
							data_rank3 <=data_rank4;
							data_rank4 <=data_rank5;
							data_rank5 <=data_in;
						end
					endcase
				end
				else begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=data_rank1;
					data_rank2 <=data_rank2;
					data_rank3 <=data_rank3;
					data_rank4 <=data_rank4;
					data_rank5 <=data_rank5;
				end
			end


			LONG_TIME1:begin
				if (valid_in) begin
					data_out <=0;
					valid_out <=0;
					data_rank1 <=(in_leq_1)? data_in:data_rank1;
					data_rank2 <=(!in_leq_1)? data_in:data_rank1;
					data_rank3 <=0;
					data_rank4 <=0;
					data_rank5 <=0;
				end
				else begin
					data_out 	<=	data_rank1;
					valid_out 	<= 1;
					data_rank1	<= 0;
					data_rank2	<= 0;
					data_rank3	<= 0;
					data_rank4 	<= 0;
					data_rank5 	<= 0;
				end
			end

			LONG_TIME2:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2})
						2'b11:begin
							data_rank1 <=data_in;
							data_rank2 <=data_rank1;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						2'b01:begin
							data_rank1 <=data_rank1;
							data_rank2 <=data_in;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						default:begin
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_in;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
					endcase
				end
				else begin
					data_out 	<=	data_rank1;
					valid_out 	<=	1;
					data_rank1 	<=	data_rank2;
					data_rank2	<=	0;
					data_rank3	<=	0;
					data_rank4 	<= 0;
					data_rank5 	<= 0;
				end
			end


			LONG_TIME3:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2,in_leq_3})
						3'b111:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_in;
							data_rank2 <=data_rank1;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						3'b011:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_in;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						3'b001:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_in;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end
						default:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_in;
							data_rank5 <=data_rank5;
						end
					endcase
				end
				else begin
					data_out 	<=	data_rank1;
					valid_out 	<=	1;
					data_rank1 	<=	data_rank2;
					data_rank2	<=	data_rank3;
					data_rank3	<=	0;
					data_rank4 	<=  0;
					data_rank5 	<=  0;
				end
			end

			LONG_TIME4:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2,in_leq_3,in_leq_4})
						4'b1111:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_in;
							data_rank2 <=data_rank1;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						4'b0111:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_in;
							data_rank3 <=data_rank2;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end

						4'b0011:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_in;
							data_rank4 <=data_rank3;
							data_rank5 <=data_rank4;
						end
						4'b0001:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_in;
							data_rank5 <=data_rank4;
						end
						default:begin
							data_out <=0;
							valid_out <=0;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_in;
						end
					endcase
				end
				else begin
					data_out 	<=	data_rank1;
					valid_out 	<=	1;
					data_rank1 	<=	data_rank2;
					data_rank2	<=	data_rank3;
					data_rank3	<=	data_rank4;
					data_rank4 	<=  0;
					data_rank5 	<=  0;
				end
			end

			LONG_TIME5:begin
				if (valid_in) begin
					case({in_leq_1,in_leq_2,in_leq_3,in_leq_4,in_leq_5})
						5'b11111:begin
							data_out <=data_in;
							valid_out <=1;
							data_rank1 <=data_rank1;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end

						5'b01111:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_in;
							data_rank2 <=data_rank2;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end

						5'b00111:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_in;
							data_rank3 <=data_rank3;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						5'b00011:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_rank3;
							data_rank3 <=data_in;
							data_rank4 <=data_rank4;
							data_rank5 <=data_rank5;
						end
						5'b00001:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_rank3;
							data_rank3 <=data_rank4;
							data_rank4 <=data_in;
							data_rank5 <=data_rank5;
						end
						default:begin
							data_out <=data_rank1;
							valid_out <=1;
							data_rank1 <=data_rank2;
							data_rank2 <=data_rank3;
							data_rank3 <=data_rank4;
							data_rank4 <=data_rank5;
							data_rank5 <=data_in;
						end
					endcase
				end
				else begin
					data_out 	<=	data_rank1;
					valid_out 	<=	1;
					data_rank1 	<=	data_rank2;
					data_rank2	<=	data_rank3;
					data_rank3	<=	data_rank4;
					data_rank4 	<=  data_rank5;
					data_rank5 	<=  0;
				end
			end

			default:begin
					data_out 	<=	0;
					valid_out 	<=	0;
					data_rank1 	<=	0;
					data_rank2	<=	0;
					data_rank3	<=	0;
					data_rank4 	<=  0;
					data_rank5 	<=  0;
			end
			endcase

		end
	end

endmodule