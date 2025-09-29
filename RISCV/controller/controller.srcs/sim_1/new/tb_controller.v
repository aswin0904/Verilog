`timescale 1ns / 1ps

module tb_controller;

    // Inputs
    reg [6:0] op;
    reg [2:0] func3;
    reg funct7b5;
    reg zero;

    // Outputs
    wire [1:0] result_src;
    wire mem_write;
    wire PC_src;
    wire ALU_src;
    wire reg_write;
    wire jump;
    wire [1:0] imm_src;
    wire [3:0] ALUControl;  // FIXED name

    // Instantiate the controller
    controller uut (
        .op(op),
        .func3(func3),
        .funct7b5(funct7b5),
        .zero(zero),
        .result_src(result_src),
        .mem_write(mem_write),
        .PC_src(PC_src),
        .ALU_src(ALU_src),
        .reg_write(reg_write),
        .jump(jump),
        .imm_src(imm_src),
        .ALUControl(ALUControl) // FIXED casing
    );

    initial begin
        $display("Time\tOpcode\tfunc3\tf7b5\tzero\treg_write\tmem_write\tALU_src\tresult_src\tPC_src\tjump\timm_src\tALU_control");
        $monitor("%0t\t%07b\t%b\t%b\t%b\t%b\t\t%b\t\t%b\t%02b\t\t%b\t%b\t%02b\t%04b",
                 $time, op, func3, funct7b5, zero,
                 reg_write, mem_write, ALU_src, result_src,
                 PC_src, jump, imm_src, ALUControl);

        // Test: Load (e.g., lw)
        op = 7'b0000011; func3 = 3'b010; funct7b5 = 0; zero = 0; #10;

        // Test: Store (e.g., sw)
        op = 7'b0100011; func3 = 3'b010; funct7b5 = 0; zero = 0; #10;

        // Test: R-type (add)
        op = 7'b0110011; func3 = 3'b000; funct7b5 = 0; zero = 0; #10;

        // Test: R-type (sub)
        op = 7'b0110011; func3 = 3'b000; funct7b5 = 1; zero = 0; #10;

        // Test: I-type (addi)
        op = 7'b0010011; func3 = 3'b000; funct7b5 = 0; zero = 0; #10;

        // Test: Branch taken
        op = 7'b1100011; func3 = 3'b000; funct7b5 = 0; zero = 1; #10;

        // Test: Branch not taken
        op = 7'b1100011; func3 = 3'b000; funct7b5 = 0; zero = 0; #10;

        // Test: Jump (jal)
        op = 7'b1101111; func3 = 3'b000; funct7b5 = 0; zero = 0; #10;

        $finish;
    end

endmodule
