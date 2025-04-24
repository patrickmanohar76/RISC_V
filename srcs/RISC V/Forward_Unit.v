`timescale 1ns / 1ps

module Forward_Unit(
    input Mem_0_Wb_MemRead,
    input Ex_Out_Mem_Reg_Write,
    input [4:0] Ex_Out_Mem_writereg,
    input Mem_Out_Wb_Reg_Write,
    input [4:0] Mem_Out_Wb_writereg,
    input [4:0] Id_Out_Ex_Rs1,
    input [4:0] Id_Out_Ex_Rs2,
    input Id_O_Ex_MemWrite,
    input [6:0] Id_O_Ex_opcode,
    output reg [1:0] Forward_Rs1,
    output reg [1:0] Forward_Rs2,
    output reg [1:0] Forward_Rs1_to_Id,
    output reg [1:0] Forward_Rs2_to_Id,
    input Ex_O_Mem_MemWrite,
    input [4:0] Ex_O_Mem_Rs2,
    output reg Fwd_Mem_to_Mem,
    input [6:0]opcocde,
    input [4:0]If_Id_Rs2,
    input [4:0]If_Id_Rs1
    );
    
        always@(*)
        begin
        // ex to ex forwarding
        if( (Ex_Out_Mem_Reg_Write ==1)&(Ex_Out_Mem_writereg!=3'b000)&(Ex_Out_Mem_writereg==Id_Out_Ex_Rs1))
        Forward_Rs1 =2'b01 ;
        // mem to ex forwarind
        else if ((Mem_Out_Wb_Reg_Write ==1)&(Mem_Out_Wb_writereg!=5'b00000)&(Mem_Out_Wb_writereg==Id_Out_Ex_Rs1))
        Forward_Rs1 =2'b10 ;
       // when forwarding is not required 
        else 
        Forward_Rs1 =2'b00;
        
        // ex to ex forwarding
        if( (Ex_Out_Mem_Reg_Write ==1)&(Ex_Out_Mem_writereg!=5'b00000)&(Ex_Out_Mem_writereg==Id_Out_Ex_Rs2)&(Id_O_Ex_opcode != 7'b0010011))
        Forward_Rs2 =2'b01 ;
        // mem to ex forwarding
        else if ((Mem_Out_Wb_Reg_Write ==1)&(Mem_Out_Wb_writereg!=5'b00000)&(Mem_Out_Wb_writereg==Id_Out_Ex_Rs2)&(Id_O_Ex_opcode != 7'b0010011))
        Forward_Rs2 =2'b10 ;
         // when forwarding is not required 
        else 
        Forward_Rs2 =2'b00;
        
         // ex to id forwarding
         if  (opcocde == 7'b1100011 &Ex_Out_Mem_Reg_Write == 1'b1 & Ex_Out_Mem_writereg==If_Id_Rs1 &Ex_Out_Mem_writereg!=5'b00000 )
         Forward_Rs1_to_Id = 2'b01;
         // mem to id forwarding
         else if (opcocde == 7'b1100011 &Mem_Out_Wb_Reg_Write == 1'b1 & Mem_Out_Wb_writereg==If_Id_Rs1 &Mem_Out_Wb_writereg!=5'b00000 ) 
         Forward_Rs1_to_Id = 2'b10;
         // when no forarding is required
         else
         Forward_Rs1_to_Id = 2'b00;
         
         // ex to id forwarding
          if  (opcocde == 7'b1100011 &Ex_Out_Mem_Reg_Write == 1'b1 & Ex_Out_Mem_writereg==If_Id_Rs2 &If_Id_Rs1!=5'b00000 )
          Forward_Rs2_to_Id = 2'b01;
          // mem to id forwarding
          else if (opcocde == 7'b1100011 &Mem_Out_Wb_Reg_Write == 1'b1 & Mem_Out_Wb_writereg==If_Id_Rs2 &If_Id_Rs1!=5'b00000 ) 
          Forward_Rs2_to_Id = 2'b10;
          // when no forarding is required
          else
          Forward_Rs2_to_Id = 2'b00;
        
            // mem to mem forwarding
          if((Mem_0_Wb_MemRead ==1'b1) & (Ex_O_Mem_MemWrite==1'b1) & (Mem_Out_Wb_writereg == Ex_O_Mem_Rs2) & (Mem_Out_Wb_writereg != 5'b00000))
          Fwd_Mem_to_Mem = 1'b1;
          else
          Fwd_Mem_to_Mem = 1'b0;

        
        end
        
        

endmodule