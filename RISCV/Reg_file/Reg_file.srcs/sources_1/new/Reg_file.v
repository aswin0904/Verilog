`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 06:36:14 AM
// Design Name: 
// Module Name: Reg_file
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


module Reg_file(
input clk,
input we3,
input [4:0]rs1,rs2,rd,
input [31:0]write_data,
output [31:0]read_data1,read_data2
    );
    reg [31:0] rf[0:31];
    integer i;
    initial begin
    for (i=0;i<32;i=i+1)
    rf[i]=32'b0;
    end
    
    always @(posedge clk)
        if (we3 &(rd!=5'b0))
        begin
        rf[rd]<=write_data;
         
        end
    always @(posedge clk)
    rf[0]<=32'b0;
    assign read_data1=(rs1!=0)?rf[rs1]:0;
    assign read_data2=(rs2!=0)?rf[rs2]:0;
endmodule
