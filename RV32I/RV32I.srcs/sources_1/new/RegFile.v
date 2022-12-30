//Github co-pilot was not used
//Provides a set of registers to be used in the processor
`timescale 1ns / 1ps
module RegFile(
    input clk,
    input en, we, l_s,
    input [31:0] pc_addr, ALU_out, DM_out,
    input [4:0] rd_addr, rs1_addr, rs2_addr,
    output reg [31:0] rs1_data, rs2_data);
    
    reg [31:0] regfile [0:31];
    
    initial begin
//        regfile[0]=0;
        $readmemh("RegFileData.mem",regfile);
    end
    
    always@(posedge clk)
    begin
        if(we)
        begin
            case(en)
            1'b0:regfile[rd_addr]<= pc_addr;
            1'b1:
            case(l_s)
                1'b1 : regfile[rd_addr]<= ALU_out;
                1'b0 : regfile[rd_addr]<= DM_out;
            endcase
            endcase            
        end
        else
        begin
            rs1_data <= regfile[rs1_addr];
            rs2_data <= regfile[rs2_addr];
        end 
    end
    
    
endmodule
