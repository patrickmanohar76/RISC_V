`timescale 1ns / 1ps

module aluunit(
    input [31:0] a,//operand 1
    input [31:0] b,//operand 2
    input [3:0] acl,//alu control unit
    output reg[31:0] aluresult//alu result
    );

    always@(a,b,acl)
    begin
    
    
    if(acl == 4'b0000 )
       begin
       aluresult = a+b; // add,addi instrcution
       end
    else if(acl== 4'b0001)
       begin
       aluresult = a-b; // sub,subi instrcution
    //  $display("%d-%d=aluresult is :%d",a,b,aluresult);
       end 
    else if(acl== 4'b0010)
       begin
       aluresult = a<<b;  // sll instrcution
       end
    else if(acl== 4'b0011)
       begin
       aluresult = a<b;  // slt,slti instrcution
       end
    else if(acl== 4'b0100)
       begin
       aluresult= a^b;  // xor,xori instrcution
       end
    else if(acl== 4'b0101)
       begin
       aluresult= a>>b;  // srl instrcution
       end
    else if(acl== 4'b0110)
       begin
       aluresult= a | b;  // or,ori instrcution
       end
    else if(acl==4'b0111)
       begin
       aluresult= a&b;  // and,andi instrcution
       end
 
              
  
    
    
    end
 endmodule