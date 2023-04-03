`define DATA_SIZE 20
`define DATA_SIZE_0 19
`define TIME_SIZE 10
`define TIME_SIZE_0 9
`define TIME_SUM_SIZE 24
`define TIME_SUM_SIZE_0 23
`define ID_SIZE 4
`define ID_SIZE_0 3
`define TYPE_SIZE 2
`define TOTAL_SIZE 40

`define LOG_ROUTER_NUM 4
`define LOG_ROUTER_NUM_0 3

`define ROUTER_NUM 9
`define ROUTER_NUM_0 7

`define DST_MIN 32
`define DST_MAX 35
`define SRC_MIN 36
`define SRC_MAX 39
`define TYPE_MIN 0
`define TYPE_MAX 1
`define TIME_MIN 22
`define TIME_MAX 31
`define DATA_MIN 2
`define DATA_MAX 21

`define DATA_WIDTH_NOR 16 //正常数据包有效data width20; debug 8
`define DATA_WIDTH_DBG 8


//tornado模式的testbench
module noc_top_tb2();

    reg          enable;
    reg          dbg_mode;


    reg[3:0]     send_num_00;
    reg[3:0]     send_num_01;
    reg[3:0]     send_num_02;
    reg[3:0]     send_num_10;
    reg[3:0]     send_num_11;
    reg[3:0]     send_num_12;
    reg[3:0]     send_num_20;
    reg[3:0]     send_num_21;
    reg[3:0]     send_num_22;


    reg[3:0]     receive_num_00;
    reg[3:0]     receive_num_01;
    reg[3:0]     receive_num_02;
    reg[3:0]     receive_num_10;
    reg[3:0]     receive_num_11;
    reg[3:0]     receive_num_12;
    reg[3:0]     receive_num_20;
    reg[3:0]     receive_num_21;
    reg[3:0]     receive_num_22;

    reg[3:0]     rate;


    reg[35:0]    dst_seq_00;
    reg[35:0]    dst_seq_01;
    reg[35:0]    dst_seq_02;
    reg[35:0]    dst_seq_10;
    reg[35:0]    dst_seq_11;
    reg[35:0]    dst_seq_12;
    reg[35:0]    dst_seq_20;
    reg[35:0]    dst_seq_21;
    reg[35:0]    dst_seq_22;


    reg[3:0]     mode;
    reg          flush; 

    wire          task_send_finish_flag_00;
    wire          task_send_finish_flag_01;
    wire          task_send_finish_flag_02;
    wire          task_send_finish_flag_10;
    wire          task_send_finish_flag_11;
    wire          task_send_finish_flag_12;
    wire          task_send_finish_flag_20;
    wire          task_send_finish_flag_21;
    wire          task_send_finish_flag_22;


    wire          task_receive_finish_flag_00;
    wire          task_receive_finish_flag_01;
    wire          task_receive_finish_flag_02;
    wire          task_receive_finish_flag_10;
    wire          task_receive_finish_flag_11;
    wire          task_receive_finish_flag_12;
    wire          task_receive_finish_flag_20;
    wire          task_receive_finish_flag_21;
    wire          task_receive_finish_flag_22;

    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_00;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_01;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_02;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_10;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_11;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_12;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_20;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_21;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_send_flag_22;

    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_00;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_01;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_02;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_10;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_11;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_12;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_20;
    wire[`ROUTER_NUM_0:0]          so_retrsreq_receive_flag_21;
    wire[`ROUTER_NUM_0:0]         so_retrsreq_receive_flag_22;

    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_00;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_01;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_02;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_10;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_11;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_12;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_20;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_21;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_num_22;



    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_00;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_01;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_02;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_10;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_11;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_12;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_20;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_21;
    wire[`ROUTER_NUM_0:0]   so_retrsreq_send_num_22;
   


    wire[`TIME_SIZE_0:0]    latency_min_00;
    wire[`TIME_SIZE_0:0]    latency_min_01;
    wire[`TIME_SIZE_0:0]    latency_min_02;
    wire[`TIME_SIZE_0:0]    latency_min_10;
    wire[`TIME_SIZE_0:0]    latency_min_11;
    wire[`TIME_SIZE_0:0]    latency_min_12;
    wire[`TIME_SIZE_0:0]    latency_min_20;
    wire[`TIME_SIZE_0:0]    latency_min_21;
    wire[`TIME_SIZE_0:0]    latency_min_22;




    wire[`TIME_SIZE_0:0]    latency_max_00;
    wire[`TIME_SIZE_0:0]    latency_max_01;
    wire[`TIME_SIZE_0:0]    latency_max_02;
    wire[`TIME_SIZE_0:0]    latency_max_10;
    wire[`TIME_SIZE_0:0]    latency_max_11;
    wire[`TIME_SIZE_0:0]    latency_max_12;
    wire[`TIME_SIZE_0:0]    latency_max_20;
    wire[`TIME_SIZE_0:0]    latency_max_21;
    wire[`TIME_SIZE_0:0]    latency_max_22;

    

    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_00;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_01;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_02;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_10;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_11;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_12;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_20;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_21;
    wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_22;
   

    reg                  rst_n;
    reg                  clk;

//tornado模式的testbench
 noc_top noc_top_tb2(

  	.enable(enable),
    .dbg_mode(1'b0),


    .send_num_00(4'b0001),
    .send_num_01(4'b0001),
    .send_num_02(4'b0001),
    .send_num_10(4'b0001),
    .send_num_11(4'b0001),
    .send_num_12(4'b0001),
    .send_num_20(4'b0001),
    .send_num_21(4'b0001),
    .send_num_22(4'b0001),


    .receive_num_00(4'b0001),
    .receive_num_01(4'b0001),
    .receive_num_02(4'b0001),
    .receive_num_10(4'b0001),
    .receive_num_11(4'b0001),
    .receive_num_12(4'b0001),
    .receive_num_20(4'b0001),
    .receive_num_21(4'b0001),
    .receive_num_22(4'b0001),

    .rate_00(4'b0000),
    .rate_01(4'b0000),
    .rate_02(4'b0000),
    .rate_10(4'b0000),
    .rate_11(4'b0000),
    .rate_12(4'b0000),
    .rate_20(4'b0000),
    .rate_21(4'b0000),
    .rate_22(4'b0000),


    .dst_seq_00(36'h01234578_6),
    .dst_seq_01(36'h01345679_8),
    .dst_seq_02(36'h01234578_9),
    .dst_seq_10(36'h12345678_a),
    .dst_seq_11(36'h98764321_0),
    .dst_seq_12(36'h12345678_1),
    .dst_seq_20(36'h02356789_2),
    .dst_seq_21(36'h01345678_4),
    .dst_seq_22(36'h12356789_5),


    .mode_00(4'b0001),
    .mode_01(4'b0001),
    .mode_02(4'b0001),
    .mode_10(4'b0001),
    .mode_11(4'b0001),
    .mode_12(4'b0001),
    .mode_20(4'b0001),
    .mode_21(4'b0001),
    .mode_22(4'b0001),

    .flush(1'b0),	


    .task_send_finish_flag_00(task_send_finish_flag_00),
    .task_send_finish_flag_01(task_send_finish_flag_01),
    .task_send_finish_flag_02(task_send_finish_flag_02),
    .task_send_finish_flag_10(task_send_finish_flag_10),
    .task_send_finish_flag_11(task_send_finish_flag_11),
    .task_send_finish_flag_12(task_send_finish_flag_12),
    .task_send_finish_flag_20(task_send_finish_flag_20),
    .task_send_finish_flag_21(task_send_finish_flag_21),
    .task_send_finish_flag_22(task_send_finish_flag_22),


    .task_receive_finish_flag_00(task_receive_finish_flag_00),
    .task_receive_finish_flag_01(task_receive_finish_flag_01),
    .task_receive_finish_flag_02(task_receive_finish_flag_02),
    .task_receive_finish_flag_10(task_receive_finish_flag_10),
    .task_receive_finish_flag_11(task_receive_finish_flag_11),
    .task_receive_finish_flag_12(task_receive_finish_flag_12),
    .task_receive_finish_flag_20(task_receive_finish_flag_20),
    .task_receive_finish_flag_21(task_receive_finish_flag_21),
    .task_receive_finish_flag_22(task_receive_finish_flag_22),

    .so_retrsreq_send_flag_00(so_retrsreq_send_flag_00),
    .so_retrsreq_send_flag_01(so_retrsreq_send_flag_01),
    .so_retrsreq_send_flag_02(so_retrsreq_send_flag_02),
    .so_retrsreq_send_flag_10(so_retrsreq_send_flag_10),
    .so_retrsreq_send_flag_11(so_retrsreq_send_flag_11),
    .so_retrsreq_send_flag_12(so_retrsreq_send_flag_12),
    .so_retrsreq_send_flag_20(so_retrsreq_send_flag_20),
    .so_retrsreq_send_flag_21(so_retrsreq_send_flag_21),
    .so_retrsreq_send_flag_22(so_retrsreq_send_flag_22),

    .so_retrsreq_receive_flag_00(so_retrsreq_receive_flag_00),
    .so_retrsreq_receive_flag_01(so_retrsreq_receive_flag_01),
    .so_retrsreq_receive_flag_02(so_retrsreq_receive_flag_02),
    .so_retrsreq_receive_flag_10(so_retrsreq_receive_flag_10),
    .so_retrsreq_receive_flag_11(so_retrsreq_receive_flag_11),
    .so_retrsreq_receive_flag_12(so_retrsreq_receive_flag_12),
    .so_retrsreq_receive_flag_20(so_retrsreq_receive_flag_20),
    .so_retrsreq_receive_flag_21(so_retrsreq_receive_flag_21),
    .so_retrsreq_receive_flag_22(so_retrsreq_receive_flag_22),


    .so_retrsreq_receive_num_00(so_retrsreq_receive_num_00),
    .so_retrsreq_receive_num_01(so_retrsreq_receive_num_01),
    .so_retrsreq_receive_num_02(so_retrsreq_receive_num_02),
    .so_retrsreq_receive_num_10(so_retrsreq_receive_num_10),
    .so_retrsreq_receive_num_11(so_retrsreq_receive_num_11),
    .so_retrsreq_receive_num_12(so_retrsreq_receive_num_12),
    .so_retrsreq_receive_num_20(so_retrsreq_receive_num_20),
    .so_retrsreq_receive_num_21(so_retrsreq_receive_num_21),
    .so_retrsreq_receive_num_22(so_retrsreq_receive_num_22),
   

    .so_retrsreq_send_num_00(so_retrsreq_send_num_00),
    .so_retrsreq_send_num_01(so_retrsreq_send_num_01),
    .so_retrsreq_send_num_02(so_retrsreq_send_num_02),
    .so_retrsreq_send_num_10(so_retrsreq_send_num_10),
    .so_retrsreq_send_num_11(so_retrsreq_send_num_11),
    .so_retrsreq_send_num_12(so_retrsreq_send_num_12),
    .so_retrsreq_send_num_20(so_retrsreq_send_num_20),
    .so_retrsreq_send_num_21(so_retrsreq_send_num_21),
    .so_retrsreq_send_num_22(so_retrsreq_send_num_22),
    
   
    .latency_min_00(latency_min_00),
    .latency_min_01(latency_min_01),
    .latency_min_02(latency_min_02),
    .latency_min_10(latency_min_10),
    .latency_min_11(latency_min_11),
    .latency_min_12(latency_min_12),
    .latency_min_20(latency_min_20),
    .latency_min_21(latency_min_21),
    .latency_min_22(latency_min_22),
    
    

    .latency_max_00(latency_max_00),
    .latency_max_01(latency_max_01),
    .latency_max_02(latency_max_02),
    .latency_max_10(latency_max_10),
    .latency_max_11(latency_max_11),
    .latency_max_12(latency_max_12),
    .latency_max_20(latency_max_20),
    .latency_max_21(latency_max_21),
    .latency_max_22(latency_max_22),
    

    .latency_sum_00(latency_sum_00),
    .latency_sum_01(latency_sum_01),
    .latency_sum_02(latency_sum_02),
    .latency_sum_10(latency_sum_10),
    .latency_sum_11(latency_sum_11),
    .latency_sum_12(latency_sum_12),
    .latency_sum_20(latency_sum_20),
    .latency_sum_21(latency_sum_21),
    .latency_sum_22(latency_sum_22),

    .rst_n(rst_n),
    .clk(clk)
  );

initial begin
    clk = 1'b0;
    forever #50 clk = ~clk;
end


initial begin
            rst_n = 1'b0;
    #300    rst_n = 1'b1;
end


initial begin
            enable = 1'b0;
    #400    enable = 1'b1;
end






endmodule