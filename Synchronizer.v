module Synchronizer(
    input [3:0] row,
    input clock,
    input reset,
    output reg S_Row
);
    reg A_Row;

    always @(negedge clock or posedge reset) begin
        if (reset) begin
            A_Row <= 0;
            S_Row <= 0;
        end else begin
            A_Row <= |row;  // Logical OR of all bits in row
            S_Row <= A_Row;
        end
    end
endmodule
