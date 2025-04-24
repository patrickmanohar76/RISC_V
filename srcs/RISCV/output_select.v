`timescale 1ns / 1ps
module output_select(
    input [1:0] control_signal,
    input [31:0] alu_output,
    input [31:0] Mem_ReadData,input reset,
    //output reg [31:0] processor_output,
    output reg [31:0] p_o,output reg flag
    );  reg [31:0] processor_output;
    reg [1:0] check;
    //Mux to select the load immediate data or alu result based on opcode
    always @(reset,control_signal,alu_output,Mem_ReadData)
    begin
    if(reset==1)
    flag=0;
    else
    begin
    if(control_signal==2'b01)
    begin
    check = 2'b01;
    //select alu ouput
    processor_output = alu_output;
    p_o=processor_output;flag=1;
    end
    else if(control_signal==2'b10)
    begin
    //select load immediate output
    processor_output=Mem_ReadData;
    check = 2'b00;
        p_o=processor_output;flag=1;
end
else begin
 processor_output=processor_output;;
   check = 2'b10;
       p_o=processor_output;flag=0;


end
    end
    end
endmodule