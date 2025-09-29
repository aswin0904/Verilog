`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 05:11:03 AM
// Design Name: 
// Module Name: mux2
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


module mux2 #(parameter WIDTH=8)(input [WIDTH-1:0]d0,d1,
input sel,
output [WIDTH-1:0]y

    );
    assign y=sel?d1:d0;
endmodule
module mux3 #(parameter WIDTH = 8)(
    input  [WIDTH-1:0] d0, d1, d2, d3,
    input  [1:0]       sel,
    output reg [WIDTH-1:0] y
);
    always @* begin
        case(sel)
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            2'b11: y = d3;
        endcase
    end
endmodule

module flip_flop#(parameter WIDTH=8)(input clk,reset,
input [WIDTH-1:0]d,
output reg[WIDTH-1:0]q);
always @(posedge clk,posedge reset)
if (reset)
   q<=0;
 else
  q<=d;
endmodule
module Adder (input [31:0]A,B,
output [31:0]out);
assign out=A+B;
endmodule