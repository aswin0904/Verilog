`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 06:50:59 AM
// Design Name: 
// Module Name: RISCV
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


module RISCV(
   input clk,reset,
   input [31:0] read_data,
   input [31:0] instr,
   output [31:0]PC,
   output mem_write,
   output [31:0] ALU_result,write_data
    );
    wire ALU_src,reg_write,jump,zero,jalr;
    wire [1:0] result_src,imm_src;
    wire [3:0]ALU_control;
    controller c(.op(instr[6:0]),
            .func3(instr[14:12]),
            .func7b5(instr[30]),
            .zero(zero),.ALUR31(ALUR31),
            .result_src(result_src),
            .mem_write(mem_write),
            .PC_src(PC_src),
            .ALU_src(ALU_src),
            .reg_write(reg_write), 
            .jump(jump),.jalr(jalr),
            .imm_src(imm_src),
            .ALU_control(ALU_control));
            
        datapath dp(
        .clk(clk), 
        .reset(reset), 
        .result_src(result_src),
        .PC_src(PC_src), 
        .ALU_src(ALU_src),
        .reg_write(reg_write),
        .imm_src(imm_src),
        .ALU_control(ALU_control),
        .zero(zero),.ALUR31(ALUR31),
        .PC(PC),.jalr(jalr),
        .instr(instr),
        .ALU_result(ALU_result), 
        .write_data(write_data),
        .read_data(read_data)); 
    
    
    
endmodule
