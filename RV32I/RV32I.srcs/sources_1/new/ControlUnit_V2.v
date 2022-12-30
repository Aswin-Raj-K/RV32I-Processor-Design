//Github co-pilot is not
`timescale 1ns / 1ps
module ControlUnit_V2(
input clk, rst,
input [31:0]instr,
input bc,
output reg [10:0]op,
output reg [3:0] DM_we,
output reg ALU_s1, ALU_s2, PC_s, reg_s, reg_we, l_s, PC_we, DM_rd, IM_rd);

localparam ST_IDLE = 0, ST_FETCH = 1, ST_DECODE = 2, ST_ALU = 3, ST_REG = 4, ST_DM = 5, ST_INCREMENT = 6, ST_HALT = 7;
reg [2:0]state , next_state;

reg clk_cnt = 0; // for maintining a state for 2 clock state
reg bc_reg;
always@(posedge clk)
    bc_reg <= bc;

always@(posedge clk)
begin
    if(rst)//asynchronous active high reset
    begin
        state <= ST_IDLE;
        clk_cnt <= 0;
    end
    else
    begin
        if(~clk_cnt)
            state <= next_state;
        clk_cnt <= ~clk_cnt; 
    end 
end 

//next state logic
always@(*)
begin
        next_state<=ST_IDLE;
        case(state)
            ST_IDLE : next_state <= ST_FETCH;
            ST_FETCH : next_state <= ST_DECODE;
            ST_DECODE : case(instr[6:0])
                            7'b1101111, 7'b1100111 : next_state <= ST_REG; //JAL JALR
                            7'b1110011 : next_state <= ST_HALT; //EBREAK ECALL  
//                            7'b0110111, 7'b0010111, 7'b1100011, 7'b0000011, 7'b0100011, 7'b0010011, 7'b0110011 
                            default : next_state <= ST_ALU; //LUI AUIPC BRANCH LOAD STORE IMM LOGICAL_&_ARITHEMATIC
                        endcase 
            ST_ALU : case(instr[6:0])
                        7'b0000011, 7'b0100011 : next_state <= ST_DM; //LOAD STORE
                        7'b0110111, 7'b0010111, 7'b0010011, 7'b0110011, 7'b0001111 : next_state <= ST_REG; //LUI AUIPC IMM LOGICAL_&_ARITHEMATIC FENCE
                        7'b1101111, 7'b1100111, 7'b1100011 : next_state <= ST_INCREMENT; //JAL JALR BRANCH
                     endcase
            ST_REG : case(instr[6:0])
                        7'b0110111, 7'b0010111, 7'b0000011, 7'b0010011, 7'b0110011, 7'b0001111 : next_state <= ST_INCREMENT; //LUI AUIPC LOAD IMM LOGICAL_&_ARITHEMATICF FENCE
                        7'b1101111, 7'b1100111: next_state <= ST_ALU; //JAL JALR
                     endcase
            ST_DM : case(instr[6:0])
                        7'b0000011 : next_state <= ST_REG; //LOAD
                        default : next_state <= ST_INCREMENT; //STORE IMM
                    endcase
            ST_INCREMENT : next_state <= ST_FETCH;
            ST_HALT : next_state <= ST_HALT;
        endcase
end

//Control signals based on each state
always@(posedge clk)
begin
    if(~clk_cnt)
    begin
        case(next_state) 
            ST_FETCH : begin
                        PC_s <= 0; PC_we <= 0; DM_we <= 4'b0000; DM_rd <= 0; reg_we <= 0; IM_rd <= 1;
                       end
            ST_DECODE : begin
                            PC_s <= 0; PC_we <= 0; DM_we <= 4'b0000; DM_rd <= 0; reg_we <= 0; IM_rd <= 0;
                            case(instr[6:0])
                                7'b0110111, 7'b0010111, 7'b1101111, 7'b1100111 : op <= {4'b0000,instr[6:0]}; //LUI AUIPC JAL JALR 
                                7'b0110011 : op <= {instr[30], instr[14:12], instr[6:0]}; //ARITHEMATIC AND LOGICAL
                                7'b1100011, 7'b0000011, 7'b0100011: op <= {1'b0, instr[14:12], instr[6:0]}; //BRANCH LOAD STORE
                                7'b0010011 : case(instr[14:12]) //IMM
                                                3'b101 : op <= {instr[30], instr[14:12], instr[6:0]}; //SRLI SRAI
                                                default : op <= {1'b0, instr[14:12], instr[6:0]}; 
                                             endcase 
                            endcase
                        end
            ST_ALU : begin
                        PC_s <= 0; PC_we <= 0; DM_we <= 4'b0000; DM_rd <= 0; reg_we <= 0; IM_rd <= 0; 
                        case(instr[6:0])
                            7'b0110111 : begin //LUI (imm)
                                            ALU_s2 <= 1;
                                         end
                            7'b0010111, 7'b1101111 : begin //AUIPC JAL (PC & imm)
                                            ALU_s1 <= 0; ALU_s2 <= 1;
                                         end
                            7'b1100111, 7'b0000011, 7'b0100011, 7'b0010011, 7'b0001111 : begin //JALR LOAD STORE IMM (rs1 & imm) FENCE
                                            ALU_s1 <= 1; ALU_s2 <= 1;
                                         end
                            7'b1100011, 7'b0110011  : begin //JAL BRANCH LOGICAL_&_ARITHEMATIC (rs1 & rs2)
                                            ALU_s1 <= 1; ALU_s2 <= 0;
                                         end
                        endcase
                     end
            ST_REG : begin
                        DM_we <= 4'b0000; DM_rd <= 0;
                        case(instr[6:0])
                            7'b0110111, 7'b0010111, 7'b0010011, 7'b0110011, 7'b0001111 : begin //LUI AUIPC IMM LOGICAL_&_ARITHEMATIC(From ALU) FENCE
                                                        l_s <= 1; reg_s <= 1; reg_we <= 1;
                                                     end
                            7'b1101111, 7'b1100111 : begin //JAL JALR (From PC)
                                                        l_s <= 1; reg_s <= 0; reg_we <= 1;
                                                     end
                            7'b0000011 : begin //(From Data Memory)
                                            l_s <= 0; reg_s <= 1; reg_we <= 1;
                                         end 
                        endcase
                     end
            ST_DM : case(instr[6:0])
                        7'b0000011 : begin //READ
                                        DM_we <= 4'b0000; DM_rd <= 1;
                                     end
                        7'b0100011 : begin //STORE
                                         DM_rd <= 0;
                                         case(instr[14:12])
                                            3'b000 : DM_we <= 4'b0001;
                                            3'b001 : DM_we <= 4'b0011;
                                            3'b010 : DM_we <= 4'b1111; 
                                         endcase
                                     end  
                    endcase 
            ST_INCREMENT : begin 
                                PC_we <= 1; DM_we <= 4'b0000; DM_rd <= 0; reg_we <= 0; IM_rd <= 1;
                                case(instr[6:0])
                                    7'b1101111, 7'b1100111 : PC_s <= 1; //JAL //JALR (output from ALU)                    
                                    7'b1100011 : PC_s <= bc_reg; //BRANCH
                                    default : PC_s <= 0;//Increment by 4
                                endcase
                           end
            default : begin
                        PC_s <= 0; PC_we <= 0; DM_we <= 4'b0000; DM_rd <= 0; reg_we <= 0; IM_rd <= 0;
                      end
        endcase
    end
    else
    begin
        PC_s <= 0; PC_we <= 0; DM_we <= 4'b0000; DM_rd <= 0; reg_we <= 0; IM_rd <= 0;//default conditions when all are inactive
    end       
        
end

endmodule