
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps


module stalling_unit(
   input Ex_O_Mem_Reg_Write,
   input Ex_O_Mem_MemRead,
   input [4:0] Ex_O_Mem_Rd,
   input Id_O_Ex_MemRead,
   input Id_O_Ex_Reg_Write,
   input [4:0] Id_Out_Ex_Rd,
   input [4:0] Id_Out_Ex_Rs2,
   input [4:0] If_Id_Rs2,
   input [4:0] If_Id_Rs1,
   input [4:0] If_Id_Rd,
   input [6:0] opcocde,
   input [6:0] Id_O_Ex_opcode,
   output reg Pc_Write,
   output reg If_Id_Write,
   output reg control_sel
    );
    reg c1,c2,c3,c4,c5;
    always @( Ex_O_Mem_Reg_Write,
      Ex_O_Mem_MemRead,
      Ex_O_Mem_Rd,
      Id_O_Ex_MemRead,
      Id_O_Ex_Reg_Write,//If_Id_Rd
     Id_Out_Ex_Rd,
      Id_Out_Ex_Rs2,
      If_Id_Rs2,
      If_Id_Rs1,
      opcocde,
      Id_O_Ex_opcode)
    begin
    // covering the cases of stalling for load and store store instructions
    c1= ((Id_O_Ex_MemRead==1'b1)&(Id_Out_Ex_Rd !=5'b00000)& ((Id_Out_Ex_Rd ==If_Id_Rs2) | (Id_Out_Ex_Rd ==If_Id_Rs1)));//|((Id_Out_Ex_Rd ==If_Id_Rd)&(opcocde==7'b1101111))));
    c2 =((opcocde == 7'b0100011)&(Id_Out_Ex_Rd ==If_Id_Rs2)&(Id_Out_Ex_Rd !=If_Id_Rs1));
   // rtype - branch stalling conditions c3 and c4
    c3 =((Id_O_Ex_Reg_Write==1'b1)&(opcocde == 7'b1100011)&(Id_Out_Ex_Rd !=5'b00000)& ((Id_Out_Ex_Rd ==If_Id_Rs2) | (Id_Out_Ex_Rd ==If_Id_Rs1)));
   
  // c4 = ((Ex_O_Mem_Reg_Write==1'b1)&(opcocde == 7'b1100011)&(Ex_O_Mem_Rd !=5'b00000)& (Id_O_Ex_opcode!= 7'b1100011) &((Ex_O_Mem_Rd ==If_Id_Rs2) | (Ex_O_Mem_Rd ==If_Id_Rs1)));
   
   
    // load- branch and jump stalling condition
    c5 = ((Ex_O_Mem_MemRead==1'b1)&((opcocde == 7'b1100011)&(Ex_O_Mem_Rd !=5'b00000)& ((Ex_O_Mem_Rd ==If_Id_Rs2)|(Ex_O_Mem_Rd ==If_Id_Rs1))));//|((Ex_O_Mem_Rd ==If_Id_Rd)&(opcocde==7'b1101111)) ));
   
  // $display("time:%d,c1=%b,c2=%b,c3=%b,c4=%b,c5=%b",$time,c1,c2,c3,c4,c5);
   
   
//  // with jump reg store
//     c1= ((Id_O_Ex_MemRead==1'b1)&(((Id_Out_Ex_Rd !=5'b00000)& ((Id_Out_Ex_Rd ==If_Id_Rs2) | (Id_Out_Ex_Rd ==If_Id_Rs1)))|((Id_Out_Ex_Rd ==If_Id_Rd)&(opcocde==7'b1101111))));
//     c2 =((opcocde == 7'b0100011)&(Id_Out_Ex_Rd ==If_Id_Rs2)&(Id_Out_Ex_Rd !=If_Id_Rs1));
//    // rtype - branch stalling conditions c3 and c4
//     c3 =((Id_O_Ex_Reg_Write==1'b1)&((((opcocde == 7'b1100011)&(Id_Out_Ex_Rd !=5'b00000)& ((Id_Out_Ex_Rd ==If_Id_Rs2) | (Id_Out_Ex_Rd ==If_Id_Rs1))))|((Id_Out_Ex_Rd ==If_Id_Rd)&(opcocde==7'b1101111))));
//      c4=((Ex_O_Mem_Reg_Write==1'b1)&((Id_Out_Ex_Rd ==If_Id_Rd)&(opcocde==7'b1101111)));
      
//      // load- branch and jump stalling condition
//      c5 = ((Ex_O_Mem_MemRead==1'b1)&(((opcocde == 7'b1100011)&(Ex_O_Mem_Rd !=5'b00000)& ((Ex_O_Mem_Rd ==If_Id_Rs2)|(Ex_O_Mem_Rd ==If_Id_Rs1)))|((Ex_O_Mem_Rd ==If_Id_Rd)&(opcocde==7'b1101111))));
      
   
   
  
//   $display("mem_mem:%d,ex_mem:%d,id_reg:%d",Ex_O_Mem_Rd,Id_Out_Ex_Rd,If_Id_Rd); 
//   $display("opcode:%b",opcocde);
   if( ((c1&(~c2))|c3|c4|c5)==1'b1)
   // stalling PC and IF ID 
   // Control signal to make control signals zero
   begin
   Pc_Write = 1'b0;
   If_Id_Write= 1'b0;
   control_sel =1'b0;
   //$display("stalled");
   //$display("TIME:%d,c1:%b,c2:%d,c3:%d,c4:%d,c5:%d",$time,c1,c2,c3,c4,c5);
   end
   
   else
   begin
   Pc_Write = 1'b1;
   If_Id_Write= 1'b1;
   control_sel =1'b1;
   end
   
   end
   
endmodule