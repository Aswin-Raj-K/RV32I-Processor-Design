//Github co-pilot was not used
`timescale 1ns / 1ps
module DataMemory(
    input clk, rst,
    input [3:0] we,
    input rd,
    input [31:0] addr, data_in, data_im,
    output [31:0] data_out, addr_im,
    output reg [15:0]leds,
    output rd_im,
    input [15:0]sw);
    
    
    reg [31:0] data_memory_start_addr = 32'h80000000,
    data_memory_end_addr = 32'h800003FF,
    switch_addr = 32'h00100010,
    led_addr = 32'h00100014,
    rom_start_addr = 32'h00100000,
    rom_end_addr = 32'h00100002,
    im_start_addr = 32'h01000000,
    im_end_addr = 32'h010007FF;
    
    localparam [2:0] BLOCK_DATA_MEMORY = 0, BLOCK_ROM = 1, BLOCK_SWITCH = 2, BLOCK_LED = 3, BLOCK_IM = 4;
    
    wire [31:0]translated_addr; //For storing the translated addr as we are using 32-bit block ram instead of 8-bit
    wire [2:0]block;
    reg [31:0]data;
    reg [31:0]data_memory[0:1023];//4KB
    reg [31:0]rom[0:2];   
    reg [15:0]switches;
    
    initial begin
        //Anish (N12499733)
        rom[0] <= 31'h00BEBB15;
        
        //Devashish (N19620681)
        rom[1] <= 31'h012B6349;
        
        //Aswin (N18913561)
        rom[2] <= 31'h12099919;
        
        leds <= 0;
        //Initializing data memory
        $readmemh("DataMemoryData.mem",data_memory);
    end
    
    assign block = (addr>=data_memory_start_addr && addr<=data_memory_end_addr)?BLOCK_DATA_MEMORY:
    (addr>=rom_start_addr && addr<=rom_end_addr)?BLOCK_ROM:
    (addr==switch_addr)?BLOCK_SWITCH:
    (addr==led_addr)?BLOCK_LED:
    (addr>=im_start_addr && addr<=im_end_addr)?BLOCK_IM:addr;
    
    assign translated_addr = (block == BLOCK_DATA_MEMORY)?((addr-data_memory_start_addr)>>2)://for data memory
                            (block == BLOCK_ROM)?((addr-rom_start_addr)>>2)://for rom
                            addr;//for others no need to translate addresss
    
    assign data_out = (block == BLOCK_IM)? data_im : data;
    assign addr_im = addr;
    assign rd_im = (block == BLOCK_IM);
    
    //Switches
    always@(posedge clk)
        switches <= sw;
    
   
    always@(posedge clk)
    begin
        if(rst)
            data <= 0;
        else
        begin 
            if(rd)
                case(block)
                    BLOCK_DATA_MEMORY : data <= data_memory[translated_addr];
                    BLOCK_SWITCH : data <= switches;
                    BLOCK_LED : data <= leds;
                    BLOCK_ROM : data <= rom[translated_addr];  
                endcase
            else //writing only for led and data memory
                if(block == BLOCK_LED)//for leds
                     leds <= data_in;
                else if(block == BLOCK_DATA_MEMORY)//to write a part of bits into block ram using mask
                  case(we)
                    4'b0001 : data_memory[translated_addr] <= (data_memory[translated_addr] & 32'hffffff00) | (data_in &  32'h000000ff);//for byte
                    4'b0011 : data_memory[translated_addr] <= (data_memory[translated_addr] & 32'hffff0000) | (data_in &  32'h0000ffff);//for half word
                    4'b1111 : data_memory[translated_addr] <= data_in; //for word
                  endcase
            end
   end  
    
endmodule
