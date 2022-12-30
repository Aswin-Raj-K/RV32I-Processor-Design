//Github co-pilot was not used 
//This is the wrapper module for the processor. This also contains a clock divider.
`timescale 1 ps / 1 ps
module Processor_Wrapper
   (clk,
    leds,
    rst,
    sw);
  input clk;
  output [15:0]leds;
  input rst;
  input [15:0]sw;

  wire clk;
  wire [15:0]leds;
  wire rst;
  wire [15:0]sw;
  
//For cloc divider to see the result on board
//  reg[31:0] cnt; 
//  reg clk1 = 0; 
//  always@(posedge clk)
//  begin
//    cnt = cnt + 1;
//    if(cnt[31])
//        clk1 = ~clk1;
//  end  
    
    
  Processor_Top processor
       (.clk(clk),
        .leds(leds),
        .rst(rst),
        .sw(sw));
endmodule
