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

`define DATA_WIDTH_NOR 12 //正常数据包有效data width20, debug 8
`define DATA_WIDTH_DBG 8


module PE_single #(
    parameter MY_ID = 4'b0000,
    parameter TAR_ID = 4'b0001,

    //for retry request
    parameter NORMAL_BAG = 2'b01
) (
    input wire                                                      dbg_mode,
    input wire                                                      enable,
    input wire[`SRC_MAX:0]                                         data_r2p,
    input wire                                                      valid_r2p,
    input wire[`SRC_MAX - `SRC_MIN + `DST_MAX - `DST_MIN + 1:0]     data_p2r,
    input wire                                                      valid_p2r,
    //basic flags
    input wire                                                      valid_in_flag,
    input wire                                                      normal_in_flag,
    input wire                                                      request_in_flag,
    input wire                                                      retrans_in_flag,
    input wire                                                      task_send_finish_flag,
    input wire[`TIME_SIZE + `TYPE_SIZE + `ID_SIZE - 1:0]            data_in_des_buf,
    output wire                                                     all_receive_flag,

    //data receive miss
    input wire                                                      long_time,
    output reg[`DATA_SIZE_0:0]                                      seq_counter,
    output reg[`DATA_SIZE_0:0]                                      diff_counter,
    output reg[`TIME_SIZE_0:0]                                      receive_time_counter,
    output reg                                                      data_miss_flag,
    output reg                                                      long_time_flag,
    output reg                                                      so_retrsreq_send_num,
    output reg                                                      so_retrsreq_send_flag,

    //send miss
    output reg[`DATA_SIZE_0:0]                                      retrans_counter,
    output reg                                                      so_retrsreq_receive_num,
    output reg                                                      so_retrsreq_receive_flag,

    //output flags
    input wire                                                      request_out_flag,
    input wire                                                      retrans_out_flag,
    input wire                                                      hold_out_flag,

    //dst
    input wire[`ID_SIZE_0:0]                                        request_dst,
    input wire[`ID_SIZE_0:0]                                        retrans_dst,

    input wire                                                      clk,
    input wire                                                      rst_n
);
// VARIABLE
    //basic flags
    reg[`DATA_SIZE:0]       all_receive_counter;
    reg                     receive_src_flag;
    reg                     send_tar_flag;
// INPUT
// BASIC FLAGS
    assign all_receive_flag = dbg_mode ? all_receive_counter[`DATA_WIDTH_DBG] : all_receive_counter[`DATA_WIDTH_NOR];

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            receive_src_flag <= 1'b0;
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID))
            receive_src_flag <= 1'b1;
        else
            receive_src_flag <= receive_src_flag;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            all_receive_counter <= {`DATA_SIZE{1'b0}};
        else if((all_receive_counter == {`DATA_SIZE{1'b0}}) && normal_in_flag && !all_receive_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] == {`DATA_SIZE{1'b0}}))
            all_receive_counter <= all_receive_counter + 1'b1;
        else if(normal_in_flag && !all_receive_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > seq_counter))
            all_receive_counter <= all_receive_counter + 1'b1;
        else if(retrans_in_flag && !all_receive_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf))
            all_receive_counter <= all_receive_counter + 1'b1;
        else
            all_receive_counter <= all_receive_counter;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            send_tar_flag <= 1'b0;
        else if(!enable)
            send_tar_flag <= send_tar_flag;
        else if(valid_p2r && (data_p2r == {MY_ID, TAR_ID}))
            send_tar_flag <= 1'b1;
        else
            send_tar_flag <= send_tar_flag;
    end

// RECEIVE MISS
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            seq_counter <= {`DATA_SIZE{1'b0}};
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > seq_counter))
            seq_counter <= data_r2p[`DATA_MAX:`DATA_MIN];
        else
            seq_counter <= seq_counter;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            data_miss_flag <= 1'b0;
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > (seq_counter + 1'b1)))
            data_miss_flag <= 1'b1;
        else if(request_out_flag && (request_dst == TAR_ID) && !hold_out_flag)
            data_miss_flag <= 1'b0;
        else
            data_miss_flag <= data_miss_flag;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            long_time_flag <= 1'b0;
        else if(receive_time_counter == {`TIME_SIZE{1'b1}})
            long_time_flag <= 1'b1;
        else if(request_out_flag && (request_dst == TAR_ID) && !hold_out_flag)
            long_time_flag <= 1'b0;
        else
            long_time_flag <= long_time_flag;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            diff_counter <= {`DATA_SIZE{1'b0}};
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > seq_counter) && request_out_flag && (request_dst == TAR_ID) && !hold_out_flag)
            diff_counter <= data_r2p[`DATA_MAX:`DATA_MIN] - seq_counter - 1'b1;
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > seq_counter))
            diff_counter <= diff_counter + data_r2p[`DATA_MAX:`DATA_MIN] - seq_counter - 1'b1;
        else if(request_out_flag && (request_dst == TAR_ID) && !hold_out_flag)
            diff_counter <= {`DATA_SIZE{1'b0}};
        else
            diff_counter <= diff_counter;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            receive_time_counter <= {`TIME_SIZE{1'b0}};
        else if(!receive_src_flag || all_receive_flag)
            receive_time_counter <= {`TIME_SIZE{1'b0}};
        else if((valid_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID)) || (request_out_flag && (request_dst == TAR_ID)))
            receive_time_counter <= {`TIME_SIZE{1'b0}};
        else if(enable)
            receive_time_counter <= receive_time_counter + 1'b1;
        else
            receive_time_counter <= receive_time_counter;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            so_retrsreq_send_flag <= 1'b0;
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > seq_counter + 1))
            so_retrsreq_send_flag <= 1'b1;
        else if(!long_time && receive_time_counter == {`TIME_SIZE{1'b1}})
            so_retrsreq_send_flag <= 1'b1;
        else
            so_retrsreq_send_flag <= so_retrsreq_send_flag;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            so_retrsreq_send_num <= 1'b0;
        else if(normal_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && (data_r2p[`DATA_MAX:`DATA_MIN] > seq_counter + 1))
            so_retrsreq_send_num <= 1'b1;
        else if(!long_time && receive_time_counter == {`TIME_SIZE{1'b1}})
            so_retrsreq_send_num <= 1'b1;
        else
            so_retrsreq_send_num <= 1'b0;
    end
    
// SEND MISS
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            retrans_counter <= {`DATA_SIZE{1'b0}};
        else if(!send_tar_flag)
            retrans_counter <= {`DATA_SIZE{1'b0}};
        else if(retrans_out_flag && (retrans_dst == TAR_ID) && task_send_finish_flag && (data_r2p[`DATA_MAX:`DATA_MIN] == 16'd0) && request_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf) && !hold_out_flag)
            retrans_counter <= retrans_counter;
        else if(retrans_out_flag && (retrans_dst == TAR_ID) && request_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf) && !hold_out_flag)
            retrans_counter <= retrans_counter + data_r2p[`DATA_MAX:`DATA_MIN] - 1'b1;
        else if(retrans_out_flag && (retrans_dst == TAR_ID) && !hold_out_flag)
            retrans_counter <= retrans_counter - 1'b1;
        else if(task_send_finish_flag && (data_r2p[`DATA_MAX:`DATA_MIN] == 16'd0) && request_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf))
            retrans_counter <= retrans_counter + 1'b1;
        else if(request_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf))
            retrans_counter <= retrans_counter + data_r2p[`DATA_MAX:`DATA_MIN];
        else
            retrans_counter <= retrans_counter;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            so_retrsreq_receive_flag <= 1'b0;
        else if(!send_tar_flag)
            so_retrsreq_receive_flag <= 1'b0;
        else if(request_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf))
            so_retrsreq_receive_flag <= 1'b1;
        else
            so_retrsreq_receive_flag <= so_retrsreq_receive_flag;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            so_retrsreq_receive_num <= 1'b0;
        else if(!send_tar_flag)
            so_retrsreq_receive_num <= 1'b0;
        else if(request_in_flag && (data_r2p[`SRC_MAX:`SRC_MIN] == TAR_ID) && ({data_r2p[`TIME_MAX:`TIME_MIN],data_r2p[`TYPE_MAX:`TYPE_MIN],data_r2p[`SRC_MAX:`SRC_MIN]} != data_in_des_buf))
            so_retrsreq_receive_num <= 1'b1;
        else
            so_retrsreq_receive_num <= 1'b0;
    end

endmodule


