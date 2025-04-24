`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 05:03:22 PM
// Design Name: 
// Module Name: beq_check
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


module beq_check(
    input [31:0]If_Id_inst_code,
    input [31:0] R1 ,
    input [31:0] R2 ,
    output reg beq_select
    );
    // comparator unit for static branch prediction
    reg [31:0] R3 ;
    always @(R1,R2,If_Id_inst_code)
    begin
    
    if(If_Id_inst_code[6:0] == 7'b1100011)
        begin
        case(If_Id_inst_code[14:12])
        0           : if(R1==R2) beq_select = 1'b1;
        1           : if(R1!=R2) beq_select = 1'b1;
        4           : if(R1<R2)  beq_select = 1'b1;
        5           : if(R1>=R2) beq_select = 1'b1 ;
        default     : beq_select = 1'b0;
        endcase
   // $display("branched");
    end
    
    else
    beq_select = 1'b0;
    end
    

  
    
    
endmodule