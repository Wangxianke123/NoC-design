module arbiter3(
	input	wire		clk,
	input	wire		rst_n,
	input	wire[2:0]	grant,
	output	wire[2:0]	arbitration
	);


	reg	prio2_1;	reg	prio2_0;
	reg	prio1_0;





	assign arbitration[2] = grant[2]&(~grant[1] | prio2_1)& (~grant[0] | prio2_0);

	assign arbitration[1] = grant[1]& (~grant[2] | ~prio2_1)& (~grant[0] | prio1_0);

	assign arbitration[0] = grant[0]& (~grant[2] | ~prio2_0)& (~grant[1] | ~prio1_0);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
		//initial priority is 43210;
			prio2_1		<=	1;
			prio2_0		<=	1;
			prio1_0		<=	1;
		end
		else begin
			case(arbitration)

				3'b100:begin					
					prio2_1		<=	0;
					prio2_0		<=	0;
					prio1_0		<=	prio1_0;
				end

				3'b010:begin
					prio2_1		<=	1;
					prio2_0		<=	prio2_0;
					prio1_0		<=	0;
				end

				3'b001:begin

					prio2_1		<=	prio2_1;
					prio2_0		<=	1;
					prio1_0		<=	1;
				end

				default: begin
					prio2_1		<=	prio2_1;
					prio2_0		<=	prio2_0;
					prio1_0		<=	prio1_0;
				end
			endcase
		end
	end

endmodule


