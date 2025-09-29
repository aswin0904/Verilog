module ALU_decoder(
    input opb5,
    input [2:0] func3,
    input func7b5,
    input [1:0] ALU_op,
    output reg [3:0] ALU_control
);
    wire RtypeSub;
    assign RtypeSub = func7b5 & opb5;

    always @* begin
        case(ALU_op)
            2'b00: ALU_control = 4'b1000; // LD/ST
            2'b01: ALU_control = 4'b1001; // Branch
            default:
                case(func3)
                    3'b000: ALU_control = RtypeSub ? 4'b0001 : 4'b0000; // SUB or ADD
                    3'b001: ALU_control = 4'b0101; // SLL
                    3'b010: ALU_control = 4'b1100; // SLT
                    3'b011: ALU_control = 4'b1101; // SLTU
                    3'b100: ALU_control = 4'b0100; // XOR
                    3'b101: ALU_control = RtypeSub ? 4'b0111 : 4'b0110; // SRA or SRL
                    3'b110: ALU_control = 4'b0011; // OR
                    3'b111: ALU_control = 4'b0010; // AND
                    default: ALU_control = 4'b0000;
                endcase
        endcase
    end
endmodule