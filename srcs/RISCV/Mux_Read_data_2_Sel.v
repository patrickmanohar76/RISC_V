`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 08:05:35 AM
// Design Name: 
// Module Name: Mux_Read_data_2_Sel
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


module Mux_Read_data_2_Sel(
    input [1:0] If_Id_Read_Data_2_Sel,
    input [31:0] Id_0_Ex_Sign_Ex,
    input [31:0] ID_EX_Read_Data_2,
    output reg  [31:0] Mux_selected_read_Data
    );
    always @(If_Id_Read_Data_2_Sel,
        Id_0_Ex_Sign_Ex,
        ID_EX_Read_Data_2)
    begin
    if(If_Id_Read_Data_2_Sel ==2'b01)
    Mux_selected_read_Data =ID_EX_Read_Data_2; // for r-type , branch instructions
    else
    Mux_selected_read_Data = Id_0_Ex_Sign_Ex;  // for i-type , load and store instructions - immediate data or address
    end
endmodule