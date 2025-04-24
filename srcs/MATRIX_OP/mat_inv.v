`timescale 1ns / 1ps

module MatrixInverse3x3 (
    input clk, // Clock signal
    input rst, // Reset signal

    // 3x3 matrix input elements
    input signed [12:0] A00, A01, A02,
    input signed [12:0] A10, A11, A12,
    input signed [12:0] A20, A21, A22,

    // 3x3 matrix inverse output elements
    output reg signed [31:0] InvA00, InvA01, InvA02,
    output reg signed [31:0] InvA10, InvA11, InvA12,
    output reg signed [31:0] InvA20, InvA21, InvA22,

    output reg valid, // Flag indicating if the inverse is valid (determinant is non-zero)
    output reg Done  , // Flag indicating the computation is complete
    input done_loading
);

    // Register to store determinant of the matrix
    reg signed [63:0] determinant;

    // Internal FSM state to simulate latency
    reg [1:0] state;

    localparam IDLE = 2'd0;
    localparam CALC = 2'd1;
    localparam DONE_STATE = 2'd2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            valid <= 0;
            Done <= 0;
            state <= IDLE;
        end else if(done_loading) begin
            case (state)
                IDLE: begin
                    Done <= 0;
                    state <= CALC;
                end

                CALC: begin
                    // Compute determinant
                    determinant = A00 * (A11 * A22 - A12 * A21) -
                                  A01 * (A10 * A22 - A12 * A20) +
                                  A02 * (A10 * A21 - A11 * A20);

                    if (determinant != 0) begin
                        valid <= 1;

                        // Compute inverse matrix elements
                        InvA00 <= (A11 * A22 - A12 * A21) / determinant;
                        InvA01 <= -(A01 * A22 - A02 * A21) / determinant;
                        InvA02 <= (A01 * A12 - A02 * A11) / determinant;

                        InvA10 <= -(A10 * A22 - A12 * A20) / determinant;
                        InvA11 <= (A00 * A22 - A02 * A20) / determinant;
                        InvA12 <= -(A00 * A12 - A02 * A10) / determinant;

                        InvA20 <= (A10 * A21 - A11 * A20) / determinant;
                        InvA21 <= -(A00 * A21 - A01 * A20) / determinant;
                        InvA22 <= (A00 * A11 - A01 * A10) / determinant;
                    end else begin
                        valid <= 0;
                    end
                    state <= DONE_STATE;
                end

                DONE_STATE: begin
                    Done <= 1;
                    // Hold state
                end
            endcase
        end
    end
endmodule

