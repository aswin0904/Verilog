`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 05:21:52 AM
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(
      input clk,reset,
      input[1:0] result_src,
      input PC_src,ALU_src,
      input reg_write,jalr,
      input [1:0]imm_src,
      input [3:0]ALU_control,
      output zero,ALUR31,
      output[31:0]PC,
      input[31:0]instr,
      output [31:0]ALU_result,write_data,
      input[31:0]read_data);
      wire [31:0]PC_next,PC_jalr,PC_plus4,PC_target;
      wire [31:0] imm_ext;
      wire [31:0]src_A,src_B,AuiPC,AuiPCResult;
      wire [31:0]result;
      flip_flop #(32) pc_reg(.clk(clk),
                .reset(reset),
                .d(PC_jalr),
                .q(PC));
      Adder pc_add(.A(PC),.B(32'd4),.out(PC_plus4));
      Adder pc_add_branch(
        .A(PC),
        .B(imm_ext),
        .out(PC_target));
        mux2 #32 jalrmux(.d0(PC_next),.d1(ALU_result),.sel(jalr),.y(PC_jalr));
      mux2 #(32) pc_mux(
            .d0(PC_plus4),
            .d1(PC_target),
            .sel(PC_src),
            .y(PC_next));
       Reg_file  rf(.clk(clk),
                 .we3(reg_write),
                 .rs1(instr[19:15]),
                 .rs2(instr[24:20]),
                 .rd(instr[11:7]),
                 .write_data(result),
                 .read_data1(src_A),
                 .read_data2(write_data));
        extend ext(.instr(instr[31:7]),
                 .imm_src(imm_src),
                 .imm_ext(imm_ext));
        mux2 #(32) src_mux(.d0(write_data),
                 .d1(imm_ext),
                 .sel(ALU_src),
                 .y(src_B));
        ALU alu(
              .A(src_A),
              .B(src_B),
              .control(ALU_control),
              .ALU_result(ALU_result),
              .zero(zero));
       mux3 #(32) result_mux(
              .d0(ALU_result),
              .d1(read_data),
              .d2(PC_plus4),
              .d3(AuiPCResult),
              .sel(result_src),
              .y(result));
      Adder #(32)    auipcadder ({instr[31:12], 12'b0}, PC, AuiPC);              
      mux2#(32) auipcmux(AuiPC,{instr[31:12],12'b0},instr[5],AuiPCResult);



assign ALUR31 = ALU_result[31];

endmodule
