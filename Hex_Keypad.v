module Hex_Keypad(
    input [3:0] row,
    input S_Row,
    input clock,
    input reset,
    output reg [3:0] code,
    output valid,
    output reg [3:0] col
);
    reg [5:0] state, next_state;

    parameter S_0 = 6'b000001, S_1 = 6'b000010, S_2 = 6'b000100;
    parameter S_3 = 6'b001000, S_4 = 6'b010000, S_5 = 6'b100000;

    assign valid = ((state == S_1) || (state == S_2) || (state == S_3) || (state == S_4)) && (|row);

    always @(posedge clock or posedge reset) begin
        if (reset)
            state <= S_0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        col = 4'b0000;

        case (state)
            S_0: begin col = 4'b1111; if (S_Row) next_state = S_1; end
            S_1: begin col = 4'b0001; if (|row) next_state = S_5; else next_state = S_2; end
            S_2: begin col = 4'b0010; if (|row) next_state = S_5; else next_state = S_3; end
            S_3: begin col = 4'b0100; if (|row) next_state = S_5; else next_state = S_4; end
            S_4: begin col = 4'b1000; if (|row) next_state = S_5; else next_state = S_0; end
            S_5: begin col = 4'b1111; if (~|row) next_state = S_0; end
        endcase
    end

    always @(posedge clock) begin
        case ({row, col})
            8'b0001_0001: code <= 4'h0;
            8'b0001_0010: code <= 4'h1;
            8'b0001_0100: code <= 4'h2;
            8'b0001_1000: code <= 4'h3;
            8'b0010_0001: code <= 4'h4;
            8'b0010_0010: code <= 4'h5;
            8'b0010_0100: code <= 4'h6;
            8'b0010_1000: code <= 4'h7;
            8'b0100_0001: code <= 4'h8;
            8'b0100_0010: code <= 4'h9;
            8'b0100_0100: code <= 4'hA;
            8'b0100_1000: code <= 4'hB;
            8'b1000_0001: code <= 4'hC;
            8'b1000_0010: code <= 4'hD;
            8'b1000_0100: code <= 4'hE;
            8'b1000_1000: code <= 4'hF;
            default: code <= 4'h0;
        endcase
    end
endmodule
