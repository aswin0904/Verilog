module controller(
    input [6:0] op,
    input [2:0] func3,
    input func7b5,
    input zero,ALUR31,
    output [1:0] result_src,
    output mem_write,
    output PC_src,
    output ALU_src,
    output reg_write,
    output jump,jalr,
    output [1:0] imm_src,
    output [3:0] ALU_control
);
    wire [1:0] ALU_op;
    wire branch;

    main_decoder md(.func3(func3),
        .op(op),.zero(zero),.ALUR31(ALUR31),
        .result_src(result_src),
        .mem_write(mem_write),
        .ALU_src(ALU_src),
        .branch(branch),
        .jump(jump),.jalr(jalr),
        .reg_write(reg_write),
        .imm_src(imm_src),
        .ALU_op(ALU_op)
    );

    ALU_decoder ad(
        .opb5(op[5]),
        .func3(func3),
        .func7b5(func7b5),
        .ALU_op(ALU_op),
        .ALU_control(ALU_control)
    );

    assign PC_src = (branch) | jump;
endmodule
