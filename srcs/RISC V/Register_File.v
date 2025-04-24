`timescale 1ns / 1ps
module Register_File(
    input [4:0] Read_Reg_Num_1,
    input [4:0] Read_Reg_Num_2,
    input [4:0] Write_Reg_Num,
    input reset, // To initialize the register file
    input [4:0] store_pc_plus_4,
    input [31:0]PC,
    input RegWrite,input flag,
    input [31:0] WriteData,
    output [31:0] Read_Data_1,
    output [31:0] Read_Data_2
    //output reg beq_pc_Sel
    );
    reg [31:0] Regfile [31:0]; // Define 32 registers each of 32-bit
    assign Read_Data_1 = Regfile[Read_Reg_Num_1]; // Reading the first register
    assign Read_Data_2 = Regfile[Read_Reg_Num_2]; // Reading the second register 
   always @(*)
    begin
     
    if( reset==1 )begin
    Regfile[0] =32'h00000000;
    Regfile[1] = 32'h00000001;
    Regfile[2] = 32'h00000002; 
    Regfile[3] = 32'h00000000;
    Regfile[4] = 32'h00000003;
    Regfile[5] = 32'h0000000A;
    Regfile[6] = 32'h00000004;
    Regfile[7] = 32'h0000000C;
    Regfile[8] = 32'h00000002;
    Regfile[9] = 32'h00000004;
    Regfile[10] = 32'h00000003;
    Regfile[11] = 32'h0000000B;
    Regfile[12]=32'h00000000;
    Regfile[13]=32'h00000000;
    Regfile[14]=32'h00000000;
    Regfile[15]=32'h00000000;
    Regfile[16]=32'h00000000;
    Regfile[17]=32'h00000000;
    Regfile[18]=32'h00000000;
    Regfile[19]=32'h00000000;
    Regfile[20]=32'h00000000;
    Regfile[21]=32'h00000000;
    Regfile[22]=32'h00000000;
    Regfile[23]=32'h00000000;
    Regfile[24]=32'h00000000;
    Regfile[25]=32'h00000000;
    Regfile[26]=32'h00000000;
    Regfile[27]=32'h00000000;
    Regfile[28]=32'h00000000;
    Regfile[29]=32'h00000000;
    Regfile[30]=32'h00000000;
    Regfile[31]=32'h00000000;
    
    
   
       end
       else
        
        begin
        if(RegWrite == 1 & Write_Reg_Num!=5'b00000   )
        begin
            if(flag==1)
            begin
                Regfile[Write_Reg_Num] = WriteData;
            end
            else
                  Regfile[Write_Reg_Num] = Regfile[Write_Reg_Num];
                 
        end
        
        
        else
                Regfile[Write_Reg_Num] = Regfile[Write_Reg_Num];
                
        end
        
   
  //  $display("r1:%h", Regfile[1]);
    // register 0 shouldn't be written with any value - 
   /* always @(Write_Reg_Num,WriteData,RegWrite)
    begin
    if(RegWrite == 1 & Write_Reg_Num!=5'b00000)
    begin
    Regfile[Write_Reg_Num] = WriteData;
    end*/
   
    end
 endmodule