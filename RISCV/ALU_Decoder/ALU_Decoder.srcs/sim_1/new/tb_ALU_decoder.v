`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 02:58:50 AM
// Design Name: 
// Module Name: tb_ALU_decoder
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

module tb_ALU_decoder;

    // Inputs
    reg opb5;
    reg [2:0] funct3;
    reg funct7b5;
    reg [1:0] ALUop;

    // Output
    wire [3:0] ALUControl;

    // Instantiate the ALU_decoder
    ALU_decoder uut (
        .opb5(opb5),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .ALUop(ALUop),
        .ALUControl(ALUControl)
    );

    initial begin
        $display("Time\tALUop\tfunct3\tfunct7b5\topb5\tALUControl");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%04b",
                 $time, ALUop, funct3, funct7b5, opb5, ALUControl);

        // Test Load/Store
        ALUop = 2'b00; funct3 = 3'b000; funct7b5 = 0; opb5 = 0; #10;

        // Test Branch
        ALUop = 2'b01; funct3 = 3'b000; funct7b5 = 0; opb5 = 0; #10;

        // Test ADD
        ALUop = 2'b10; funct3 = 3'b000; funct7b5 = 0; opb5 = 1; #10;

        // Test SUB
        ALUop = 2'b10; funct3 = 3'b000; funct7b5 = 1; opb5 = 1; #10;

        // Test SLL
        ALUop = 2'b10; funct3 = 3'b001; funct7b5 = 0; opb5 = 1; #10;

        // Test SLT
        ALUop = 2'b10; funct3 = 3'b010; funct7b5 = 0; opb5 = 1; #10;

        // Test SLTU
        ALUop = 2'b10; funct3 = 3'b011; funct7b5 = 0; opb5 = 1; #10;

        // Test XOR
        ALUop = 2'b10; funct3 = 3'b100; funct7b5 = 0; opb5 = 1; #10;

        // Test SRL
        ALUop = 2'b10; funct3 = 3'b101; funct7b5 = 0; opb5 = 1; #10;

        // Test SRA
        ALUop = 2'b10; funct3 = 3'b101; funct7b5 = 1; opb5 = 1; #10;

        // Test OR
        ALUop = 2'b10; funct3 = 3'b110; funct7b5 = 0; opb5 = 1; #10;

        // Test AND
        ALUop = 2'b10; funct3 = 3'b111; funct7b5 = 0; opb5 = 1; #10;

        $finish;
    end

endmodule

