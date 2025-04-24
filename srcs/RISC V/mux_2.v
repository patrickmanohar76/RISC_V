`timescale 1ns / 1ps

module jump_sel_mux(
   input [31:0] inst_code,
   output reg jump_pc_sel
    );
    // To select the jump address 
    // JUMP selection input for jump address in PC
    always @(inst_code)
    begin
    if(inst_code[6:0] == 7'b1101111)
    jump_pc_sel = 1;
    else
    jump_pc_sel= 0;
    
    end
endmodule