`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 02:00:11 PM
// Design Name: 
// Module Name: register_file
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


module register_file#(
    parameter REGF_WIDTH = 16
)(  
        input logic clk,    
        input logic write_en,    
        input logic [1:0] write_addr,    
        input logic [REGF_WIDTH-1:0] write_data,
        input logic [1:0] read_addr1,  
        input logic [1:0] read_addr2,  
        output logic [REGF_WIDTH-1:0] read_data1,  
        output logic [REGF_WIDTH-1:0] read_data2  

    );
    
    integer fd;
    integer i;
    initial begin
        // Create a new file
        fd = $fopen("regfile.dump", "w");
        #100;
        $fclose(fd);
    end
    
    logic [REGF_WIDTH-1:0] x [0:3]; // registers x0, x1, x2, x3
    
    always_ff @(posedge clk) begin
        if (write_en)
            x[write_addr] <= write_data;
    end
    
    always_comb begin
        read_data1 = x[read_addr1];
        read_data2 = x[read_addr2];
    end
    
    initial begin
        $readmemb("/home/it/ComputerArchitecture/cx-204/lab1/support_files/fib_rf.mem", x);
    end
    
    always @ (posedge clk) begin
        for (i = 0; i < 4; i=i+1) begin
        $fdisplay(fd,x[i]);
        end
    end
endmodule
