//Github co-pilot was not used
//Stores the instruction to be executed
`timescale 1ns / 1ps
module InstructionMemory(
    input clk,
    input [31:0]addr1, addr2,
    input rd1, rd2,
    output reg[31:0]data1, data2);

    reg [31:0]IM[0:512]; //2KB
    wire [31:0]translated_addr1, translated_addr2;
    localparam im_start_addr = 16777216;
     
    assign translated_addr1 = (addr1 - im_start_addr)>>2;
    assign translated_addr2 = (addr2 - im_start_addr)>>2;
    
    always@(posedge clk)
    begin
        if(rd1)
            data1 <= IM[translated_addr1];
        if(rd2)
            data2 <=  IM[translated_addr2];
    end
    
    initial begin
        $readmemh("InstructionMemoryData.mem",IM);
    end
    
endmodule
