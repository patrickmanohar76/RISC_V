

`timescale 1ns / 1ps

module pc_adder(
    input [31:0] PC,
    output reg [31:0] PC_Incremented
    );
    // Pc increment adder
    always @(PC)
    begin
    PC_Incremented = PC+4 ;
    end
    
endmodule