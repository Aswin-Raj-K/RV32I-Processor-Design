//Github co-pilot was not used
`timescale 1ns / 1ps
module DataExt(
input [31:0]data_in,
input [10:0]op,
output reg [31:0]data_out);

always@(*)
begin
    case(op[9:7])
        3'b000 : data_out <= {{24{data_in[7]}}, data_in[7:0]}; //LB
        3'b001 : data_out <= {{16{data_in[15]}}, data_in[15:0]}; //LH
        3'b100 : data_out <= {{24{1'b0}}, data_in[7:0]}; //LBU
        3'b101 : data_out <= {{16{1'b0}}, data_in[15:0]}; //LHU
        default : data_out <= data_in; //LW
    endcase
    
end


endmodule
