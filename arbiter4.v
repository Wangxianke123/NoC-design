module arbiter4(
	input	wire		clk,
	input	wire		rst_n,
	input	wire[3:0]	grant,
	output	wire[3:0]	arbitration
	);


	reg	prio3_2;	reg	prio3_1;	reg	prio3_0;
	reg	prio2_1;	reg	prio2_0;
	reg	prio1_0;




	assign arbitration[3] = grant[3]& (~grant[2] | prio3_2) &(~grant[1] | prio3_1)& (~grant[0] | prio3_0);

	assign arbitration[2] = grant[2]& (~grant[3] | ~prio3_2) &(~grant[1] | prio2_1)& (~grant[0] | prio2_0);

	assign arbitration[1] = grant[1]& (~grant[3] | ~prio3_1) &(~grant[2] | ~prio2_1)& (~grant[0] | prio1_0);

	assign arbitration[0] = grant[0]& (~grant[3] | ~prio3_0) &(~grant[2] | ~prio2_0)& (~grant[1] | ~prio1_0);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
		//initial priority is 43210;

			prio3_2		<=	1;
			prio3_1		<=	1;
			prio3_0		<=	1;

			prio2_1		<=	1;
			prio2_0		<=	1;

			prio1_0		<=	1;
		end
		else begin
			case(arbitration)
				4'b1000:begin
					prio3_2		<=	0;
					prio3_1		<=	0;
					prio3_0		<=	0;

					prio2_1		<=	prio2_1;
					prio2_0		<=	prio2_0;

					prio1_0		<=	prio1_0;
				end

				4'b0100:begin
					
					prio3_2		<=	1;
					prio3_1		<=	prio3_1;
					prio3_0		<=	prio3_0;

					prio2_1		<=	0;
					prio2_0		<=	0;

					prio1_0		<=	prio1_0;
				end

				4'b0010:begin

					prio3_2		<=	prio3_2;
					prio3_1		<=	1;
					prio3_0		<=	prio3_0;

					prio2_1		<=	1;
					prio2_0		<=	prio2_0;

					prio1_0		<=	0;
				end

				4'b0001:begin
					prio3_2		<=	prio3_2;
					prio3_1		<=	prio3_1;
					prio3_0		<=	1;

					prio2_1		<=	prio2_1;
					prio2_0		<=	1;

					prio1_0		<=	1;
				end

				default: begin
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


