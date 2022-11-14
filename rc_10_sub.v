
module rc_10_sub#(
  parameter DEPTH=8,
  parameter WIDTH=3,
  parameter DATASIZE=40  //src:4bit, dst:4bit, timestamp:8bit, data:22bit, type:2bit
  )(
  output reg[DATASIZE-1:0] data_out,
  output reg[3:0] direction_out,

  input wire[DATASIZE-1:0] data_in,
  input wire valid_in,
  input wire rc_ready,

  input wire[WIDTH:0] N_pressure_in,
  input wire[WIDTH:0] E_pressure_in,
  input wire[WIDTH:0] S_pressure_in,

  input wire rc_clk,
  input wire rst_n
  );

  wire[3:0] dst;
  assign dst=data_in[35:32];

  reg[3:0] direction;
  always @ (*) begin
    case (dst)
      4'b0000:direction=4'b0100;
      
      4'b0001:
        if (E_pressure_in<=N_pressure_in)
          direction=4'b0010;
        else
          direction=4'b0100;

      4'b0010:
        if (E_pressure_in<=N_pressure_in)
          direction=4'b0010;
        else
          direction=4'b0100;

      4'b0100:direction=4'b0000;

      4'b0101:direction=4'b0010;

      4'b0110:direction=4'b0010;

      4'b1000:direction=4'b0001;

      4'b1001:
        if (E_pressure_in<=S_pressure_in)
          direction=4'b0010;
        else
          direction=4'b0001;

      4'b1010:
        if (E_pressure_in<=S_pressure_in)
          direction=4'b0010;
        else
          direction=4'b0001;

      default:direction=4'b1111;

      endcase
    end

//data_out
  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out<=40'b0;
    else if (rc_ready)
      data_out<=data_in;
    else
      data_out<=data_out;
  end

//direction_out
   always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out<=4'b1111;
    else if(!valid_in & rc_ready)
      direction_out<=4'b1111;
    else if(!rc_ready)
      direction_out<=direction_out;
    else
      direction_out<=direction;
  end

endmodule