module arbiter8(
	input	wire		clk,
	input	wire		rst_n,
	input	wire[7:0]	grant1,
	input	wire[7:0]	grant2,
	output	wire[7:0]	arbitration
	);

	
	reg	prio7_6;	reg	prio7_5;	reg	prio7_4;	reg	prio7_3;	reg	prio7_2;	reg	prio7_1;	reg	prio7_0;
	reg	prio6_5;	reg	prio6_4;	reg	prio6_3;	reg	prio6_2;	reg	prio6_1;	reg	prio6_0;
	reg	prio5_4;	reg	prio5_3;	reg	prio5_2;	reg	prio5_1;	reg	prio5_0;
	reg	prio4_3;	reg	prio4_2;	reg	prio4_1;	reg	prio4_0;
	reg	prio3_2;	reg	prio3_1;	reg	prio3_0;
	reg	prio2_1;	reg	prio2_0;
	reg	prio1_0;

	wire 	grant1_valid;
	assign 	grant1_valid = grant1[7]|grant1[6]|grant1[5]|grant1[4]|grant1[3]|grant1[2]|grant1[1]|grant1[0];


	assign arbitration[7] = (grant1_valid)? grant1[7]: grant2[7]& (~grant2[6] | prio7_6) & (~grant2[5] | prio7_5) &(~grant2[4] | prio7_4)& (~grant2[3] | prio7_3)& (~grant2[2] | prio7_2)& (~grant2[1] | prio7_1)& (~grant2[0] | prio7_0);

	assign arbitration[6] =(grant1_valid)? grant1[6]: grant2[6]& (~grant2[7] | ~prio7_6) & (~grant2[5] | prio6_5) &(~grant2[4] | prio6_4)& (~grant2[3] | prio6_3)& (~grant2[2] | prio6_2)& (~grant2[1] | prio6_1)& (~grant2[0] | prio6_0);

	assign arbitration[5] = (grant1_valid)? grant1[5]:grant2[5]& (~grant2[7] | ~prio7_5) & (~grant2[6] | ~prio6_5) &(~grant2[4] | prio5_4)& (~grant2[3] | prio5_3)& (~grant2[2] | prio5_2)& (~grant2[1] | prio5_1)& (~grant2[0] | prio5_0);

	assign arbitration[4] = (grant1_valid)? grant1[4]:grant2[4]& (~grant2[7] | ~prio7_4) & (~grant2[6] | ~prio6_4) &(~grant2[5] | ~prio5_4)& (~grant2[3] | prio4_3)& (~grant2[2] | prio4_2)& (~grant2[1] | prio4_1)& (~grant2[0] | prio4_0);

	assign arbitration[3] =(grant1_valid)? grant1[3]: grant2[3]& (~grant2[7] | ~prio7_3) & (~grant2[6] | ~prio6_3) &(~grant2[5] | ~prio5_3)& (~grant2[4] | ~prio4_3)& (~grant2[2] | prio3_2)& (~grant2[1] | prio3_1)& (~grant2[0] | prio3_0);

	assign arbitration[2] = (grant1_valid)? grant1[2]:grant2[2]& (~grant2[7] | ~prio7_2) & (~grant2[6] | ~prio6_2) &(~grant2[5] | ~prio5_2)& (~grant2[4] | ~prio4_2)& (~grant2[3] | ~prio3_2)& (~grant2[1] | prio2_1)& (~grant2[0] | prio2_0);

	assign arbitration[1] = (grant1_valid)? grant1[1]:grant2[1]& (~grant2[7] | ~prio7_1) & (~grant2[6] | ~prio6_1) &(~grant2[5] | ~prio5_1)& (~grant2[4] | ~prio4_1)& (~grant2[3] | ~prio3_1)& (~grant2[2] | ~prio2_1)& (~grant2[0] | prio1_0);

	assign arbitration[0] = (grant1_valid)? grant1[0]:grant2[0]& (~grant2[7] | ~prio7_0) & (~grant2[6] | ~prio6_0) &(~grant2[5] | ~prio5_0)& (~grant2[4] | ~prio4_0)& (~grant2[3] | ~prio3_0)& (~grant2[2] | ~prio2_0)& (~grant2[1] | ~prio1_0);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
		
			prio7_6<=	1;
			prio7_5<=	1;
			prio7_4<=	1;
			prio7_3<=	1;
			prio7_2<=	1;
			prio7_1<=	1;
			prio7_0<=	1;

			prio6_5<=	1;
			prio6_4<=	1;
			prio6_3<=	1;
			prio6_2<=	1;
			prio6_1<=	1;
			prio6_0<=	1;

			prio5_4<=	1;
			prio5_3<=	1;
			prio5_2<=	1;
			prio5_1<=	1;
			prio5_0<=	1;

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
				8'b1000_0000:begin
					prio7_6<=	0;
					prio7_5<=	0;
					prio7_4<=	0;
					prio7_3<=	0;
					prio7_2<=	0;
					prio7_1<=	0;
					prio7_0<=	0;

					prio6_5<=	prio6_5;
					prio6_4<=	prio6_4;
					prio6_3<=	prio6_3;
					prio6_2<=	prio6_2;
					prio6_1<=	prio6_1;
					prio6_0<=	prio6_0;

					prio5_4<=	prio5_4;
					prio5_3<=	prio5_3;
					prio5_2<=	prio5_2;
					prio5_1<=	prio5_1;
					prio5_0<=	prio5_0;

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

				8'b0100_0000:begin
					prio7_6<=	1;
					prio7_5<=	prio7_5;
					prio7_4<=	prio7_4;
					prio7_3<=	prio7_3;
					prio7_2<=	prio7_2;
					prio7_1<=	prio7_1;
					prio7_0<=	prio7_0;

					prio6_5<=	0;
					prio6_4<=	0;
					prio6_3<=	0;
					prio6_2<=	0;
					prio6_1<=	0;
					prio6_0<=	0;

					prio5_4<=	prio5_4;
					prio5_3<=	prio5_3;
					prio5_2<=	prio5_2;
					prio5_1<=	prio5_1;
					prio5_0<=	prio5_0;

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

				8'b0010_0000:begin
					prio7_6<=	prio7_6;
					prio7_5<=	1;
					prio7_4<=	prio7_4;
					prio7_3<=	prio7_3;
					prio7_2<=	prio7_2;
					prio7_1<=	prio7_1;
					prio7_0<=	prio7_0;

					prio6_5<=	1;
					prio6_4<=	prio6_4;
					prio6_3<=	prio6_3;
					prio6_2<=	prio6_2;
					prio6_1<=	prio6_1;
					prio6_0<=	prio6_0;

					prio5_4<=	0;
					prio5_3<=	0;
					prio5_2<=	0;
					prio5_1<=	0;
					prio5_0<=	0;

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
				8'b0001_0000:begin
					prio7_6<=	prio7_6;
					prio7_5<=	prio7_5;
					prio7_4<=	1;
					prio7_3<=	prio7_3;
					prio7_2<=	prio7_2;
					prio7_1<=	prio7_1;
					prio7_0<=	prio7_0;

					prio6_5<=	prio6_5;
					prio6_4<=	1;
					prio6_3<=	prio6_3;
					prio6_2<=	prio6_2;
					prio6_1<=	prio6_1;
					prio6_0<=	prio6_0;

					prio5_4<=	1;
					prio5_3<=	prio5_3;
					prio5_2<=	prio5_2;
					prio5_1<=	prio5_1;
					prio5_0<=	prio5_0;

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

				8'b0000_1000:begin
					prio7_6<=	prio7_6;
					prio7_5<=	prio7_5;
					prio7_4<=	prio7_4;
					prio7_3<=	1;
					prio7_2<=	prio7_2;
					prio7_1<=	prio7_1;
					prio7_0<=	prio7_0;

					prio6_5<=	prio6_5;
					prio6_4<=	prio6_4;
					prio6_3<=	1;
					prio6_2<=	prio6_2;
					prio6_1<=	prio6_1;
					prio6_0<=	prio6_0;

					prio5_4<=	prio5_4;
					prio5_3<=	1;
					prio5_2<=	prio5_2;
					prio5_1<=	prio5_1;
					prio5_0<=	prio5_0;

					prio4_3		<=	prio4_3;
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

				8'b0000_0100:begin
					prio7_6<=	prio7_6;
					prio7_5<=	prio7_5;
					prio7_4<=	prio7_4;
					prio7_3<=	prio7_3;
					prio7_2<=	1;
					prio7_1<=	prio7_1;
					prio7_0<=	prio7_0;

					prio6_5<=	prio6_5;
					prio6_4<=	prio6_4;
					prio6_3<=	prio6_3;
					prio6_2<=	1;
					prio6_1<=	prio6_1;
					prio6_0<=	prio6_0;

					prio5_4<=	prio5_4;
					prio5_3<=	prio5_3;
					prio5_2<=	1;
					prio5_1<=	prio5_1;
					prio5_0<=	prio5_0;

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

				8'b0000_0010:begin
					prio7_6<=	prio7_6;
					prio7_5<=	prio7_5;
					prio7_4<=	prio7_4;
					prio7_3<=	prio7_3;
					prio7_2<=	prio7_2;
					prio7_1<=	1;
					prio7_0<=	prio7_0;

					prio6_5<=	prio6_5;
					prio6_4<=	prio6_4;
					prio6_3<=	prio6_3;
					prio6_2<=	prio6_2;
					prio6_1<=	1;
					prio6_0<=	prio6_0;

					prio5_4<=	prio5_4;
					prio5_3<=	prio5_3;
					prio5_2<=	prio5_2;
					prio5_1<=	1;
					prio5_0<=	prio5_0;

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

				8'b0000_0010:begin
					prio7_6<=	prio7_6;
					prio7_5<=	prio7_5;
					prio7_4<=	prio7_4;
					prio7_3<=	prio7_3;
					prio7_2<=	prio7_2;
					prio7_1<=	prio7_1;
					prio7_0<=	1;

					prio6_5<=	prio6_5;
					prio6_4<=	prio6_4;
					prio6_3<=	prio6_3;
					prio6_2<=	prio6_2;
					prio6_1<=	prio6_1;
					prio6_0<=	1;

					prio5_4<=	prio5_4;
					prio5_3<=	prio5_3;
					prio5_2<=	prio5_2;
					prio5_1<=	prio5_1;
					prio5_0<=	1;

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

				default:begin
			prio7_6<=	1;
			prio7_5<=	1;
			prio7_4<=	1;
			prio7_3<=	1;
			prio7_2<=	1;
			prio7_1<=	1;
			prio7_0<=	1;

			prio6_5<=	1;
			prio6_4<=	1;
			prio6_3<=	1;
			prio6_2<=	1;
			prio6_1<=	1;
			prio6_0<=	1;

			prio5_4<=	1;
			prio5_3<=	1;
			prio5_2<=	1;
			prio5_1<=	1;
			prio5_0<=	1;

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
			endcase
		end
	end

endmodule


