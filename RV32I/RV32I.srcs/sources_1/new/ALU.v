//Github co-piolot was not used
`timescale 1ns / 1ps												//Co-pilot not used

module ALU(
            input clk,
            input[10:0]op,											//Port declarations
			input en1,en2,
			input [31:0] rs1_data,rs2_data, addr,
			input signed [31:0] imm_ext,            
			output [31:0] ALU_out, output bc);
			
wire [31:0] mux1,mux2;												//wires and registers
reg [31:0] temp;
reg bc_temp = 1'b0 ;
wire signed [31:0] rs1_data_signed, rs2_data_signed;

assign rs1_data_signed = rs1_data;//converting the data rs1 for signed operations
assign rs2_data_signed = rs2_data;//converting the data rs2 for signed operations
assign mux1 = en1?rs1_data:addr;										//Combinational logic for inputs to the alu
assign mux2 = en2?imm_ext:rs2_data;

always@(posedge clk)
    begin
        case(op)													//Case statement with Operation signal, Op detemines what operation to be performed
            11'b00000110111 : temp <= {mux2[19:0],12'b0};
            11'b00000010111 : temp <= mux1+{mux2[19:0],12'b0};
            11'b00001101111 : begin
                                temp <= mux1 + mux2;
                              end 
            11'b00001100111 : begin 
                                temp <= mux1 + mux2;
                              end
            11'b00001100011 : if(mux1 <= mux2)
                              begin
                                temp <= addr + imm_ext;
                                bc_temp <= 1'b1;
                              end 
                              else   
                                bc_temp <= 1'b0;
            11'b00011100011 : if(mux1 != mux2)
                              begin
                                temp <= (addr+imm_ext);
                                bc_temp <= 1'b1;
                              end 
                              else
                                bc_temp <= 1'b0;   
            11'b01001100011 : if(rs1_data_signed < rs2_data_signed)
                                begin
                                    temp <= (addr+imm_ext);
                                    bc_temp <= 1'b1;
                                end 
                              else
                                    bc_temp <= 1'b0;
            11'b01011100011 : if(rs1_data_signed >= rs2_data_signed)
                                begin
                                    temp <= (addr+imm_ext);
                                    bc_temp <= 1'b1;
                                end 
                              else
                                    bc_temp <= 1'b0;
            11'b01101100011 : if(mux1 < mux2)
                                begin
                                    temp <= (addr+imm_ext);
                                    bc_temp <= 1'b1;
                                end 
                              else
                                    bc_temp <= 1'b0; 
            11'b01111100011 : if(mux1 >= mux2)
                                begin
                                    temp <= (addr+imm_ext);
                                    bc_temp <= 1'b1;
                                end 
                              else
                                    bc_temp <= 1'b0;
            11'b00000000011, 11'b00010000011, 11'b00100000011, 11'b01000000011, 11'b01010000011, 11'b00000001111 : temp <= rs1_data + imm_ext; 
            11'b00000100011, 11'b00010100011, 11'b00100100011, 11'b00000010011 : temp <= rs1_data + imm_ext;
            11'b00100010011 : temp <= (rs1_data_signed < imm_ext) ? 1:0;//SLTI
            11'b00110010011 : temp <= (rs1_data < imm_ext) ? 1:0; //SLTIU
            11'b01000010011 : temp <= rs1_data^imm_ext ; //XORI
            11'b01100010011 : temp <= rs1_data | imm_ext ; //ORI
            11'b01110010011 : temp <= rs1_data & imm_ext ; //ANDI
            11'b00010010011 : temp <= rs1_data << imm_ext[4:0] ; //SLLI
            11'b01010010011 : temp <= rs1_data >> imm_ext[4:0] ; //SRLI
            11'b11010010011 : temp <= rs1_data_signed >> imm_ext[4:0] ; //SRAI
            11'b00000110011 : temp <= rs1_data + rs2_data ; //ADD
            11'b10000110011 : temp <= rs1_data - rs2_data ; //SUB
            11'b00010110011 : temp<= rs1_data << rs2_data[4:0]; 
//            case(rs2_data[4:0])  //SLL (temp<=rs1_data << rs2_data[4:0], logic left shift) changed to circular left shift for RC5 
//                                1 : temp <= {rs1_data[30:0], rs1_data[31]};
//                                2 : temp <= {rs1_data[29:0], rs1_data[31:30]};
//                                3 : temp <= {rs1_data[28:0], rs1_data[31:29]};
//                                4 : temp <= {rs1_data[27:0], rs1_data[31:28]};
//                                5 : temp <= {rs1_data[26:0], rs1_data[31:27]};
//                                6 : temp <= {rs1_data[25:0], rs1_data[31:26]};
//                                7 : temp <= {rs1_data[24:0], rs1_data[31:25]};
//                                8 : temp <= {rs1_data[23:0], rs1_data[31:24]};
//                                9 : temp <= {rs1_data[22:0], rs1_data[31:23]};
//                                10 : temp <= {rs1_data[21:0], rs1_data[31:22]};
//                                11 : temp <= {rs1_data[20:0], rs1_data[31:21]};
//                                12 : temp <= {rs1_data[19:0], rs1_data[31:20]};
//                                13 : temp <= {rs1_data[18:0], rs1_data[31:19]};
//                                14 : temp <= {rs1_data[17:0], rs1_data[31:18]};
//                                15 : temp <= {rs1_data[16:0], rs1_data[31:17]};
//                                16 : temp <= {rs1_data[15:0], rs1_data[31:16]};
//                                17 : temp <= {rs1_data[14:0], rs1_data[31:15]};
//                                18 : temp <= {rs1_data[13:0], rs1_data[31:14]};
//                                19 : temp <= {rs1_data[12:0], rs1_data[31:13]};
//                                20 : temp <= {rs1_data[11:0], rs1_data[31:12]};
//                                21 : temp <= {rs1_data[10:0], rs1_data[31:11]};
//                                22 : temp <= {rs1_data[9:0], rs1_data[31:10]};
//                                23 : temp <= {rs1_data[8:0], rs1_data[31:9]};
//                                24 : temp <= {rs1_data[7:0], rs1_data[31:8]};
//                                25 : temp <= {rs1_data[6:0], rs1_data[31:7]};
//                                26 : temp <= {rs1_data[5:0], rs1_data[31:6]};
//                                27 : temp <= {rs1_data[4:0], rs1_data[31:5]};
//                                28 : temp <= {rs1_data[3:0], rs1_data[31:4]};
//                                29 : temp <= {rs1_data[2:0], rs1_data[31:3]};
//                                30 : temp <= {rs1_data[1:0], rs1_data[31:2]};
//                                31 : temp <= {rs1_data[0], rs1_data[31:1]};
//                                default : temp <= rs1_data;
//                              endcase
            11'b00100110011 : temp <= (rs1_data_signed < rs2_data_signed)? 1:0 ; //SLT
            11'b00110110011 : temp <= (rs1_data < rs2_data)? 1:0 ; //SLTU
            11'b01000110011 : temp <= rs1_data^rs2_data ; //XOR
            11'b01010110011 : temp <= rs1_data >> rs2_data[5:0] ; //SRL
            11'b11010110011 : temp <= rs1_data_signed >>> rs2_data[5:0] ;//SRA 
            11'b01100110011 : temp <= rs1_data | rs2_data ; //OR
            11'b01110110011 : temp <= rs1_data & rs2_data ; //AND 
            default : begin
                        bc_temp <= bc_temp;
                        temp <=temp;
                      end      
        endcase    
    end
assign ALU_out = temp;//Combinational logic for output			
assign bc = bc_temp;
endmodule

