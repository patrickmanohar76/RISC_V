
`timescale 1ns / 1ps

module pc_select(
    input clk,
    input reset,
    input Pc_Write,
    input beq_pc_sel,
    input jump_pc_sel,
    input [31:0] jump_address,
    input [31:0] branch_address,
    input [31:0] PC_Inc,
    output reg [31:0] PC_Sel
    );

      always @(posedge clk)
      begin
      
     
      if(reset == 1)
      begin
      PC_Sel =0;
      end
      
      
      
      case(Pc_Write)
      //pc write should be zero when stalled
      0: PC_Sel = PC_Sel;
      // pc must change when not stalled -- change must be according to branch or jump cases .
      1:  begin
                // to select branch address
                if(beq_pc_sel ==1) PC_Sel = branch_address;
                       
                // To select the jump address
                else if(jump_pc_sel ==1) PC_Sel = jump_address;
                // if not both the conditions ,Just increment to next address.
                else PC_Sel = PC_Inc;
                
           end
      
      
      endcase
//$display("time:%d,%d",$time,PC_Sel);
      end                                            
endmodule
      
      
      
      
      
      
      
      
      
      
//      else begin
//      // To stall the PC
//      if(Pc_Write == 1)
//      begin
//      PC_Sel = PC_Inc;
//      end
//     // To select the branch address
//      else if(beq_pc_sel ==1)
//      begin
//      PC_Sel = branch_address;
//      end
//      // To select the jump address
//      else if(jump_pc_sel ==1)
//      begin
//      PC_Sel = jump_address;
//      end
//      // Incrementing the PC 
//      else
//      begin
//      PC_Sel = PC_Sel;
//      end
//      end
//      end
          
