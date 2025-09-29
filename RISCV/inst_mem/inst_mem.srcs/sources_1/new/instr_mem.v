`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 06:48:10 AM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
input [31:0]addr,
output [31:0]instr
    );
    reg [31:0]RAM[2047:0];
    integer i;
    initial begin
         $display("Loading memory from file..."); 
        $readmemh("riscv-test.txt", RAM);
        $display("Instructions loaded:");
        for (i = 0; i < 2049; i = i + 1)
            $display("RAM[%0d] = %h", i, RAM[i]);
            $display("addr=%0d, instr=%h", addr, instr);
    end
    assign instr = RAM[addr[31:2]];
endmodule
    
    
    
    
    
