//Github co-pilot was not used
//Holds the address of the current instruction
`timescale 1ns / 1ps
module ProgramCounter(
input clk,
input en, rst, we,
input [31:0]ALU_in,
output [31:0] addr,
output [31:0] addr_next);

    
    reg [31:0] PC;
    

    always@(posedge clk)
    begin
        if(rst)
            PC <= 32'h01000000;
        else if(we) 
            case(en)
                1'b0: PC <= addr_next;
                1'b1: PC <= ALU_in;
            endcase
    end
    
    assign addr = PC;
    assign addr_next = PC + 4;
    
endmodule
