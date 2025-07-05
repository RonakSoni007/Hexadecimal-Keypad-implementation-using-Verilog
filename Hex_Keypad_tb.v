`timescale 1ns / 1ps

module Hex_Keypad_tb();
    wire [3:0] code;
    wire valid;
    wire [3:0] col;
    wire [3:0] row;
    wire S_Row;

    reg clock, reset;
    reg [15:0] Key;
    reg [39:0] pressed;

    parameter [39:0] Key_0 = "Key_0";
    parameter [39:0] Key_1 = "Key_1";
    parameter [39:0] Key_2 = "Key_2";
    parameter [39:0] Key_3 = "Key_3";
    parameter [39:0] Key_4 = "Key_4";
    parameter [39:0] Key_5 = "Key_5";
    parameter [39:0] Key_6 = "Key_6";
    parameter [39:0] Key_7 = "Key_7";
    parameter [39:0] Key_8 = "Key_8";
    parameter [39:0] Key_9 = "Key_9";
    parameter [39:0] Key_A = "Key_A";
    parameter [39:0] Key_B = "Key_B";
    parameter [39:0] Key_C = "Key_C";
    parameter [39:0] Key_D = "Key_D";
    parameter [39:0] Key_E = "Key_E";
    parameter [39:0] Key_F = "Key_F";
    parameter [39:0] None  = "None";

    integer j;

    always @(Key) begin
        case(Key)
            16'h0000: pressed = None;
            16'h0001: pressed = Key_0;
            16'h0002: pressed = Key_1;
            16'h0004: pressed = Key_2;
            16'h0008: pressed = Key_3;
            16'h0010: pressed = Key_4;
            16'h0020: pressed = Key_5;
            16'h0040: pressed = Key_6;
            16'h0080: pressed = Key_7;
            16'h0100: pressed = Key_8;
            16'h0200: pressed = Key_9;
            16'h0400: pressed = Key_A;
            16'h0800: pressed = Key_B;
            16'h1000: pressed = Key_C;
            16'h2000: pressed = Key_D;
            16'h4000: pressed = Key_E;
            16'h8000: pressed = Key_F;
            default: pressed = None;
        endcase
    end

    // Instantiate modules
    Hex_Keypad M1(row, S_Row, clock, reset, code, valid, col);
    row_signal M2(Key, col, row);
    Synchronizer M3(row, clock, reset, S_Row);

    // Clock and reset
    initial #2000 $finish;
    initial begin clock = 0; forever #5 clock = ~clock; end
    initial begin reset = 1; #20 reset = 0; end

    // Simulate key presses
    initial begin
        Key = 16'b0;
        for (j = 0; j < 16; j = j + 1) begin
            #20 Key = 16'b1 << j;  // simulate key press
            #60 Key = 16'b0;       // release
        end
    end

    // Display output
    always @(posedge clock) begin
        if (valid)
            $display("Time: %0t | Key Pressed: %s | Code: %h", $time, pressed, code);
    end
endmodule
