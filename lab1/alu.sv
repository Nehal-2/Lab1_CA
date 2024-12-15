`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 01:34:05 PM
// Design Name: 
// Module Name: alu
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


module alu#(
    parameter ALU_WIDTH = 16
)(
        input logic [1:0] alu_op,
        input logic [ALU_WIDTH-1:0] op1,
        input logic [ALU_WIDTH-1:0] op2,
        output logic [ALU_WIDTH-1:0] alu_result
    );
    
    always @(*) begin
        case (alu_op)
            2'b00: alu_result = op1 + op2;
            2'b01: alu_result = op1 - op2;
            2'b10: alu_result = op1 & op2;
            2'b11: alu_result = op1 | op2;
            default: alu_result = {ALU_WIDTH{1'b0}};
        endcase
    end
endmodule
