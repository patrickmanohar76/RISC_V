`timescale 1ns / 1ps

module Risc_Processor(
    input clk,
    input reset,
    output [31:0]p_o
    );
    wire [31:0] PC_Sel,jump_address,jump_offset,jump_sign_Ex,beq_Read_Data_1,beq_Read_Data_2,/*sign_Ex_shift_by_2*/inst_code,PC,PC_Inc,
    jumpaddress,If_Id_inst_code,WriteData,Read_Data_1,Read_Data_2,aluresult,a,b,ID_EX_Read_Data_1,ID_EX_Read_Data_2,Ex_O_Aluresult;    
    wire [31:0] Mem_O_Wb_PC_Inc, Ex_O_Mem_PC_Inc;
    wire [31:0] Id_O_Ex_PC_Inc,If_Id_PC_Inc,If_Id_PC,branch_address,Mem_O_Wb_Aluresult,Alu_Input_2,Alu_Input_1,signextended_output,sign_Ex,Id_0_Ex_Sign_Ex,Mux_selected_read_Data;
    wire [31:0] Mem_WriteData,Mem_ReadData,Mem_O_Wb_Mem_ReadData,Mux_Mem_WriteData;
    wire [4:0] If_Id_Rs2,If_Id_Rs1,If_Id_Rd,Id_Out_Ex_Rs1,Id_Out_Ex_Rs2,Id_O_Ex_Rd,Ex_O_Mem_Rs1,Ex_O_Mem_Rs2,Ex_O_Mem_Rd,Mem_O_Wb_Rs1,
    Mem_O_Wb_Rs2,Mem_O_Wb_Rd;
    wire [3:0] If_Id_acl,Id_O_Ex_acl,If_c_Id_acl;
    wire [1:0] Forward_Rs1_to_Id,Forward_Rs2_to_Id,Ex_to_Id_Fwd_R1,Ex_to_Id_Fwd_R2,If_Id_Output_Select,Id_O_Ex_Output_Select,
    If_c_Id_Output_Select,Ex_O_Mem_Output_Select,Mem_O_Wb_Output_Select,Forward_Rs1,Forward_Rs2,If_Id_Read_Data_2_Sel,If_c_Id_Read_Data_2_Sel,
    Id_Ex_Read_Data_2_Sel;
    wire flag,RegWrite,If_Id_Reg_Write,Zero,Id_O_Ex_Reg_Write,Ex_O_Mem_Reg_Write,Mem_O_Wb_Reg_Write,If_Id_MemWrite,If_Id_MemRead,Id_O_Ex_MemWrite,
    Id_O_Ex_MemRead,If_c_Id_beq_pc_Sel,If_c_id_flush;
    wire jump_sel,If_id_flush,beq_pc,beq_pc_sel,Fwd_Mem_to_Mem,Ex_O_Mem_MemWrite,Ex_O_Mem_MemRead,Mem_0_Wb_MemRead,Pc_Write,If_Id_Write,
    control_sel,If_c_Id_Reg_Write,If_c_Id_MemWrite,If_c_Id_MemRead,If_O_Id_Write;
    wire [6:0] Id_O_Ex_opcode;
    wire If_Id_jump_sel;
    wire activate_mul_module,c_activate_mul_module,id_ex_activate_mul_module;
    
    // Pc increment block
    pc_adder Pc_A(PC,PC_Inc);
    // To generate the jump selection signal for PC
    jump_sel_mux J_sel(inst_code,jump_sel); 
    // PC selection block
    pc_select pc_mux(clk,reset,Pc_Write,If_c_Id_beq_pc_Sel,jump_sel,jump_address,branch_address,PC_Inc,PC);
    // Instruction Fetch block
    Inst_Fetch IF(reset,inst_code,PC);
    // Sign extension block - To calculate jump offset
    signextend j_s(inst_code,jump_sign_Ex); 
    // shift left by 2 -- for jump offset
  //  shift_left_by2 j_sll(jump_sign_Ex,jump_offset);
    // Adding the PC to jump offset to calculate jump address
    addresscal jump_addr(PC,jump_sign_Ex,jump_address);
    // IF ID pipeline register
    IF_ID_Register If_id(clk,reset,If_c_id_flush,If_Id_Write,inst_code,jump_sel,If_Id_Rs2,If_Id_Rs1,If_Id_Rd,If_Id_inst_code,PC,If_Id_PC,If_Id_jump_sel);
    // Sign extension block - To calculate branch offset 
    signextend s1(If_Id_inst_code,sign_Ex); 
    // shift left by 2 -- for branch offset
  //  shift_left_by2 s11(sign_Ex,sign_Ex_shift_by_2);
    // Adding the IF ID PC to branch offset to calculate branching address
    addresscal beq_addr(If_Id_PC,sign_Ex,branch_address);
    // Register File
    Register_File R1(If_Id_Rs1,If_Id_Rs2,Mem_O_Wb_Rd,reset,If_Id_Rd,If_Id_PC,Mem_O_Wb_Reg_Write,flag,p_o,Read_Data_1,Read_Data_2);
    // Input 1 selection to the comparator
    Mux beq_R1(Read_Data_1,Ex_O_Aluresult,p_o,Forward_Rs1_to_Id,beq_Read_Data_1);
    // Input 1 selection to the comparator
    Mux beq_R2(Read_Data_2,Ex_O_Aluresult,p_o,Forward_Rs2_to_Id,beq_Read_Data_2);
    // comparator for branching instructions - static branch prediction 
    beq_check b_c(If_Id_inst_code,beq_Read_Data_1,beq_Read_Data_2,beq_pc);
    // Control unit
    control_signal C11(If_Id_inst_code,beq_pc,If_Id_Write,If_Id_Reg_Write,If_Id_acl,If_Id_Output_Select,If_Id_Read_Data_2_Sel,If_Id_MemWrite,
    If_Id_MemRead,beq_pc_Sel,If_id_flush,activate_mul_module);
    // Control signal mux -- for stalling cases to make control signals zero
    ctrl_sgnl_mux c1_mux(control_sel,If_Id_Reg_Write,If_Id_acl,If_Id_Output_Select,If_Id_Read_Data_2_Sel,If_Id_MemWrite,If_Id_MemRead,activate_mul_module,If_c_Id_Reg_Write,
    If_c_Id_acl,If_c_Id_Output_Select,If_c_Id_Read_Data_2_Sel,
    If_c_Id_MemWrite,If_c_Id_MemRead,beq_pc_Sel,If_id_flush,If_c_Id_beq_pc_Sel,If_c_id_flush,c_activate_mul_module);
    // ID EX pipeline register
    ID_EX_Register Id_Ex(clk,reset,If_Id_Rs1,If_Id_Rs2,If_c_Id_Reg_Write,If_c_Id_acl,If_c_Id_Output_Select,If_Id_Rd,Read_Data_1,Read_Data_2,Id_Out_Ex_Rs1
    ,Id_Out_Ex_Rs2,ID_EX_Read_Data_1,ID_EX_Read_Data_2,
    Id_O_Ex_Reg_Write,Id_O_Ex_acl,Id_O_Ex_Output_Select,Id_O_Ex_Rd,sign_Ex,Id_0_Ex_Sign_Ex,If_c_Id_MemWrite,If_c_Id_MemRead,Id_O_Ex_MemWrite,Id_O_Ex_MemRead,
    If_Id_inst_code[6:0],Id_O_Ex_opcode,If_c_Id_Read_Data_2_Sel,Id_Ex_Read_Data_2_Sel,c_activate_mul_module,id_ex_activate_mul_module);
    // Stalling unit 
    stalling_unit s_u(Ex_O_Mem_Reg_Write,Ex_O_Mem_MemRead,Ex_O_Mem_Rd,Id_O_Ex_MemRead,Id_O_Ex_Reg_Write,Id_O_Ex_Rd,Id_Out_Ex_Rs2,If_Id_Rs2,If_Id_Rs1,If_Id_Rd,
    If_Id_inst_code[6:0],Id_O_Ex_opcode,Pc_Write,If_Id_Write,control_sel);
    // Alu unit
    computing_unit compute(Alu_Input_1,Alu_Input_2,id_ex_activate_mul_module,Id_O_Ex_acl,aluresult,Zero);
    // Mux unit for selecting Read_data_2 or sign extension address 
    Mux_Read_data_2_Sel Rs_2(Id_Ex_Read_Data_2_Sel,Id_0_Ex_Sign_Ex,Mux_selected_read_Data,Alu_Input_2);
    // EX MEM pipeine register
    EX_MEM_Register Ex_Mem(clk,reset,Id_Out_Ex_Rs1,Id_Out_Ex_Rs2,Id_O_Ex_Rd,aluresult,Id_O_Ex_Reg_Write,Id_O_Ex_Output_Select,Ex_O_Mem_Rs1,Ex_O_Mem_Rs2,
    Ex_O_Mem_Rd,
    Ex_O_Aluresult,Ex_O_Mem_Reg_Write,Ex_O_Mem_Output_Select,Id_O_Ex_MemWrite,Id_O_Ex_MemRead,Ex_O_Mem_MemWrite,Ex_O_Mem_MemRead,Mux_selected_read_Data,
    Mem_WriteData);
    // MEM WB pipeline register
    MEM_WB_Register Mem_Wb(clk,reset,Ex_O_Mem_Rs1,Ex_O_Mem_Rs2,Ex_O_Mem_Rd,Ex_O_Aluresult,Ex_O_Mem_Reg_Write,Ex_O_Mem_Output_Select,Mem_O_Wb_Rs1,
    Mem_O_Wb_Rs2,Mem_O_Wb_Rd,
    Mem_O_Wb_Aluresult,Mem_O_Wb_Reg_Write,Mem_O_Wb_Output_Select,Ex_O_Mem_MemRead,Mem_0_Wb_MemRead,Mem_ReadData,Mem_O_Wb_Mem_ReadData);
    // Data Memory
    Data_Memory D_M(Ex_O_Mem_MemRead,Ex_O_Mem_MemWrite,Ex_O_Aluresult,Mux_Mem_WriteData,Mem_ReadData,reset);
    // Forwarding unit
    Forward_Unit F1(Mem_0_Wb_MemRead,Ex_O_Mem_Reg_Write,Ex_O_Mem_Rd,Mem_O_Wb_Reg_Write,Mem_O_Wb_Rd,Id_Out_Ex_Rs1,Id_Out_Ex_Rs2,Id_O_Ex_MemWrite,
    Id_O_Ex_opcode,Forward_Rs1,Forward_Rs2,
    Forward_Rs1_to_Id,Forward_Rs2_to_Id,Ex_O_Mem_MemWrite,Ex_O_Mem_Rs2,Fwd_Mem_to_Mem,If_Id_inst_code[6:0],If_Id_Rs2,If_Id_Rs1);
    // Input 1 selection of alu
    Mux alu_input1(ID_EX_Read_Data_1,Ex_O_Aluresult,p_o,Forward_Rs1,Alu_Input_1);
    // Input 2 selection of alu
    Mux alu_input2(ID_EX_Read_Data_2,Ex_O_Aluresult,p_o,Forward_Rs2,Mux_selected_read_Data);
    // Mux selection for write data in Data memory - considering forwarding case
    Mux_MemWriteData Mux_Mem(Mem_O_Wb_Mem_ReadData,Mem_WriteData,Fwd_Mem_to_Mem,Mux_Mem_WriteData);
     // Outpu selection unit
    output_select o_s(Mem_O_Wb_Output_Select,Mem_O_Wb_Aluresult,Mem_O_Wb_Mem_ReadData,reset,p_o,flag);
  // header_bank hb(clk,reset,h_packet,p_o);
    //   tailer_bank tb(clk,reset,p_o,t_packet);
      // whole_packet wp(t_packet,h_packet,packet);
endmodule
