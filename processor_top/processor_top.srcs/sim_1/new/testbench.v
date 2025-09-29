`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 07:04:32 AM
// Design Name: 
// Module Name: testbench
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

module testbench;

reg clk, reset;
wire [31:0] write_data, data_addr, PC, instr, read_data;
wire mem_write;

processor_top dut(
    .clk(clk),
    .reset(reset),
    .write_data(write_data), 
    .data_addr(data_addr),
    .mem_write(mem_write),
    .PC(PC), 
    .instr(instr), 
    .read_data(read_data));
initial begin
    clk = 0;
    reset = 1;
    #10;
    reset = 0;
end
initial begin
    $monitor("Time: %d, control: %h, PC: %h, rf[4]: %h, rf[11]:%h, rf[18]:%h,rf[8]:%h,rf[14]:%h ,branch:%b",
         $time, dut.riscv.ALU_control, dut.riscv.dp.PC, dut.riscv.dp.rf.rf[4][31:0],
         dut.riscv.dp.rf.rf[11][31:0], dut.riscv.dp.rf.rf[18][31:0],dut.riscv.dp.rf.rf[8][31:0],dut.riscv.dp.rf.rf[14][31:0],dut.riscv.c.md.branch);
 end

always  begin
    #5 clk = ~clk;
end

always @(negedge clk)
  begin
    if(mem_write) begin
      if(data_addr === 100 & write_data === 25) begin
                $display("Simulation succeeded");
                $stop; 
       
      end else if (data_addr !== 96) begin
        $display("Simulation failed");
        
      end
    end
  end

endmodule