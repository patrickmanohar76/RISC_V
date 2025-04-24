
`timescale 1ns / 1ps

module signextend(
inout [31:0]inst_code,
output reg [31:0] sign_Ex //signextended output
    );
    reg [1:0]check;
    
    
    always@(inst_code)
//    begin
//    //load instruction address calculation and immediate data for i -type instructions
//    if ((inst_code[6:0] != 7'b0100011) & (inst_code[6:0] != 7'b1100011) & (inst_code[6:0] != 7'b1101111))
//    begin
//    sign_Ex = {{20{inst_code[31]}},inst_code[31:20]}; 
//    end
//    // store instruction address calculation
//    else if (inst_code[6:0] == 7'b0100011)
//    begin
//    sign_Ex = {{20{inst_code[31]}},inst_code[31:25],inst_code[11:7]}; 
//    end
//    // branch offset
//    else if (inst_code[6:0] == 7'b1100011)
//    begin
//    sign_Ex = {{19{inst_code[31]}},inst_code[31],inst_code[7],inst_code[30:25],inst_code[11:8],1'b0};
//    end
//    // JUMP offset
//    else if (inst_code[6:0] == 7'b1101111)
//    begin
//    sign_Ex = {{11{inst_code[31]}},inst_code[31],inst_code[19:12],inst_code[20],inst_code[30:21],1'b0};
//    end
//    end  
    
    
    case(inst_code[6:0])
    
    7'b0010011 ,7'b0000011: sign_Ex = {{20{inst_code[31]}},inst_code[31:20]};                                                    //for I type instructions
    7'b0100011            : sign_Ex = {{20{inst_code[31]}},inst_code[31:25],inst_code[11:7]};                                    //for store type instructions
    7'b1100011            : sign_Ex = {{19{inst_code[31]}},inst_code[31],inst_code[7],inst_code[30:25],inst_code[11:8],1'b0};    //for branch type instructions
    7'b1101111            : sign_Ex = {{11{inst_code[31]}},inst_code[31],inst_code[19:12],inst_code[20],inst_code[30:21],1'b0};  //for jump type instructions
    7'b0010111            : sign_Ex = {inst_code[31:12],12'b000000000000};                                                       //for U type instructions
    default               : sign_Ex = 32'bx;                                                                                     //default -- for R unsigned type instructions
    
    endcase
endmodule