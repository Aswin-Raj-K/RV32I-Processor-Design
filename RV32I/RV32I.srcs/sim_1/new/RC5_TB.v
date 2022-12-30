//Github Co-pilot is not used
//For this testing the processor encryptes the data using RC5 and store it in the regfile[0] and regfile[1] (A & B respectively) register. 
//RC5_EncryptionKey.mem contains the RC5 encryption keys
//RC5_InstructionSet.mem contains the code for RC5
`timescale 100ps / 1ps  
module RC5_TB();

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

//The code to encrypt
reg [63:0]codeToEncrypt = 64'hd73ca68e21fee44f;

reg [31:0]A,B;
//For clock, with period 20ns
always
   #half_period clk = ~clk;

//Validating the design using test cases
initial
    begin
        $readmemh("RC5_InstructionSet.mem",DUT.processor.S7.IM); //Loading the instruction set for RC5 encryption
        $readmemh("RC5_EncryptionKeys.mem",DUT.processor.S3.data_memory); //Loading the data memory with RC5 encryption keys
        A = codeToEncrypt[63:32];
        B = codeToEncrypt[31:0];
        DUT.processor.S9.regfile[1] = A;
        DUT.processor.S9.regfile[2] = B;
        //Resetting the processor
        rst = 1; 
        repeat(4)#half_period
        rst = 0;
        #half_period
        #half_period
        $display("==================RESULT===================");
        
        while(DUT.processor.S2.state!=DUT.processor.S2.ST_HALT)//waiting for the result
        begin
            #half_period;
            #half_period;
        end
       $display("Code to encrypt is %h",codeToEncrypt); 
       $display("Encrypted Code is %h",{DUT.processor.S9.regfile[1],DUT.processor.S9.regfile[2]});
       $display("===========================================");
    end

endmodule
