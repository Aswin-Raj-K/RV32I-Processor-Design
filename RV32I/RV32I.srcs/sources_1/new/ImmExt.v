//Github co-pilot was not used
`timescale 1ns / 1ps
module ImmExt(
input [31:0]data_in,
input [10:0]op,
output reg [31:0]data_out);

always@(*)
begin
    case(op[9:0])
    10'b1000000011 :  data_out <= {{24{1'b0}}, data_in[7:0]};
    10'b1010000011 :  data_out <= {{16{1'b0}}, data_in[15:0]};
    default:
        case(op[6:0])
           7'b0110111, 7'b0010111 : data_out <= {{12{1'b0}},data_in[19:0]};
           7'b1101111 : data_out <= {{12{data_in[19]}}, data_in[19:0]};
//           7'b0000011, 7'b0100011, 7'b0010011, 7'b1100011 
           default : data_out <= {{20{data_in[11]}}, data_in[11:0]};
        endcase
    endcase
    
end


endmodule
