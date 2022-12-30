//Github co-pilot was not used
//This module joins all the indiviual components of the processor
 
`timescale 1 ps / 1 ps 
module Processor_Top
   (clk,
    leds,
    rst,
    sw);
  input clk;
  output [15:0]leds;
  input rst;
  input [15:0]sw;

  wire [31:0]ALU_ALU_out;
  wire ALU_bc;
  wire ControlUnit_V2_ALU_s1;
  wire ControlUnit_V2_ALU_s2;
  wire ControlUnit_V2_DM_rd;
  wire [3:0]ControlUnit_V2_DM_we;
  wire ControlUnit_V2_IM_rd;
  wire ControlUnit_V2_PC_s;
  wire ControlUnit_V2_PC_we;
  wire ControlUnit_V2_l_s;
  wire [10:0]ControlUnit_V2_op;
  wire ControlUnit_V2_reg_s;
  wire ControlUnit_V2_reg_we;
  wire [31:0]DataMemory_data;
  wire [15:0]DataMemory_leds;
  wire [31:0]ImmExtension_data_out;
  wire [31:0]DataExtension_data_out;
  wire [31:0]InstructionDecoder_imm_data;
  wire [4:0]InstructionDecoder_rd_addr;
  wire [4:0]InstructionDecoder_rs1_addr;
  wire [4:0]InstructionDecoder_rs2_addr;
  wire [31:0]InstructionMemory_ins;
  wire [31:0]ProgramCounter_addr;
  wire [31:0]ProgramCounter_addr_next;
  wire [31:0]RegFile_rs1_data;
  wire [31:0]RegFile_rs2_data;
  wire clk_1;
  wire rst_1;
  wire [15:0]sw_1;
  wire [31:0]data_memory_addr_im;
  wire data_memory_rd_im;
  wire [31:0]im_data2;
  
  assign clk_1 = clk;
  assign leds[15:0] = DataMemory_leds;
  assign rst_1 = rst;
  assign sw_1 = sw[15:0];
   ALU S1
       (
       .clk(clk_1),
       .ALU_out(ALU_ALU_out),
        .addr(ProgramCounter_addr),
        .bc(ALU_bc),
        .en1(ControlUnit_V2_ALU_s1),
        .en2(ControlUnit_V2_ALU_s2),
        .imm_ext(ImmExtension_data_out),
        .op(ControlUnit_V2_op),
        .rs1_data(RegFile_rs1_data),
        .rs2_data(RegFile_rs2_data));
  ControlUnit_V2 S2
       (
       .ALU_s1(ControlUnit_V2_ALU_s1),
        .ALU_s2(ControlUnit_V2_ALU_s2),
        .DM_rd(ControlUnit_V2_DM_rd),
        .DM_we(ControlUnit_V2_DM_we),
        .IM_rd(ControlUnit_V2_IM_rd),
        .PC_s(ControlUnit_V2_PC_s),
        .PC_we(ControlUnit_V2_PC_we),
        .bc(ALU_bc),
        .clk(clk_1),
        .instr(InstructionMemory_ins),
        .l_s(ControlUnit_V2_l_s),
        .op(ControlUnit_V2_op),
        .reg_s(ControlUnit_V2_reg_s),
        .reg_we(ControlUnit_V2_reg_we),
        .rst(rst_1));
        
  DataMemory S3
       (.addr(ALU_ALU_out),
        .clk(clk_1),
        .data_out(DataMemory_data),
        .data_in(RegFile_rs2_data),
        .leds(DataMemory_leds),
        .rd(ControlUnit_V2_DM_rd),
        .rst(rst_1),
        .sw(sw_1),
        .we(ControlUnit_V2_DM_we),
        .addr_im(data_memory_addr_im),
        .rd_im(data_memory_rd_im),
        .data_im(im_data2));
        
  ImmExt S4
       (.data_in(InstructionDecoder_imm_data),
        .data_out(ImmExtension_data_out),
        .op(ControlUnit_V2_op));
  DataExt S5
       (.data_in(DataMemory_data),
        .data_out(DataExtension_data_out),
        .op(ControlUnit_V2_op));
  InstructionDecoder S6
       (.clk(clk_1),
        .imm_data(InstructionDecoder_imm_data),
        .instr(InstructionMemory_ins),
        .rd_addr(InstructionDecoder_rd_addr),
        .rs1_addr(InstructionDecoder_rs1_addr),
        .rs2_addr(InstructionDecoder_rs2_addr));
  InstructionMemory S7
       (
       .clk(clk_1),
       .addr1(ProgramCounter_addr),
        .data1(InstructionMemory_ins),
        .rd1(ControlUnit_V2_IM_rd),
        .rd2(data_memory_rd_im),
        .addr2(data_memory_addr_im),
        .data2(im_data2));
        
  ProgramCounter S8
       (.clk(clk_1),
       .ALU_in(ALU_ALU_out),
        .addr(ProgramCounter_addr),
        .addr_next(ProgramCounter_addr_next),
        .en(ControlUnit_V2_PC_s),
        .rst(rst_1),
        .we(ControlUnit_V2_PC_we));
  RegFile S9
       (.clk(clk_1),
       .ALU_out(ALU_ALU_out),
        .DM_out(DataExtension_data_out),
        .en(ControlUnit_V2_reg_s),
        .l_s(ControlUnit_V2_l_s),
        .pc_addr(ProgramCounter_addr_next),
        .rd_addr(InstructionDecoder_rd_addr),
        .rs1_addr(InstructionDecoder_rs1_addr),
        .rs1_data(RegFile_rs1_data),
        .rs2_addr(InstructionDecoder_rs2_addr),
        .rs2_data(RegFile_rs2_data),
        .we(ControlUnit_V2_reg_we));
endmodule
