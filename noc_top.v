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
`define ROUTER_NUM 9
`define ROUTER_NUM_0 7

`define LOG_ROUTER_NUM 4
`define LOG_ROUTER_NUM_0 3

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

`define DATA_WIDTH_NOR 16 //正常数据包有效data width20, debug 8
`define DATA_WIDTH_DBG 8


module noc_top#(
  parameter DEPTH=4,
  parameter WIDTH=2,
  parameter DATASIZE=40  //src:4bit, dst:4bit, timestamp:8bit, data:22bit, type:2bit
  )(

  	input wire          enable,
    input wire          dbg_mode,
    input wire          flush,  

    input wire[3:0]     send_num_00,
    input wire[3:0]     send_num_01,
    input wire[3:0]     send_num_02,
    input wire[3:0]     send_num_10,
    input wire[3:0]     send_num_11,
    input wire[3:0]     send_num_12,
    input wire[3:0]     send_num_20,
    input wire[3:0]     send_num_21,
    input wire[3:0]     send_num_22,


    input wire[3:0]     receive_num_00,
    input wire[3:0]     receive_num_01,
    input wire[3:0]     receive_num_02,
    input wire[3:0]     receive_num_10,
    input wire[3:0]     receive_num_11,
    input wire[3:0]     receive_num_12,
    input wire[3:0]     receive_num_20,
    input wire[3:0]     receive_num_21,
    input wire[3:0]     receive_num_22,

    input wire[3:0]     rate_00,
    input wire[3:0]     rate_01,
    input wire[3:0]     rate_02,
    input wire[3:0]     rate_10,
    input wire[3:0]     rate_11,
    input wire[3:0]     rate_12,
    input wire[3:0]     rate_20,
    input wire[3:0]     rate_21,
    input wire[3:0]     rate_22,
    


    input wire[35:0]    dst_seq_00,
    input wire[35:0]    dst_seq_01,
    input wire[35:0]    dst_seq_02,
    input wire[35:0]    dst_seq_10,
    input wire[35:0]    dst_seq_11,
    input wire[35:0]    dst_seq_12,
    input wire[35:0]    dst_seq_20,
    input wire[35:0]    dst_seq_21,
    input wire[35:0]    dst_seq_22,


    input wire[3:0]     mode_00,
    input wire[3:0]     mode_01,
    input wire[3:0]     mode_02,
    input wire[3:0]     mode_10,
    input wire[3:0]     mode_11,
    input wire[3:0]     mode_12,
    input wire[3:0]     mode_20,
    input wire[3:0]     mode_21,
    input wire[3:0]     mode_22,
    


    output wire          task_send_finish_flag_00,
    output wire          task_send_finish_flag_01,
    output wire          task_send_finish_flag_02,
    output wire          task_send_finish_flag_10,
    output wire          task_send_finish_flag_11,
    output wire          task_send_finish_flag_12,
    output wire          task_send_finish_flag_20,
    output wire          task_send_finish_flag_21,
    output wire          task_send_finish_flag_22,


    output wire          task_receive_finish_flag_00,
    output wire          task_receive_finish_flag_01,
    output wire          task_receive_finish_flag_02,
    output wire          task_receive_finish_flag_10,
    output wire          task_receive_finish_flag_11,
    output wire          task_receive_finish_flag_12,
    output wire          task_receive_finish_flag_20,
    output wire          task_receive_finish_flag_21,
    output wire          task_receive_finish_flag_22,

    output wire[7:0]   so_retrsreq_receive_num_00,   
    output wire[7:0]   so_retrsreq_receive_num_01,  
    output wire[7:0]   so_retrsreq_receive_num_02,
    output wire[7:0]   so_retrsreq_receive_num_10,
    output wire[7:0]   so_retrsreq_receive_num_11,
    output wire[7:0]   so_retrsreq_receive_num_12,
    output wire[7:0]   so_retrsreq_receive_num_20,
    output wire[7:0]   so_retrsreq_receive_num_21,
    output wire[7:0]   so_retrsreq_receive_num_22,
    
    

    output wire[7:0]   so_retrsreq_send_num_00,
    output wire[7:0]   so_retrsreq_send_num_01,
    output wire[7:0]   so_retrsreq_send_num_02,
    output wire[7:0]   so_retrsreq_send_num_10,
    output wire[7:0]   so_retrsreq_send_num_11,
    output wire[7:0]   so_retrsreq_send_num_12,
    output wire[7:0]   so_retrsreq_send_num_20,
    output wire[7:0]   so_retrsreq_send_num_21,
    output wire[7:0]   so_retrsreq_send_num_22,

    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_00,   
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_01,  
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_02,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_10,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_11,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_12,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_20,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_21,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_receive_flag_22,
    
    

    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_00,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_01,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_02,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_10,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_11,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_12,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_20,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_21,
    output wire[`ROUTER_NUM_0:0]   so_retrsreq_send_flag_22,

    
    output wire[`TIME_SIZE_0:0]    latency_min_00,
    output wire[`TIME_SIZE_0:0]    latency_min_01,
    output wire[`TIME_SIZE_0:0]    latency_min_02,
    output wire[`TIME_SIZE_0:0]    latency_min_10,
    output wire[`TIME_SIZE_0:0]    latency_min_11,
    output wire[`TIME_SIZE_0:0]    latency_min_12,
    output wire[`TIME_SIZE_0:0]    latency_min_20,
    output wire[`TIME_SIZE_0:0]    latency_min_21,
    output wire[`TIME_SIZE_0:0]    latency_min_22,

    
    output wire[`TIME_SIZE_0:0]    latency_max_00,
    output wire[`TIME_SIZE_0:0]    latency_max_01,
    output wire[`TIME_SIZE_0:0]    latency_max_02,
    output wire[`TIME_SIZE_0:0]    latency_max_10,
    output wire[`TIME_SIZE_0:0]    latency_max_11,
    output wire[`TIME_SIZE_0:0]    latency_max_12,
    output wire[`TIME_SIZE_0:0]    latency_max_20,
    output wire[`TIME_SIZE_0:0]    latency_max_21,
    output wire[`TIME_SIZE_0:0]    latency_max_22,

    
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_00,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_01,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_02,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_10,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_11,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_12,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_20,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_21,
    output wire[`TIME_SUM_SIZE_0 + `LOG_ROUTER_NUM:0]   latency_sum_22,
    

    input wire                  rst_n,
    input wire                  clk
  );


    wire   [`SRC_MAX:0]     data_p2r_00;
    wire   [`SRC_MAX:0]     data_p2r_01;
    wire   [`SRC_MAX:0]     data_p2r_02;
    wire   [`SRC_MAX:0]     data_p2r_10;
    wire   [`SRC_MAX:0]     data_p2r_11;
    wire   [`SRC_MAX:0]     data_p2r_12;
    wire   [`SRC_MAX:0]     data_p2r_20;
    wire   [`SRC_MAX:0]     data_p2r_21;
    wire   [`SRC_MAX:0]     data_p2r_22;

    wire                    valid_p2r_00;
    wire                    valid_p2r_01;
    wire                    valid_p2r_02;
    wire                    valid_p2r_10;
    wire                    valid_p2r_11;
    wire                    valid_p2r_12;
    wire                    valid_p2r_20;
    wire                    valid_p2r_21;
    wire                    valid_p2r_22;


    wire[`SRC_MAX:0]     data_r2p_00;
    wire[`SRC_MAX:0]     data_r2p_01;
    wire[`SRC_MAX:0]     data_r2p_02;

    wire[`SRC_MAX:0]     data_r2p_10;
    wire[`SRC_MAX:0]     data_r2p_11;
    wire[`SRC_MAX:0]     data_r2p_12;

    wire[`SRC_MAX:0]     data_r2p_20;
    wire[`SRC_MAX:0]     data_r2p_21;
    wire[`SRC_MAX:0]     data_r2p_22;

    wire            valid_r2p_00;
    wire            valid_r2p_01;
    wire            valid_r2p_02;
    wire            valid_r2p_10;
    wire            valid_r2p_11;
    wire            valid_r2p_12;
    wire            valid_r2p_20;
    wire            valid_r2p_21;
    wire            valid_r2p_22;

    wire            full_00;
    wire            full_01;
    wire            full_02;
    wire            full_10;
    wire            full_11;
    wire            full_12;
    wire            full_20;
    wire            full_21;
    wire            full_22;

    wire[`SRC_MAX:0]     data_00_01;
    wire[`SRC_MAX:0]     data_00_10;

    wire[`SRC_MAX:0]     data_01_00;
    wire[`SRC_MAX:0]     data_01_02;
    wire[`SRC_MAX:0]     data_01_11;


    wire[`SRC_MAX:0]     data_02_01;
    wire[`SRC_MAX:0]     data_02_12;

    wire[`SRC_MAX:0]     data_10_00;
    wire[`SRC_MAX:0]     data_10_11;
    wire[`SRC_MAX:0]     data_10_20;

    wire[`SRC_MAX:0]     data_11_10;
    wire[`SRC_MAX:0]     data_11_01;
    wire[`SRC_MAX:0]     data_11_12;
    wire[`SRC_MAX:0]     data_11_21;

    wire[`SRC_MAX:0]     data_12_11;
    wire[`SRC_MAX:0]     data_12_02;
    wire[`SRC_MAX:0]     data_12_22;

    wire[`SRC_MAX:0]     data_20_21;
    wire[`SRC_MAX:0]     data_20_10;

    wire[`SRC_MAX:0]     data_21_11;
    wire[`SRC_MAX:0]     data_21_20;
    wire[`SRC_MAX:0]     data_21_22;

    wire[`SRC_MAX:0]     data_22_21;
    wire[`SRC_MAX:0]     data_22_12;



    wire     valid_00_01;
    wire     valid_00_10;

    wire     valid_01_00;
    wire     valid_01_02;
    wire     valid_01_11;


    wire     valid_02_01;
    wire     valid_02_12;

    wire     valid_10_00;
    wire     valid_10_11;
    wire     valid_10_20;

    wire     valid_11_10;
    wire     valid_11_01;
    wire     valid_11_12;
    wire     valid_11_21;

    wire     valid_12_11;
    wire     valid_12_02;
    wire     valid_12_22;

    wire     valid_20_21;
    wire     valid_20_10;

    wire     valid_21_11;
    wire     valid_21_20;
    wire     valid_21_22;

    wire     valid_22_21;
    wire     valid_22_12;



    wire     full_00_01;
    wire     full_00_10;

    wire     full_01_00;
    wire     full_01_02;
    wire     full_01_11;


    wire     full_02_01;
    wire     full_02_12;

    wire     full_10_00;
    wire     full_10_11;
    wire     full_10_20;

    wire     full_11_10;
    wire     full_11_01;
    wire     full_11_12;
    wire     full_11_21;

    wire     full_12_11;
    wire     full_12_02;
    wire     full_12_22;

    wire     full_20_21;
    wire     full_20_10;

    wire     full_21_11;
    wire     full_21_20;
    wire     full_21_22;

    wire     full_22_21;
    wire     full_22_12;


    wire[WIDTH:0]     pressure_00_01;
    wire[WIDTH:0]     pressure_00_10;

    wire[WIDTH:0]     pressure_01_00;
    wire[WIDTH:0]     pressure_01_02;
    wire[WIDTH:0]     pressure_01_11;


    wire[WIDTH:0]     pressure_02_01;
    wire[WIDTH:0]     pressure_02_12;

    wire[WIDTH:0]     pressure_10_00;
    wire[WIDTH:0]     pressure_10_11;
    wire[WIDTH:0]     pressure_10_20;

    wire[WIDTH:0]     pressure_11_10;
    wire[WIDTH:0]     pressure_11_01;
    wire[WIDTH:0]     pressure_11_12;
    wire[WIDTH:0]     pressure_11_21;

    wire[WIDTH:0]     pressure_12_11;
    wire[WIDTH:0]     pressure_12_02;
    wire[WIDTH:0]     pressure_12_22;

    wire[WIDTH:0]     pressure_20_21;
    wire[WIDTH:0]     pressure_20_10;

    wire[WIDTH:0]     pressure_21_11;
    wire[WIDTH:0]     pressure_21_20;
    wire[WIDTH:0]     pressure_21_22;

    wire[WIDTH:0]     pressure_22_21;
    wire[WIDTH:0]     pressure_22_12;

    wire[WIDTH:0]     pressure_out_L_00;
    wire[WIDTH:0]     pressure_out_L_01;
    wire[WIDTH:0]     pressure_out_L_02;
    wire[WIDTH:0]     pressure_out_L_10;
    wire[WIDTH:0]     pressure_out_L_11;
    wire[WIDTH:0]     pressure_out_L_12;
    wire[WIDTH:0]     pressure_out_L_20;
    wire[WIDTH:0]     pressure_out_L_21;
    wire[WIDTH:0]     pressure_out_L_22;



    wire   [`SRC_MAX:0]   data_s2p_00;
    wire   [`SRC_MAX:0]   data_s2p_01;
    wire   [`SRC_MAX:0]   data_s2p_02;
    wire   [`SRC_MAX:0]   data_s2p_10;
    wire   [`SRC_MAX:0]   data_s2p_11;
    wire   [`SRC_MAX:0]   data_s2p_12;
    wire   [`SRC_MAX:0]   data_s2p_20;
    wire   [`SRC_MAX:0]   data_s2p_21;
    wire   [`SRC_MAX:0]   data_s2p_22;

    wire   valid_s2p_00;
    wire   valid_s2p_01;
    wire   valid_s2p_02;
    wire   valid_s2p_10;
    wire   valid_s2p_11;
    wire   valid_s2p_12;
    wire   valid_s2p_20;
    wire   valid_s2p_21;
    wire   valid_s2p_22;

router00 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    )  router_00(
      .clk(clk),
      .rst_n(rst_n),
      .full(full_00),

      .L_data_in(data_p2r_00),
      .E_data_in(data_01_00),
      .S_data_in(data_10_00),



      .L_data_out(data_r2p_00),
      .E_data_out(data_00_01),
      .S_data_out(data_00_10),


      .L_valid_in(valid_p2r_00),  
      .E_valid_in(valid_01_00),
      .S_valid_in(valid_10_00),



      .L_valid_out(valid_r2p_00),
      .E_valid_out(valid_00_01),
      .S_valid_out(valid_00_10),


  
      .E_prussure_in(pressure_01_00),
      .S_prussure_in(pressure_10_00),


      .E_prussure_out(pressure_00_01),
      .S_prussure_out(pressure_00_10),
      .L_prussure_out(pressure_out_L_00),


     .E_full_in(full_01_00),
     .S_full_in(full_10_00),

     .E_full_out(full_00_01),
     .S_full_out(full_00_10)
    );


PE  #(
     .MY_ID  (4'b0000), 
     .ONE_ID (4'b0001),
     .TWO_ID (4'b0010),
     .THR_ID (4'b0100),
     .FOU_ID (4'b0101),
     .FIV_ID (4'b0110),
     .SIX_ID (4'b1000),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE00(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_00),
    .receive_num_wire(receive_num_00),

    .rate_wire(rate_00),

    .dst_seq_wire(dst_seq_00),
    .mode_wire(mode_00),
    .flush_wire(flush),


    .task_send_finish_flag(task_send_finish_flag_00),
    .task_receive_finish_flag(task_receive_finish_flag_00),
    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_00),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_00),
    .so_retrsreq_receive_num(so_retrsreq_receive_num_00),
    .so_retrsreq_send_num(so_retrsreq_send_num_00), 
    .latency_min(latency_min_00),
    .latency_max(latency_max_00),
    .latency_sum(latency_sum_00),

    .data_p2r(data_p2r_00),
    .valid_p2r(valid_p2r_00),
    .data_r2p(data_s2p_00),
    .valid_r2p(valid_s2p_00),
    .full(full_00),

    .rst_n(rst_n),
    .clk(clk)
        );


PE  #(
     .MY_ID  (4'b0001), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0010),
     .THR_ID (4'b0100),
     .FOU_ID (4'b0101),
     .FIV_ID (4'b0110),
     .SIX_ID (4'b1000),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE01(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_01),
    .receive_num_wire(receive_num_01),

    .rate_wire(rate_01),

    .dst_seq_wire(dst_seq_01),
    .mode_wire(mode_01),
    .flush_wire(flush),


    .task_send_finish_flag(task_send_finish_flag_01),
    .task_receive_finish_flag(task_receive_finish_flag_01),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_01),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_01),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_01),
    .so_retrsreq_send_num(so_retrsreq_send_num_01), 
    .latency_min(latency_min_01),
    .latency_max(latency_max_01),
    .latency_sum(latency_sum_01),

    .data_p2r(data_p2r_01),
    .valid_p2r(valid_p2r_01),
    .data_r2p(data_s2p_01),
    .valid_r2p(valid_s2p_01),
    .full(full_01),

    .rst_n(rst_n),
    .clk(clk)
        );


PE  #(
     .MY_ID  (4'b0010), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0100),
     .FOU_ID (4'b0101),
     .FIV_ID (4'b0110),
     .SIX_ID (4'b1000),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE02(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_02),
    .receive_num_wire(receive_num_02),

    .rate_wire(rate_02),

    .dst_seq_wire(dst_seq_02),
    .mode_wire(mode_02),
    .flush_wire(flush),

    .task_send_finish_flag(task_send_finish_flag_02),
    .task_receive_finish_flag(task_receive_finish_flag_02),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_02),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_02),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_02),
    .so_retrsreq_send_num(so_retrsreq_send_num_02), 
    .latency_min(latency_min_02),
    .latency_max(latency_max_02),
    .latency_sum(latency_sum_02),

    .data_p2r(data_p2r_02),
    .valid_p2r(valid_p2r_02),
    .data_r2p(data_s2p_02),
    .valid_r2p(valid_s2p_02),
    .full(full_02),

    .rst_n(rst_n),
    .clk(clk)
        );

PE  #(
     .MY_ID  (4'b0100), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0010),
     .FOU_ID (4'b0101),
     .FIV_ID (4'b0110),
     .SIX_ID (4'b1000),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE10(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_10),
    .receive_num_wire(receive_num_10),

    .rate_wire(rate_10),

    .dst_seq_wire(dst_seq_10),
    .mode_wire(mode_10),
    .flush_wire(flush),

    .task_send_finish_flag(task_send_finish_flag_10),
    .task_receive_finish_flag(task_receive_finish_flag_10),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_10),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_10),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_10),
    .so_retrsreq_send_num(so_retrsreq_send_num_10), 
    .latency_min(latency_min_10),
    .latency_max(latency_max_10),
    .latency_sum(latency_sum_10),

    .data_p2r(data_p2r_10),
    .valid_p2r(valid_p2r_10),
    .data_r2p(data_s2p_10),
    .valid_r2p(valid_s2p_10),
    .full(full_10),

    .rst_n(rst_n),
    .clk(clk)
        );

PE  #(
     .MY_ID  (4'b0101), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0010),
     .FOU_ID (4'b0100),
     .FIV_ID (4'b0110),
     .SIX_ID (4'b1000),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE11(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_11),
    .receive_num_wire(receive_num_11),

    .rate_wire(rate_11),

    .dst_seq_wire(dst_seq_11),
    .mode_wire(mode_11),
    .flush_wire(flush),


    .task_send_finish_flag(task_send_finish_flag_11),
    .task_receive_finish_flag(task_receive_finish_flag_11),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_11),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_11),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_11),
    .so_retrsreq_send_num(so_retrsreq_send_num_11), 
    .latency_min(latency_min_11),
    .latency_max(latency_max_11),
    .latency_sum(latency_sum_11),

    .data_p2r(data_p2r_11),
    .valid_p2r(valid_p2r_11),
    .data_r2p(data_s2p_11),
    .valid_r2p(valid_s2p_11),
    .full(full_11),

    .rst_n(rst_n),
    .clk(clk)
        );

PE  #(
     .MY_ID  (4'b0110), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0010),
     .FOU_ID (4'b0100),
     .FIV_ID (4'b0101),
     .SIX_ID (4'b1000),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE12(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_12),
    .receive_num_wire(receive_num_12),

    .rate_wire(rate_12),

    .dst_seq_wire(dst_seq_12),
    .mode_wire(mode_12),
    .flush_wire(flush),


    .task_send_finish_flag(task_send_finish_flag_12),
    .task_receive_finish_flag(task_receive_finish_flag_12),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_12),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_12),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_12),
    .so_retrsreq_send_num(so_retrsreq_send_num_12), 
    .latency_min(latency_min_12),
    .latency_max(latency_max_12),
    .latency_sum(latency_sum_12),

    .data_p2r(data_p2r_12),
    .valid_p2r(valid_p2r_12),
    .data_r2p(data_s2p_12),
    .valid_r2p(valid_s2p_12),
    .full(full_12),

    .rst_n(rst_n),
    .clk(clk)
        );


PE  #(
     .MY_ID  (4'b1000), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0010),
     .FOU_ID (4'b0100),
     .FIV_ID (4'b0101),
     .SIX_ID (4'b0110),
     .SEV_ID (4'b1001),
     .EIG_ID (4'b1010)
    ) PE20(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_20),
    .receive_num_wire(receive_num_20),

    .rate_wire(rate_20),

    .dst_seq_wire(dst_seq_20),
    .mode_wire(mode_20),
    .flush_wire(flush),

    .task_send_finish_flag(task_send_finish_flag_20),
    .task_receive_finish_flag(task_receive_finish_flag_20),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_20),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_20),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_20),
    .so_retrsreq_send_num(so_retrsreq_send_num_20), 
    .latency_min(latency_min_20),
    .latency_max(latency_max_20),
    .latency_sum(latency_sum_20),

    .data_p2r(data_p2r_20),
    .valid_p2r(valid_p2r_20),
    .data_r2p(data_s2p_20),
    .valid_r2p(valid_s2p_20),
    .full(full_20),

    .rst_n(rst_n),
    .clk(clk)
        );


PE  #(
     .MY_ID  (4'b1001), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0010),
     .FOU_ID (4'b0100),
     .FIV_ID (4'b0101),
     .SIX_ID (4'b0110),
     .SEV_ID (4'b1000),
     .EIG_ID (4'b1010)
    ) PE21(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_21),
    .receive_num_wire(receive_num_21),

    .rate_wire(rate_21),

    .dst_seq_wire(dst_seq_21),
    .mode_wire(mode_21),
    .flush_wire(flush),

    .task_send_finish_flag(task_send_finish_flag_21),
    .task_receive_finish_flag(task_receive_finish_flag_21),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_21),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_21),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_21),
    .so_retrsreq_send_num(so_retrsreq_send_num_21), 
    .latency_min(latency_min_21),
    .latency_max(latency_max_21),
    .latency_sum(latency_sum_21),

    .data_p2r(data_p2r_21),
    .valid_p2r(valid_p2r_21),
    .data_r2p(data_s2p_21),
    .valid_r2p(valid_s2p_21),
    .full(full_21),

    .rst_n(rst_n),
    .clk(clk)
        );


PE  #(
     .MY_ID  (4'b1010), 
     .ONE_ID (4'b0000),
     .TWO_ID (4'b0001),
     .THR_ID (4'b0010),
     .FOU_ID (4'b0100),
     .FIV_ID (4'b0101),
     .SIX_ID (4'b0110),
     .SEV_ID (4'b1000),
     .EIG_ID (4'b1001)
    ) PE22(
    .enable_wire(enable),
    .dbg_mode_wire(dbg_mode),

    .send_num_wire(send_num_22),
    .receive_num_wire(receive_num_22),

    .rate_wire(rate_22),

    .dst_seq_wire(dst_seq_22),
    .mode_wire(mode_22),
    .flush_wire(flush),

    .task_send_finish_flag(task_send_finish_flag_22),
    .task_receive_finish_flag(task_receive_finish_flag_22),

    .so_retrsreq_receive_flag(so_retrsreq_receive_flag_22),
    .so_retrsreq_send_flag(so_retrsreq_send_flag_22),

    .so_retrsreq_receive_num(so_retrsreq_receive_num_22),
    .so_retrsreq_send_num(so_retrsreq_send_num_22), 
    .latency_min(latency_min_22),
    .latency_max(latency_max_22),
    .latency_sum(latency_sum_22),

    .data_p2r(data_p2r_22),
    .valid_p2r(valid_p2r_22),
    .data_r2p(data_s2p_22),
    .valid_r2p(valid_s2p_22),
    .full(full_22),

    .rst_n(rst_n),
    .clk(clk)
        );



router02 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    )  router_02(
      .clk(clk),
      .rst_n(rst_n),
      .full(full_02),

      .L_data_in(data_p2r_02),
      .W_data_in(data_01_02),
      .S_data_in(data_12_02),



      .L_data_out(data_r2p_02),
      .W_data_out(data_02_01),
      .S_data_out(data_02_12),


      .L_valid_in(valid_p2r_02),  
      .W_valid_in(valid_01_02),
      .S_valid_in(valid_12_02),



      .L_valid_out(valid_r2p_02),
      .W_valid_out(valid_02_01),
      .S_valid_out(valid_02_12),


  
      .W_prussure_in(pressure_01_02),
      .S_prussure_in(pressure_12_02),


      .W_prussure_out(pressure_02_01),
      .S_prussure_out(pressure_02_12),
      .L_prussure_out(pressure_out_L_02),


     .W_full_in(full_01_02),
     .S_full_in(full_12_02),

     .W_full_out(full_02_01),
     .S_full_out(full_02_12)
    );


router20 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_20(
      .clk(clk),
      .rst_n(rst_n),
      .full(full_20),

      .L_data_in(data_p2r_20),
      .E_data_in(data_21_20),
      .N_data_in(data_10_20),



      .L_data_out(data_r2p_20),
      .E_data_out(data_20_21),
      .N_data_out(data_20_10),


      .L_valid_in(valid_p2r_20),  
      .E_valid_in(valid_21_20),
      .N_valid_in(valid_10_20),



      .L_valid_out(valid_r2p_20),
      .E_valid_out(valid_20_21),
      .N_valid_out(valid_20_10),


  
      .E_prussure_in(pressure_21_20),
      .N_prussure_in(pressure_10_20),


      .E_prussure_out(pressure_20_21),
      .N_prussure_out(pressure_20_10),
      .L_prussure_out(pressure_out_L_20),


     .E_full_in(full_21_20),
     .N_full_in(full_10_20),

     .E_full_out(full_20_21),
     .N_full_out(full_20_10)
    );



router22  #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_22(
      .clk(clk),
      .rst_n(rst_n),
      .full(full_22),

      .L_data_in(data_p2r_22),
      .W_data_in(data_21_22),
      .N_data_in(data_12_22),



      .L_data_out(data_r2p_22),
      .W_data_out(data_22_21),
      .N_data_out(data_22_12),


      .L_valid_in(valid_p2r_22),  
      .W_valid_in(valid_21_22),
      .N_valid_in(valid_12_22),



      .L_valid_out(valid_r2p_22),
      .W_valid_out(valid_22_21),
      .N_valid_out(valid_22_12),


  
      .W_prussure_in(pressure_21_22),
      .N_prussure_in(pressure_12_22),


      .W_prussure_out(pressure_22_21),
      .N_prussure_out(pressure_22_12),
      .L_prussure_out(pressure_out_L_22),


     .W_full_in(full_21_22),
     .N_full_in(full_12_22),

     .W_full_out(full_22_21),
     .N_full_out(full_22_12)
    );


router01 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_01(
  .clk(clk),
  .rst_n(rst_n),
  .full(full_01),

  .L_data_in(data_p2r_01),
  .W_data_in(data_00_01),
  .E_data_in(data_02_01),
  .S_data_in(data_11_01),



  .L_data_out(data_r2p_01),
  .W_data_out(data_01_00),

  .E_data_out(data_01_02),
  .S_data_out(data_01_11),


  .L_valid_in(valid_p2r_01),
  .W_valid_in(valid_00_01),
  .E_valid_in(valid_02_01),
  .S_valid_in(valid_11_01),



  .L_valid_out(valid_r2p_01),
  .W_valid_out(valid_01_00),
  .E_valid_out(valid_01_02),
  .S_valid_out(valid_01_11),


  .W_prussure_in(pressure_00_01),
  .E_prussure_in(pressure_02_01),
  .S_prussure_in(pressure_11_01),

  .W_prussure_out(pressure_01_00),
  .E_prussure_out(pressure_01_02),
  .S_prussure_out(pressure_01_11),
  .L_prussure_out(pressure_out_L_01),

  .W_full_in(full_00_01),
  .E_full_in(full_02_01),
  .S_full_in(full_11_01),

  .W_full_out(full_01_00),
  .E_full_out(full_01_02),
  .S_full_out(full_01_11)
);


router21 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_21(
  .clk(clk),
  .rst_n(rst_n),
  .full(full_21),

  .L_data_in(data_p2r_21),
  .W_data_in(data_20_21),
  .E_data_in(data_22_21),
  .N_data_in(data_11_21),



  .L_data_out(data_r2p_21),
  .W_data_out(data_21_20),

  .E_data_out(data_21_22),
  .N_data_out(data_21_11),


  .L_valid_in(valid_p2r_21),
  .W_valid_in(valid_20_21),
  .E_valid_in(valid_22_21),
  .N_valid_in(valid_11_21),



  .L_valid_out(valid_r2p_21),
  .W_valid_out(valid_21_20),
  .E_valid_out(valid_21_22),
  .N_valid_out(valid_21_11),


  .W_prussure_in(pressure_20_21),
  .E_prussure_in(pressure_22_21),
  .N_prussure_in(pressure_11_21),

  .W_prussure_out(pressure_21_20),
  .E_prussure_out(pressure_21_22),
  .N_prussure_out(pressure_21_11),
  .L_prussure_out(pressure_out_L_21),

  .W_full_in(full_20_21),
  .E_full_in(full_22_21),
  .N_full_in(full_11_21),

  .W_full_out(full_21_20),
  .E_full_out(full_21_22),
  .N_full_out(full_21_11)
);


router10 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_10(
  .clk(clk),
  .rst_n(rst_n),
  .full(full_10),

  .L_data_in(data_p2r_10),
  .N_data_in(data_00_10),
  .E_data_in(data_11_10),
  .S_data_in(data_20_10),



  .L_data_out(data_r2p_10),
  .N_data_out(data_10_00),

  .E_data_out(data_10_11),
  .S_data_out(data_10_20),


  .L_valid_in(valid_p2r_10),
  .N_valid_in(valid_00_10),
  .E_valid_in(valid_11_10),
  .S_valid_in(valid_20_10),



  .L_valid_out(valid_r2p_10),
  .N_valid_out(valid_10_00),
  .E_valid_out(valid_10_11),
  .S_valid_out(valid_10_20),


  .N_prussure_in(pressure_00_10),
  .E_prussure_in(pressure_11_10),
  .S_prussure_in(pressure_20_10),

  .N_prussure_out(pressure_10_00),
  .E_prussure_out(pressure_10_11),
  .S_prussure_out(pressure_10_20),
  .L_prussure_out(pressure_out_L_10),

  .N_full_in(full_00_10),
  .E_full_in(full_11_10),
  .S_full_in(full_20_10),

  .N_full_out(full_10_00),
  .E_full_out(full_10_11),
  .S_full_out(full_10_20)
);


router12 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_12(
  .clk(clk),
  .rst_n(rst_n),
  .full(full_12),

  .L_data_in(data_p2r_12),
  .N_data_in(data_02_12),
  .W_data_in(data_11_12),
  .S_data_in(data_22_12),



  .L_data_out(data_r2p_12),
  .N_data_out(data_12_02),
  .W_data_out(data_12_11),
  .S_data_out(data_12_22),


  .L_valid_in(valid_p2r_12),
  .N_valid_in(valid_02_12),
  .W_valid_in(valid_11_12),
  .S_valid_in(valid_22_12),



  .L_valid_out(valid_r2p_12),
  .N_valid_out(valid_12_02),
  .W_valid_out(valid_12_11),
  .S_valid_out(valid_12_22),


  .N_prussure_in(pressure_02_12),
  .W_prussure_in(pressure_11_12),
  .S_prussure_in(pressure_22_12),

  .N_prussure_out(pressure_12_02),
  .W_prussure_out(pressure_12_11),
  .S_prussure_out(pressure_12_22),
  .L_prussure_out(pressure_out_L_12),

  .N_full_in(full_02_12),
  .W_full_in(full_11_12),
  .S_full_in(full_22_12),

  .N_full_out(full_12_02),
  .W_full_out(full_12_11),
  .S_full_out(full_12_22)
);


router11 #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) router_11(
  .clk(clk),
  .rst_n(rst_n),
  .full(full_11),

  .L_data_in(data_p2r_11),
  .N_data_in(data_01_11),
  .W_data_in(data_10_11),
  .S_data_in(data_21_11),
  .E_data_in(data_12_11),


  .L_data_out(data_r2p_11),
  .N_data_out(data_11_01),
  .W_data_out(data_11_10),
  .S_data_out(data_11_21),
  .E_data_out(data_11_12),

  .L_valid_in(valid_p2r_11),
  .N_valid_in(valid_01_11),
  .W_valid_in(valid_10_11),
  .S_valid_in(valid_21_11),
  .E_valid_in(valid_12_11),


  .L_valid_out(valid_r2p_11),
  .N_valid_out(valid_11_01),
  .W_valid_out(valid_11_10),
  .S_valid_out(valid_11_21),
  .E_valid_out(valid_11_12),


  .N_prussure_in(pressure_01_11),
  .W_prussure_in(pressure_10_11),
  .S_prussure_in(pressure_21_11),
  .E_prussure_in(pressure_12_11),

  .N_prussure_out(pressure_11_01),
  .W_prussure_out(pressure_11_10),
  .S_prussure_out(pressure_11_21),
  .E_prussure_out(pressure_11_12),
  .L_prussure_out(pressure_out_L_11),

  .N_full_in(full_01_11),
  .W_full_in(full_10_11),
  .S_full_in(full_21_11),
  .E_full_in(full_12_11),

  .N_full_out(full_11_01),
  .W_full_out(full_11_10),
  .E_full_out(full_11_12),
  .S_full_out(full_11_21)
);


sort_top #(
      .ONE_ID( 4'b0001),
      .TWO_ID( 4'b0010),
      .THR_ID( 4'b0100),
      .FOU_ID( 4'b0101),
      .FIV_ID( 4'b0110),
      .SIX_ID( 4'b1000),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010)
    )  sort_00(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_00),
    .valid_in(valid_r2p_00),
    .data_out(data_s2p_00),
    .valid_out(valid_s2p_00)
    );

sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0010),
      .THR_ID( 4'b0100),
      .FOU_ID( 4'b0101),
      .FIV_ID( 4'b0110),
      .SIX_ID( 4'b1000),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010) 
    )  sort_01(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_01),
    .valid_in(valid_r2p_01),
    .data_out(data_s2p_01),
    .valid_out(valid_s2p_01)
    );

sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0100),
      .FOU_ID( 4'b0101),
      .FIV_ID( 4'b0110),
      .SIX_ID( 4'b1000),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010) 
    )  sort_02(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_02),
    .valid_in(valid_r2p_02),
    .data_out(data_s2p_02),
    .valid_out(valid_s2p_02)
    );


sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0010),
      .FOU_ID( 4'b0101),
      .FIV_ID( 4'b0110),
      .SIX_ID( 4'b1000),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010) 
    )  sort_10(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_10),
    .valid_in(valid_r2p_10),
    .data_out(data_s2p_10),
    .valid_out(valid_s2p_10)
    );

sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0010),
      .FOU_ID( 4'b0100),
      .FIV_ID( 4'b0110),
      .SIX_ID( 4'b1000),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010)
    )  sort_11(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_11),
    .valid_in(valid_r2p_11),
    .data_out(data_s2p_11),
    .valid_out(valid_s2p_11)
    );

sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0010),
      .FOU_ID( 4'b0100),
      .FIV_ID( 4'b0101),
      .SIX_ID( 4'b1000),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010 )
    )  sort_12(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_12),
    .valid_in(valid_r2p_12),
    .data_out(data_s2p_12),
    .valid_out(valid_s2p_12)
    );

sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0010),
      .FOU_ID( 4'b0100),
      .FIV_ID( 4'b0101),
      .SIX_ID( 4'b0110),
      .SEV_ID( 4'b1001),
      .EIG_ID( 4'b1010)
    )  sort_20(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_20),
    .valid_in(valid_r2p_20),
    .data_out(data_s2p_20),
    .valid_out(valid_s2p_20)
    );

sort_top #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0010),
      .FOU_ID( 4'b0100),
      .FIV_ID( 4'b0101),
      .SIX_ID( 4'b0110),
      .SEV_ID( 4'b1000),
      .EIG_ID( 4'b1010)
    )  sort_21(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_21),
    .valid_in(valid_r2p_21),
    .data_out(data_s2p_21),
    .valid_out(valid_s2p_21)
    );

sort_top  #(
      .ONE_ID( 4'b0000),
      .TWO_ID( 4'b0001),
      .THR_ID( 4'b0010),
      .FOU_ID( 4'b0100),
      .FIV_ID( 4'b0101),
      .SIX_ID( 4'b0110),
      .SEV_ID( 4'b1000),
      .EIG_ID( 4'b1001) 
    ) sort_22(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_r2p_22),
    .valid_in(valid_r2p_22),
    .data_out(data_s2p_22),
    .valid_out(valid_s2p_22)
    );


endmodule