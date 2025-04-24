`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 16:54:17
// Design Name: 
// Module Name: PE
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


module PE(IP_Up, IP_Left, Clk, Reset, OP_Down, OP_Right, Result);
	input [31:0] IP_Up, IP_Left;
	output reg [31:0] OP_Down, OP_Right;
	input Clk, Reset;
	output reg [63:0] Result;
	wire [63:0] Mult;
	always @(posedge Reset or posedge Clk) begin
		if(Reset) begin
			Result <= 0;
			OP_Right <= 0;
			OP_Down <= 0;
		end
		else begin
			Result <= Result + Mult;
			OP_Right <= IP_Left;
			OP_Down <= IP_Up;
		end
	end
	assign Mult = IP_Up*IP_Left;
endmodule
