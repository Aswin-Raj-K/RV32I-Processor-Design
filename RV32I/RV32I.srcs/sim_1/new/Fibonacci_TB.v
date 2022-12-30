//Github Co-pilot is not used
//For this testing the processor generates fibonacci series and store it in the regfile[3] register. 
//This test bench will check if the fibonacci series created is as expected.
`timescale 100ps / 1ps  
module Fibonacci_TB();

//Period set to 20ns
localparam half_period = 1;

reg clk=1, rst;
reg [15:0]sw;
wire [15:0]leds;
reg [31:0]exp_data;

//Instantiating the module
Processor_Wrapper DUT
   (.clk(clk),
    .leds(leds),
    .rst(rst),
    .sw(sw));

integer value = 0;
reg[45:0] t1 = 0, t2 = 1, t3 = 1; //For generating fibonacci sequence
integer i = 0;

//For clock, with period 20ns
always
   #half_period clk = ~clk;

//Validating the design using test cases
initial
    begin
        $readmemh("Fibonacci_InstructionSet.mem",DUT.processor.S7.IM); //Loading the instruction set for fibonacci
        rst = 1;//resetting the processor
        #half_period #half_period
        #half_period #half_period
        rst = 0;
        #half_period
        #half_period
        $display("==================RESULT===================");
        
        while(DUT.processor.S9.regfile[3]!=1)//waiting for the first fibonacci number to be initialized
        begin
            #half_period;
            #half_period;
        end
        
        while(i<=45)//The maximum we can check is i=45(i.e reg[3] = 1836311903) after which bit overflow will occur
        begin
            #half_period
            #half_period
            if(value!=DUT.processor.S9.regfile[3])
            begin
                if(t3!=DUT.processor.S9.regfile[3])
                begin
                    $display("Status : Task Failed");
                    $display("=============================");
                    $finish;
                end
                $display("%d) reg[3] = %d, exp_reg[3] = %d",i+1,DUT.processor.S9.regfile[3], t3);
                t1 = t2;
                t2 = t3;
                t3 = t1 + t2;
                i=i+1;
            end
            value = DUT.processor.S9.regfile[3];
        end
        $display("=============================");
        $display("Status : Task Successfull");
        $display("=============================");
        $finish;
    end

endmodule
