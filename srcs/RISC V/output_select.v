`timescale 1ns / 1ps

module output_select (
    input [1:0] control_signal,
    input [31:0] alu_output,
    input [31:0] Mem_ReadData,
    input reset,
    output reg [31:0] p_o,
    output reg flag
);
    reg [31:0] processor_output;
    reg [1:0] check;

    // Mux to select the load immediate data or ALU result based on control_signal
    always @(reset, control_signal, alu_output, Mem_ReadData) begin
        if (reset == 1) begin
            flag = 0;
            processor_output = 0; // Optional: Initialize to avoid latch
            check = 2'b00;       // Optional: Initialize to avoid latch
            p_o = 0;             // Optional: Initialize to avoid latch
        end
        else begin
            case (control_signal)
                2'b01: begin
                    check = 2'b01;
                    processor_output = alu_output;
                    p_o = processor_output;
                    flag = 1;
                end
                2'b10: begin
                    processor_output = Mem_ReadData;
                    check = 2'b00;
                    p_o = processor_output;
                    flag = 1;
                end
                default: begin
                    processor_output = processor_output; // Retain previous value
                    check = 2'b10;
                    p_o = processor_output;
                    flag = 0;
                end
            endcase
        end
    end

endmodule