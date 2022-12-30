`timescale 1ns / 1ps
module UnitTesting_TB();

////Period set to 20ns
//localparam half_period = 1;

//reg clk=1, rst;
//reg [15:0]sw;
//wire [15:0]leds;
//reg [31:0]exp_data;

////Instantiating the module
//Processor_Wrapper DUT
//   (.clk(clk),
//    .leds(leds),
//    .rst(rst),
//    .sw(sw));

////For clock, with period 20ns
//always
//   #half_period clk = ~clk;

//task RESET; // task for resetting the processor
//begin
//    rst = 1;//resetting the processor
//    #half_period; #half_period;
//    #half_period; #half_period;
//    rst = 0;
//    #half_period;
//    #half_period;
//end
//endtask

//task WAIT;
//begin   
//     while(DUT.processor.S2.state!=DUT.processor.S2.ST_HALT)//waiting for the proecessor to finish
//        begin
//            #half_period;
//            #half_period;
//        end
//end
//endtask
////Validating the design using test cases
//initial
//    begin
//        RESET;
//        DUT.processor.S7.IM[0] = 
//        DUT.processor.S7.IM[1] =
       
        
 
//        $display("=============================");
//        $display("Status : Task Successfull");
//        $display("=============================");
//        $finish;
//    end



endmodule
