`timescale 1ns / 1ps

module Data_Memory(
    input Mem_Read,
    input Mem_Write,
    input [31:0] M_a,
    input [31:0] Mem_WriteData,
    output reg [31:0] Mem_ReadData,
    input reset
    );
    
    reg [7:0] DM [16:0];
    
  
      always @(reset,Mem_Write,M_a,Mem_WriteData,Mem_Write,M_a,Mem_Read)
       begin
        begin
          if(Mem_Read ==1)
          Mem_ReadData = {DM[M_a+3],DM[M_a+2],DM[M_a+1],DM[M_a]}; // Reading the data from memory
          end
          
          if( reset==1 ) begin
              DM[0] =8'h02;
              DM[1] = 8'h00;
              DM[2] = 8'h00; 
              DM[3] = 8'h00;
              DM[4] = 8'h04;
              DM[5] = 8'h00;
              DM[6] = 8'h00;
              DM[7] = 8'h00;
              DM[8] = 8'h08;
              DM[9] = 8'h00;
              DM[10] = 8'h00;
              DM[11] = 8'h00;
              DM[12] = 8'hC0;
              DM[13] = 8'hD0;
              DM[14] = 8'hE0;
              DM[15] = 8'hF0;
              DM[16] = 8'hFF;
              end
       else
       begin
       if(Mem_Write == 1)
       {DM[M_a+3],DM[M_a+2],DM[M_a+1],DM[M_a]} = Mem_WriteData;
       end
       
       end
    
endmodule