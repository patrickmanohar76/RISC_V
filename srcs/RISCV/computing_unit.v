`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2024 03:36:45 PM
// Design Name: 
// Module Name: computing_unit
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


module computing_unit(
input [31:0] a,//operand 1
input [31:0] b,//operand 2
input id_ex_activate_mul_module,
input [3:0] acl,//alu control unit
output reg[31:0] result,//alu result
output reg Zero//zero flag
    );
    wire [31:0] aluresult,mulresult;
    
    aluunit alu(a,b,acl,aluresult);
    mul_unit mu(a,b,acl,mulresult);
    
    
    always @(aluresult,mulresult,id_ex_activate_mul_module)
    begin
    case(id_ex_activate_mul_module)
    0:result=aluresult;
    1:result=mulresult;
    endcase
    end
    
    
    always @(result)
    begin
      if(result==0)
      Zero=1;//Setting zero flag if the output of computing unit is zero
      else
      Zero=0;
      end
      
     
endmodule
