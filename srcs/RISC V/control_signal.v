`timescale 1ns / 1ps
module control_signal(
     input [31:0] instructioncode,
     input beq_pc,
     input If_Id_Write,
     output reg If_Id_Reg_Write,
     output reg [3:0] If_Id_acl,
     output reg [1:0] If_Id_Output_Select,
     output reg [1:0] If_Id_Read_Data_2_Sel,
     output reg If_Id_MemWrite,
     output reg If_Id_MemRead,
     output reg beq_pc_sel,
     output reg If_id_flush,
     output reg activate_mul_module);
     
    always @(instructioncode,beq_pc,If_Id_Write)
    begin
    if(instructioncode[6:0]==7'b0110011)
        begin
        
                If_Id_Reg_Write =1'b1;
                If_Id_Output_Select=2'b01;
                If_Id_Read_Data_2_Sel = 2'b01;
                If_Id_MemWrite =1'b0;
                If_Id_MemRead =1'b0;
                beq_pc_sel = 1'b0;
                If_id_flush = 1'b0;
                
                if(instructioncode[31:25]==7'b0000000)
                    begin
                    activate_mul_module=0;
                        case(instructioncode[14:12])
                            3'b000: If_Id_acl=4'b0000;    //add
                            3'b001: If_Id_acl=4'b0010;    //sll
                            3'b010: If_Id_acl=4'b0011;    //slt
                            3'b100: If_Id_acl=4'b0100;    //xor
                            3'b101: If_Id_acl=4'b0101;    //srl
                            3'b110: If_Id_acl=4'b0110;    //or
                            3'b111: If_Id_acl=4'b0111;    //and
                     
                        endcase
                    end
                  
                 else if(instructioncode[31:25]==7'b0000001)
                 begin
                 activate_mul_module=1;
                    case(instructioncode[14:12])
                                             3'b000: If_Id_acl=4'b0000;
                                             3'b001: If_Id_acl=4'b0001;
                                             3'b100: If_Id_acl=4'b0100;
                                             3'b110: If_Id_acl=4'b0110;
                    endcase
                 end
                  
                
             else if(instructioncode[31:25]==7'b0100000)
             begin
             activate_mul_module=0;
             // for sub instruction
                 if(instructioncode[14:12]==3'b000)
                 begin
                 If_Id_acl=4'b0001;
                
                 end
             end
          end   
          // for i-type instructions
          else if (instructioncode[6:0]==7'b0010011)
          begin
          
          If_id_flush = 1'b0;
          beq_pc_sel = 1'b0;
          If_Id_Reg_Write =1'b1;
          If_Id_Output_Select=2'b01;
          If_Id_Read_Data_2_Sel = 2'b10;
          If_Id_MemWrite =1'b0;
          If_Id_MemRead =1'b0;
          activate_mul_module=0;
                         
                                case(instructioncode[14:12])                    
                                    3'b000: If_Id_acl=4'b0000;    //addi        
                                    3'b010: If_Id_acl=4'b0011;    //slti         
                                    3'b100: If_Id_acl=4'b0100;    //xori  
                                    3'b110: If_Id_acl=4'b0110;    //ori          
                                    3'b111: If_Id_acl=4'b0111;    //andi         
                         
                                endcase                                             
            end
            // for store instruction
            else if (instructioncode[6:0]==7'b0100011)
            begin
            If_id_flush = 1'b0;
            beq_pc_sel = 1'b0;
            If_Id_Reg_Write =1'b0;
            If_Id_Output_Select=2'b00;
            If_Id_Read_Data_2_Sel = 2'b10;
            If_Id_MemWrite =1'b1;
            If_Id_MemRead =1'b0;
            If_Id_acl=4'b0000;
            activate_mul_module=0;
            end
            // for load instruction
            else if (instructioncode[6:0]==7'b0000011)
            begin
            If_id_flush = 1'b0;
            beq_pc_sel = 1'b0;
            If_Id_Reg_Write =1'b1;
            If_Id_Output_Select=2'b10;
            If_Id_Read_Data_2_Sel = 2'b10;
            If_Id_MemWrite =1'b0;
            If_Id_MemRead =1'b1;
            If_Id_acl=4'b0000;
            activate_mul_module=0;
            end
            // for branch instruction
            else if (instructioncode[6:0]==7'b1100011)
            begin
            // cosnidering the stalling cases 
            if(beq_pc==1'b1 & If_Id_Write == 1'b1)
            begin
            beq_pc_sel = 1'b1;
            If_id_flush = 1'b1;
            end
            else
            begin
            beq_pc_sel = 1'b0;
            If_id_flush = 1'b0;
            end
           
            
            If_Id_Reg_Write =1'b0;
            If_Id_Output_Select=2'b00;
            If_Id_Read_Data_2_Sel = 2'b01;
            If_Id_MemWrite =1'b0;
            If_Id_MemRead =1'b0;
            If_Id_acl=4'b0001;
            activate_mul_module=0;
            end
            // for jump instruction
            else if (instructioncode[6:0]==7'b1101111)
            begin
            If_id_flush = 1'b0;
            beq_pc_sel = 1'b0;
            If_Id_Reg_Write =1'b0;
            If_Id_Output_Select=2'b00;
            If_Id_Read_Data_2_Sel = 2'bXX;
            If_Id_MemWrite =1'b0;
            If_Id_MemRead =1'b0;
            If_Id_acl=4'bXXXX;
            activate_mul_module=0;
            end
//            to give a duplicate instruction
            else if (instructioncode[6:0]==7'b0000000)
            begin
            If_id_flush = 1'bx;
            beq_pc_sel = 1'bx;
            If_Id_Reg_Write =1'bx;
            If_Id_Output_Select=2'bxx;
            If_Id_Read_Data_2_Sel = 2'bxx;
            If_Id_MemWrite =1'bx;
            If_Id_MemRead =1'bx;
            If_Id_acl=4'bXXXX;
            activate_mul_module=1'bX;
            end
         

     
   // $display("%d:::%h:::%d",$time,instructioncode,beq_pc_sel); 
    end
   endmodule