`timescale 1ns / 1ps

module addresscal(
    input [31:0] PC,
input [31:0] immmediate_value,
output reg [31:0] address 
);

// address calculation for jump and branch
always @ (PC,immmediate_value)
begin
address =PC + immmediate_value;
end
endmodule