`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 03:42:34 PM
// Design Name: 
// Module Name: mul_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mul_unit(
input [31:0] a,//operand 1
input [31:0] b,//operand 2
input [3:0] acl,//alu control unit- used same control for mul too
output reg[31:0] mulresult//alu result
    );
    wire [63:0] mult=a*b; 
    always @(*)
    begin
    case(acl)
    4'b0000:mulresult=mult[31:0];
    4'b0001:mulresult=mult[63:32];
    4'b0100:mulresult=a/b;
    4'b0110:mulresult=a%b;
    endcase
    end
endmodule
