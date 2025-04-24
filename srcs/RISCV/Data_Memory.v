`timescale 1ns / 1ps

module Data_Memory(
    input Mem_Read,
    input Mem_Write,
    input [31:0] M_a,
    input [31:0] Mem_WriteData,
    input matrix_write,
    output reg [31:0] Mem_ReadData,
    input EX_MEM_load_matrix_A_en,
    input EX_MEM_load_matrix_B_en,
    input [31:0] R_11, R_12, R_13,
    input [31:0] R_21, R_22, R_23,
    input [31:0] R_31, R_32, R_33,
    
    output reg [12:0] A_11, A_12, A_13,
    output reg [12:0] A_21, A_22, A_23,
    output reg [12:0] A_31, A_32, A_33,
    output reg [12:0] B_11, B_12, B_13,
    output reg [12:0] B_21, B_22, B_23,
    output reg [12:0] B_31, B_32, B_33,
    
    
    input reset,
    output reg done_loading
    );
    
  
     wire [9:0] start_adrA,start_adrB;
    assign start_adrA    =  EX_MEM_load_matrix_A_en != 1'b0 ? M_a[9:0] : 10'b0000000000;
    assign start_adrB    =  EX_MEM_load_matrix_B_en != 1'b0 ? M_a[9:0] : 10'b0000000000;  
    
    parameter total_mem_reg = 64;
     reg [31:0] Data_Memory_Registers [total_mem_reg:0];
     
     
       initial begin
        $readmemh("mem_init.mem", Data_Memory_Registers);
    end
  
      always @(*
      
//      reset,Mem_Write,M_a,Mem_WriteData,Mem_Write,M_a,Mem_Read,matrix_write,EX_MEM_load_matrix_A_en,EX_MEM_load_matrix_B_en
      )
       begin

       if (EX_MEM_load_matrix_A_en)
        begin
         A_11 <= Data_Memory_Registers[start_adrA];    A_12 <= Data_Memory_Registers[start_adrA+1];  A_13 <= Data_Memory_Registers[start_adrA+2];
         A_21 <= Data_Memory_Registers[start_adrA+3];  A_22 <= Data_Memory_Registers[start_adrA+4];  A_23 <= Data_Memory_Registers[start_adrA+5];
         A_31 <= Data_Memory_Registers[start_adrA+6]; A_32 <= Data_Memory_Registers[start_adrA+7]; A_33 <= Data_Memory_Registers[start_adrA+8];
         
        end
       else if (EX_MEM_load_matrix_B_en)
       begin
         B_11 <= Data_Memory_Registers[start_adrA];    B_12 <= Data_Memory_Registers[start_adrA+1];  B_13 <= Data_Memory_Registers[start_adrA+2];
         B_21 <= Data_Memory_Registers[start_adrA+3];  B_22 <= Data_Memory_Registers[start_adrA+4];  B_23 <= Data_Memory_Registers[start_adrA+5];
         B_31 <= Data_Memory_Registers[start_adrA+6]; B_32 <= Data_Memory_Registers[start_adrA+7]; B_33 <= Data_Memory_Registers[start_adrA+8];
       end
       else if( reset==1 ) begin
//              Data_Memory_Registers[0] =8'h02;
//              Data_Memory_Registers[1] = 8'h00;
//              Data_Memory_Registers[2] = 8'h00; 
//              Data_Memory_Registers[3] = 8'h00;
//              Data_Memory_Registers[4] = 8'h04;
//              Data_Memory_Registers[5] = 8'h00;
//              Data_Memory_Registers[6] = 8'h00;
//              Data_Memory_Registers[7] = 8'h00;
//              Data_Memory_Registers[8] = 8'h08;
//              Data_Memory_Registers[9] = 8'h00;
//              Data_Memory_Registers[10] = 8'h00;
//              Data_Memory_Registers[11] = 8'h00;
//              Data_Memory_Registers[12] = 8'hC0;
//              Data_Memory_Registers[13] = 8'hD0;
//              Data_Memory_Registers[14] = 8'hE0;
//              Data_Memory_Registers[15] = 8'hF0;
//              Data_Memory_Registers[16] = 8'hFF;
              end
       else 
       begin
       if(Mem_Write == 1)
       Data_Memory_Registers[M_a] = Mem_WriteData;
       end
       
        begin 
        if (matrix_write) begin
         Data_Memory_Registers[total_mem_reg]    <= R_11; Data_Memory_Registers[total_mem_reg-1]   <= R_12; Data_Memory_Registers[total_mem_reg-2]   <= R_13;
         Data_Memory_Registers[total_mem_reg-3]  <= R_21; Data_Memory_Registers[total_mem_reg-4]   <= R_22; Data_Memory_Registers[total_mem_reg-5]   <= R_23; 
         Data_Memory_Registers[total_mem_reg-6] <= R_31; Data_Memory_Registers[total_mem_reg-7]  <= R_32; Data_Memory_Registers[total_mem_reg-8]  <= R_33;  
 end
        end
        done_loading<=1;
       end
    
endmodule