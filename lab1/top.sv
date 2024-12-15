`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:08:15 PM
// Design Name: 
// Module Name: top
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


module top (
    input logic clk,
    input logic reset_n

    );
    localparam PROG_VALUE = 3;
    localparam IMEM_DEPTH = 4;
//    localparam REGF_WIDTH = 16;
    localparam ALU_WIDTH = 16;
    
    // PROGRAM COUNTER
    logic [$clog2(PROG_VALUE)-1:0] prog_count;
    
    program_counter #(.PROG_VALUE(PROG_VALUE)) prog_counter (
        .clk(clk),
        .reset_n(reset_n),
        .count(prog_count)
    );
    
    // INSTRUCTION MEMORY
    logic [7:0] instruction;
    
    instruction_memory #(.IMEM_DEPTH(IMEM_DEPTH), .PROG_VALUE(PROG_VALUE)) inst_memory(
        .clk(clk),
        .program_count(prog_count),
        .instruction(instruction)
    );
    
    // ALU
    logic [1:0] opcode;
    logic [ALU_WIDTH-1:0] op1, op2, alu_result;
    
    assign opcode = instruction[1:0];
    
    alu #(.ALU_WIDTH(ALU_WIDTH)) alu_inst (
        .op1(op1),
        .op2(op2),
        .alu_op(opcode),
        .alu_result(alu_result)
    );
    
    // REGISTER FILE
    logic [1:0] rs1, rs2, rd;

    assign rs1 = instruction[3:2];
    assign rs2 = instruction[5:4];
    assign rd = instruction[7:6];
    
    register_file#(.REGF_WIDTH(ALU_WIDTH)) reg_file(  
        .clk(clk),    
        .write_en(1'b1),    
        .write_addr(rd),    
        .write_data(alu_result),
        .read_addr1(rs1),  
        .read_addr2(rs2),  
        .read_data1(op1),  
        .read_data2(op2)  
    );

endmodule
