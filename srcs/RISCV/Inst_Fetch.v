`timescale 1ns / 1ps

module Inst_Fetch(
    input reset,
    output[31:0] instructioncode,
    input [31:0] PC
    );
       
 
   //Instantiating the instructon memory
    Instructionmem Im (PC,reset,instructioncode);
endmodule