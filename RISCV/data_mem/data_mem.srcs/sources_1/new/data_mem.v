`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 06:42:50 AM
// Design Name: 
// Module Name: data_mem
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

module data_mem (
    input clk,
    input write_en,
    input [2:0] func3,
    input [31:0] addr,
    input [31:0] write_data,
    output reg [31:0] rd
);

    reg [31:0] RAM [0:33554431];
    integer i;

    // Initialize memory to 0
    initial begin
        for (i = 0; i < 33554432; i = i + 1)
            RAM[i] = 32'b0;
    end

    wire [31:0] word_addr = addr[31:2] ;  // divide by 4 to get word-aligned address

    // ------------------------
    // WRITE logic (synchronous)
    // ------------------------
    always @(posedge clk) begin
        if (write_en) begin
            case (func3)
                3'b000: begin // SB (Store Byte)
                    case (addr[1:0])
                        2'b00: RAM[word_addr][7:0]   <= write_data[7:0];
                        2'b01: RAM[word_addr][15:8]  <= write_data[7:0];
                        2'b10: RAM[word_addr][23:16] <= write_data[7:0];
                        2'b11: RAM[word_addr][31:24] <= write_data[7:0];
                    endcase
                end
                3'b001: begin // SH (Store Halfword)
                    case (addr[1])
                        1'b0: RAM[word_addr][15:0]  <= write_data[15:0];
                        1'b1: RAM[word_addr][31:16] <= write_data[15:0];
                    endcase
                end
                3'b010: begin // SW (Store Word)
                    RAM[word_addr] <= write_data;
                end
            endcase
        end
    end

    // -----------------------
    // READ logic (combinational)
    // -----------------------
    always @(*) begin
        case (func3)
            3'b000: begin // LB
                case (addr[1:0])
                    2'b00: rd = {{24{RAM[word_addr][7]}},  RAM[word_addr][7:0]};
                    2'b01: rd = {{24{RAM[word_addr][15]}}, RAM[word_addr][15:8]};
                    2'b10: rd = {{24{RAM[word_addr][23]}}, RAM[word_addr][23:16]};
                    2'b11: rd = {{24{RAM[word_addr][31]}}, RAM[word_addr][31:24]};
                endcase
            end
            3'b001: begin // LH
                case (addr[1])
                    1'b0: rd = {{16{RAM[word_addr][15]}}, RAM[word_addr][15:0]};
                    1'b1: rd = {{16{RAM[word_addr][31]}}, RAM[word_addr][31:16]};
                endcase
            end
            3'b010: begin // LW
                rd = RAM[word_addr];
            end
            3'b100: begin // LBU
                case (addr[1:0])
                    2'b00: rd = {24'b0, RAM[word_addr][7:0]};
                    2'b01: rd = {24'b0, RAM[word_addr][15:8]};
                    2'b10: rd = {24'b0, RAM[word_addr][23:16]};
                    2'b11: rd = {24'b0, RAM[word_addr][31:24]};
                endcase
            end
            3'b101: begin // LHU
                case (addr[1])
                    1'b0: rd = {16'b0, RAM[word_addr][15:0]};
                    1'b1: rd = {16'b0, RAM[word_addr][31:16]};
                endcase
            end
            default: rd = 32'b0;
        endcase
    end

endmodule




























