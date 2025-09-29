`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 01:38:37 AM
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb;

    reg [31:0] A, B;
    reg [3:0] control;
    wire [31:0] ALU_result;
    wire zero;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .control(control),
        .ALU_result(ALU_result),
        .zero(zero)
    );

    // Local parameters for operation codes (same as ALU)
    localparam ADD   = 4'b0000;
    localparam SUB   = 4'b0001;
    localparam AND   = 4'b0010;
    localparam OR    = 4'b0011;
    localparam XOR   = 4'b0100;
    localparam SLL   = 4'b0101;
    localparam SRL   = 4'b0110;
    localparam SRA   = 4'b0111;
    localparam SLT   = 4'b1100;
    localparam SLTU  = 4'b1101;
    localparam BRANCH= 4'b1001;
    localparam LD_ST = 4'b1000;

    initial begin
        $display("Time\tControl\tA\t\tB\t\tResult\t\tZero");
        $monitor("%0t\t%0h\t%h\t%h\t%h\t%b", $time, control, A, B, ALU_result, zero);

        // Test ADD
        A = 32'd10; B = 32'd5; control = ADD; #10;

        // Test SUB
        A = 32'd15; B = 32'd5; control = SUB; #10;

        // Test AND
        A = 32'hFF00FF00; B = 32'h0F0F0F0F; control = AND; #10;

        // Test OR
        A = 32'hFF00FF00; B = 32'h0F0F0F0F; control = OR; #10;

        // Test XOR
        A = 32'hAAAA5555; B = 32'h5555AAAA; control = XOR; #10;

        // Test SLL
        A = 32'h00000001; B = 32'd4; control = SLL; #10;

        // Test SRL
        A = 32'h00000080; B = 32'd3; control = SRL; #10;

        // Test SRA
        A = 32'hF0000000; B = 32'd4; control = SRA; #10;

        // Test SLT (signed)
        A = -5; B = 3; control = SLT; #10;
        A = 5; B = -3; control = SLT; #10;
        A = -5; B = -6; control = SLT; #10;

        // Test SLTU (unsigned)
        A = 32'd5; B = 32'd10; control = SLTU; #10;
        A = 32'd20; B = 32'd10; control = SLTU; #10;

        // Test BRANCH
        A = 32'd15; B = 32'd15; control = BRANCH; #10;

        // Test LD_ST
        A = 32'd100; B = 32'd20; control = LD_ST; #10;

        // Done
        $finish;
    end

endmodule

