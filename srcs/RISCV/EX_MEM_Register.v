`timescale 1ns / 1ps

module EX_MEM_Register(
    input clk,
    input reset,
    input [4:0] Ex_In_Mem_Rs1,
    input [4:0] Ex_In_Mem_Rs2,
    input [4:0] Ex_In_Mem_Rd,
    input [31:0] Ex_In_Aluresult,
    input Ex_In_Mem_Reg_Write,
    input [1:0] Ex_In_Mem_Output_Select,
    output reg [4:0] Ex_Out_Mem_Rs1,
    output reg [4:0] Ex_Out_Mem_Rs2,
    output reg [4:0] Ex_Out_Mem_Rd,
    output reg [31:0] Ex_Out_Aluresult,
    output reg Ex_Out_Mem_Reg_Write,
    output reg [1:0] Ex_Out_Mem_Output_Select,
    input Ex_In_Mem_MemWrite,
    input Ex_In_Mem_MemRead,
    output reg Ex_O_Mem_MemWrite,
    output reg Ex_O_Mem_MemRead,
    input [31:0] Ex_In_Mem_ReadData2,
    output reg [31:0] Ex_Out_Mem_ReadData2,
    input ID_EX_load_matrix_A_en,
    input ID_EX_load_matrix_B_en,
    output reg EX_MEM_load_matrix_A_en,
    output reg EX_MEM_load_matrix_B_en
    );
    
     always @(posedge clk)
       begin
       if(reset == 1)
       begin
       Ex_Out_Mem_Rs1 = 5'b00000;
       Ex_Out_Mem_Rs2 = 5'b00000;
       Ex_Out_Mem_Rd = 5'b00000;
       Ex_Out_Aluresult = 32'h0000;
       Ex_Out_Mem_Reg_Write = 1'b0;
       Ex_Out_Mem_Output_Select = 2'b00;
       Ex_O_Mem_MemWrite =2'b0;
       Ex_O_Mem_MemRead= 2'b0;
       Ex_Out_Mem_ReadData2 = 32'h0000;
       EX_MEM_load_matrix_A_en = 1'b0;
       EX_MEM_load_matrix_B_en = 1'b0;
       end
       else
       begin
       Ex_Out_Mem_Rs1 =Ex_In_Mem_Rs1;
       Ex_Out_Mem_Rs2 =Ex_In_Mem_Rs2;
       Ex_Out_Mem_Rd=Ex_In_Mem_Rd;
       Ex_Out_Aluresult=Ex_In_Aluresult;
       Ex_Out_Mem_Reg_Write = Ex_In_Mem_Reg_Write;
       Ex_Out_Mem_Output_Select = Ex_In_Mem_Output_Select;
       Ex_O_Mem_MemWrite =Ex_In_Mem_MemWrite;
       Ex_O_Mem_MemRead=Ex_In_Mem_MemRead;
       Ex_Out_Mem_ReadData2 = Ex_In_Mem_ReadData2;
       EX_MEM_load_matrix_A_en = ID_EX_load_matrix_A_en;
       EX_MEM_load_matrix_B_en = ID_EX_load_matrix_B_en;
       end
       end
endmodule