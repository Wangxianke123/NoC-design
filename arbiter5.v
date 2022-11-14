module arbiter5(
	input	wire		clk,
	input	wire		rst_n,
	input	wire[4:0]	grant,
	output	wire[4:0]	arbitration
	);


	reg	prio4_3;	reg	prio4_2;	reg	prio4_1;	reg	prio4_0;
	reg	prio3_2;	reg	prio3_1;	reg	prio3_0;
	reg	prio2_1;	reg	prio2_0;
	reg	prio1_0;



	assign arbitration[4] = grant[4]& (~grant[3] | prio4_3) & (~grant[2] | prio4_2) &(~grant[1] | prio4_1)& (~grant[0] | prio4_0);

	assign arbitration[3] = grant[3]& (~grant[4] | ~prio4_3) & (~grant[2] | prio3_2) &(~grant[1] | prio3_1)& (~grant[0] | prio3_0);

	assign arbitration[2] = grant[2]& (~grant[4] | ~prio4_2) & (~grant[3] | ~prio3_2) &(~grant[1] | prio2_1)& (~grant[0] | prio2_0);

	assign arbitration[1] = grant[1]& (~grant[4] | ~prio4_1) & (~grant[3] | ~prio3_1) &(~grant[2] | ~prio2_1)& (~grant[0] | prio1_0);

	assign arbitration[0] = grant[0]& (~grant[4] | ~prio4_0) & (~grant[3] | ~prio3_0) &(~grant[2] | ~prio2_0)& (~grant[1] | ~prio1_0);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
		//initial priority is 43210;
			prio4_3		<=	1;
			prio4_2		<=	1;
			prio4_1		<=	1;
			prio4_0		<=	1;

			prio3_2		<=	1;
			prio3_1		<=	1;
			prio3_0		<=	1;

			prio2_1		<=	1;
			prio2_0		<=	1;

			prio1_0		<=	1;
		end
		else begin
			case(arbitration)
				5'b10000:begin
					prio4_3		<=	0;
					prio4_2		<=	0;
					prio4_1		<=	0;
					prio4_0		<=	0;

					prio3_2		<=	prio3_2;
					prio3_1		<=	prio3_1;
					prio3_0		<=	prio3_0;

					prio2_1		<=	prio2_1;
					prio2_0		<=	prio2_0;

					prio1_0		<=	prio1_0;
				end

				5'b01000:begin
					prio4_3		<=	1;
					prio4_2		<=	prio4_2;
					prio4_1		<=	prio4_1;
					prio4_0		<=	prio4_0;

					prio3_2		<=	0;
					prio3_1		<=	0;
					prio3_0		<=	0;

					prio2_1		<=	prio2_1;
					prio2_0		<=	prio2_0;

					prio1_0		<=	prio1_0;
				end

				5'b00100:begin
					prio4_3		<=	prio4_3;
					prio4_2		<=	1;
					prio4_1		<=	prio4_1;
					prio4_0		<=	prio4_0;

					prio3_2		<=	1;
					prio3_1		<=	prio3_1;
					prio3_0		<=	prio3_0;

					prio2_1		<=	0;
					prio2_0		<=	0;

					prio1_0		<=	prio1_0;
				end

				5'b00010:begin
					prio4_3		<=	prio4_3;
					prio4_2		<=	prio4_2;
					prio4_1		<=	1;
					prio4_0		<=	prio4_0;

					prio3_2		<=	prio3_2;
					prio3_1		<=	1;
					prio3_0		<=	prio3_0;

					prio2_1		<=	1;
					prio2_0		<=	prio2_0;

					prio1_0		<=	0;
				end

				5'b00001:begin
					prio4_3		<=	prio4_3;
					prio4_2		<=	prio4_2;
					prio4_1		<=	prio4_1;
					prio4_0		<=	1;

					prio3_2		<=	prio3_2;
					prio3_1		<=	prio3_1;
					prio3_0		<=	1;

					prio2_1		<=	prio2_1;
					prio2_0		<=	1;

					prio1_0		<=	1;
				end

				default: begin
					prio4_3		<=	prio4_3;
					prio4_2		<=	prio4_2;
					prio4_1		<=	prio4_1;
					prio4_0		<=	prio4_0;

					prio3_2		<=	prio3_2;
					prio3_1		<=	prio3_1;
					prio3_0		<=	prio3_0;

					prio2_1		<=	prio2_1;
					prio2_0		<=	prio2_0;

					prio1_0		<=	prio1_0;
				end
			endcase
		end
	end

endmodule


