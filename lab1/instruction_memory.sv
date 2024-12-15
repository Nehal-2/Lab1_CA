`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 03:29:16 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory #(
    parameter IMEM_DEPTH = 4,
    parameter PROG_VALUE = 3
)(
        input logic clk,
        input logic [$clog2(PROG_VALUE)-1:0] program_count,
        output logic [7:0] instruction

    );
    
    logic [7:0] instr_mem [0:IMEM_DEPTH-1];
    
    assign instruction = instr_mem[program_count];
    
    initial begin
        $readmemb("/home/it/ComputerArchitecture/cx-204/lab1/support_files/fib_im.mem", instr_mem);
    end
endmodule
