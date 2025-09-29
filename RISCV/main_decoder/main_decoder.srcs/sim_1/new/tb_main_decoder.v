`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 04:13:10 AM
// Design Name: 
// Module Name: tb_main_decoder
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

`timescale 1ns / 1ps

module tb_main_decoder;

    // Inputs
    reg [6:0] op;

    // Outputs
    wire [1:0] result_src;
    wire [1:0] imm_src;
    wire mem_write;
    wire branch;
    wire ALU_src;
    wire reg_write;
    wire jump;
    wire [1:0] ALU_op;

    // Instantiate the Unit Under Test (UUT)
    main_decoder uut (
        .op(op),
        .result_src(result_src),
        .imm_src(imm_src),
        .mem_write(mem_write),
        .branch(branch),
        .ALU_src(ALU_src),
        .reg_write(reg_write),
        .jump(jump),
        .ALU_op(ALU_op)
    );

    initial begin
        $display("Time\tOpcode\t  reg_write imm_src ALU_src mem_write result_src branch ALU_op jump");
        $monitor("%0t\t%07b\t  %b         %02b      %b        %b         %02b        %b      %02b     %b", 
                  $time, op, reg_write, imm_src, ALU_src, mem_write, result_src, branch, ALU_op, jump);

        // Load (e.g., lw)
        op = 7'b0000011; #10;

        // Store (e.g., sw)
        op = 7'b0100011; #10;

        // R-type (e.g., add, sub)
        op = 7'b0110011; #10;

        // Branch (e.g., beq)
        op = 7'b1100011; #10;

        // I-type (e.g., addi)
        op = 7'b0010011; #10;

        // J-type (e.g., jal)
        op = 7'b1101111; #10;

        // Unknown / default
        op = 7'b1111111; #10;

        $finish;
    end

endmodule

