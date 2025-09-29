module main_decoder(
    input [6:0] op,input [2:0]func3,
    input zero,ALUR31,
    output [1:0] result_src,
    output [1:0] imm_src,
    output mem_write,
    output branch,
    output ALU_src,
    output reg_write,
    output jump, jalr,
    output [1:0] ALU_op
);
    reg [10:0] controls;
    assign {reg_write, imm_src, ALU_src, mem_write, result_src, branch, ALU_op, jump} = controls;
    assign jalr= (op==7'b1100111)?1:0;
    always @* begin
         case(op)
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // LOAD
            7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // STORE
            7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // REG
            7'b1100011: begin // BRANCH
                case (func3)
                    3'b000: controls = (zero    ? 11'b0_10_0_0_00_1_01_0 : 11'b0_10_0_0_00_0_01_0); // BEQ
                    3'b001: controls = (!zero   ? 11'b0_10_0_0_00_1_01_0 : 11'b0_10_0_0_00_0_01_0); // BNE
                    3'b100: controls = (ALUR31  ? 11'b0_10_0_0_00_1_01_0 : 11'b0_10_0_0_00_0_01_0); // BLT
                    3'b101: controls = (!ALUR31 ? 11'b0_10_0_0_00_1_01_0 : 11'b0_10_0_0_00_0_01_0); // BGE
                    3'b110: controls = (ALUR31  ? 11'b0_10_0_0_00_1_01_0 : 11'b0_10_0_0_00_0_01_0); // BLTU
                    3'b111: controls = (!ALUR31 ? 11'b0_10_0_0_00_1_01_0 : 11'b0_10_0_0_00_0_01_0); // BGEU
                    default: controls = 11'b0_10_0_0_00_0_01_0;
                endcase
            end
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // IMM
            7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // JUMP
            7'b0010111: controls = 11'b1_xx_x_0_11_0_xx_0;//auipc
            7'b0110111: controls = 11'b1_xx_x_0_11_0_xx_0;//lui
            7'b1100111: begin controls = 11'b1_00_1_0_10_0_00_0;
                        
                         end
            default   : controls = 11'bx_xx_x_x_xx_x_xx_x;
        endcase
    end
endmodule