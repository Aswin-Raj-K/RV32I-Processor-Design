//Github co-pilot was not used
//Deocodes the instruction into its components
`timescale 1ns / 1ps
module InstructionDecoder(
    input clk,
    input [31:0] instr,
    output reg [4:0] rd_addr, rs1_addr, rs2_addr,
    output reg [31:0] imm_data
    );
    
    always@(posedge clk)
    begin
        case(instr[6:0])
            7'b0110111, 7'b0010111 : begin //LUI AUIPC
                                        imm_data <= instr[31:12];
                                        rd_addr <= instr[11:7];
                                     end 
            7'b1101111 : begin //JAL
                            imm_data <= {instr[31],instr[19:12],instr[20],instr[30:21]};
                            rd_addr <= instr[11:7];
                         end
            7'b1100111 : begin //JALR
                            imm_data <= instr[31:20];
                            rs1_addr <= instr[19:15];
                            rd_addr <= instr[11:7];
                         end
            7'b1100011 : begin //BRANCH
                            imm_data <= {instr[31], instr[7],instr[30:25],instr[11:8]};
                            rs1_addr <= instr[19:15];
                            rs2_addr <= instr[24:20];
                         end
            7'b0000011 : begin //LOAD
                            imm_data <= instr[31:20];
                            rs1_addr <= instr[19:15];
                            rd_addr <= instr[11:7];
                         end
            7'b0100011 : begin //STORE
                            imm_data <= {instr[31:25],instr[11:7]};
                            rs1_addr <= instr[19:15];
                            rs2_addr <= instr[24:20];
                         end
            7'b0010011 : begin
                            rs1_addr <= instr[19:15];
                            rd_addr <= instr[11:7];
                            case(instr[14:12])
                                3'b101, 3'b001 : imm_data <= instr[24:20]; //SHIFT
                                default : imm_data <= instr[31:20]; //IMM
                            endcase
                         end
            7'b0110011 : begin //ARITHEMATIC AND LOGICAL 
                            rs1_addr <= instr[19:15];
                            rs2_addr <= instr[24:20];                            
                            rd_addr <= instr[11:7];
                         end  
        endcase
    end
    
    
    
    
    
    
    
endmodule