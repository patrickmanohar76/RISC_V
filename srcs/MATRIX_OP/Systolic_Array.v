`timescale 1ns / 1ps
////////////////////////////////////////
//// Company: 
//// Engineer: 
 
//// Create Date: 14.04.2025 16:55:12
//// Design Name: 
//// Module Name: Systolic_Array
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
 
//// Dependencies: 
 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
 



module Systolic_Array(IP_Left0, IP_Left4, IP_Left8, IP_Left12,
		      IP_Up0, IP_Up1, IP_Up2, IP_Up3,Result0, 
		      Result1, Result2, Result3, Result4, Result5, Result6, Result7, 
		      Result8, Result9, Result10, Result11, Result12, Result13, Result14, Result15
		      ,Clk, Reset, Done);
	
	input [31:0] IP_Left0, IP_Left4, IP_Left8, IP_Left12,
		      IP_Up0, IP_Up1, IP_Up2, IP_Up3;
	output reg Done;
	output [63:0] Result0, Result1, Result2, Result3, Result4, Result5, 
	Result6, Result7, Result8, Result9, Result10, Result11, Result12, Result13, Result14, Result15;
	input Clk, Reset;
	reg [3:0] Count;
	
	
	
	wire [31:0] IP_Up0, IP_Up1, IP_Up2, IP_Up3;
	wire [31:0] IP_Left0, IP_Left4, IP_Left8, IP_Left12;
	wire [31:0] OP_Down0, OP_Down1, OP_Down2, OP_Down3, OP_Down4, OP_Down5, OP_Down6, OP_Down7, OP_Down8, OP_Down9, OP_Down10, OP_Down11, OP_Down12, OP_Down13, OP_Down14, OP_Down15;
	wire [31:0] OP_Right0, OP_Right1, OP_Right2, OP_Right3, OP_Right4, OP_Right5, OP_Right6, OP_Right7, OP_Right8, OP_Right9, OP_Right10, OP_Right11, OP_Right12, OP_Right13, OP_Right14, OP_Right15;
	
	
	
	
	from north and west
	PE P0 (IP_Up0, IP_Left0, Clk, Reset, OP_Down0, OP_Right0, Result0);
	from north
	PE P1 (IP_Up1, OP_Right0, Clk, Reset, OP_Down1, OP_Right1, Result1);
	PE P2 (IP_Up2, OP_Right1, Clk, Reset, OP_Down2, OP_Right2, Result2);
	PE P3 (IP_Up3, OP_Right2, Clk, Reset, OP_Down3, OP_Right3, Result3);
	
	from west
	PE P4 (OP_Down0, IP_Left4, Clk, Reset, OP_Down4, OP_Right4, Result4);
	PE P8 (OP_Down4, IP_Left8, Clk, Reset, OP_Down8, OP_Right8, Result8);
	PE P12 (OP_Down8, IP_Left12, Clk, Reset, OP_Down12, OP_Right12, Result12);
	
	no direct inputs
	second row
	PE P5 (OP_Down1, OP_Right4, Clk, Reset, OP_Down5, OP_Right5, Result5);
	PE P6 (OP_Down2, OP_Right5, Clk, Reset, OP_Down6, OP_Right6, Result6);
	PE P7 (OP_Down3, OP_Right6, Clk, Reset, OP_Down7, OP_Right7, Result7);
	third row
	PE P9 (OP_Down5, OP_Right8, Clk, Reset, OP_Down9, OP_Right9, Result9);
	PE P10 (OP_Down6, OP_Right9, Clk, Reset, OP_Down10, OP_Right10, Result10);
	PE P11 (OP_Down7, OP_Right10, Clk, Reset, OP_Down11, OP_Right11, Result11);
	fourth row
	PE P13 (OP_Down9, OP_Right12, Clk, Reset, OP_Down13, OP_Right13, Result13);
	PE P14 (OP_Down10, OP_Right13, Clk, Reset, OP_Down14, OP_Right14, Result14);
	PE P15 (OP_Down11, OP_Right14, Clk, Reset, OP_Down15, OP_Right15, Result15);
	
	always @(posedge Clk or posedge Reset) begin
		if(Reset) begin
			Done <= 0;
			Count <= 0;
		end
		else begin
			if(Count == 9) begin
				Done <= 1;
				Count <= 0;
			end
			else begin
				Done <= 0;
				Count <= Count + 1;
			end
		end	
	end 
	
		      
endmodule


