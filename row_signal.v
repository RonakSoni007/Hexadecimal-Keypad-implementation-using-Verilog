module row_signal(
    input [15:0] Key,
    input [3:0] col,
    output reg [3:0] row
);

always @(*) begin
    row[0] = (Key[0] && col[0]) || (Key[1] && col[1]) || (Key[2] && col[2]) || (Key[3] && col[3]);
    row[1] = (Key[4] && col[0]) || (Key[5] && col[1]) || (Key[6] && col[2]) || (Key[7] && col[3]);
    row[2] = (Key[8] && col[0]) || (Key[9] && col[1]) || (Key[10] && col[2]) || (Key[11] && col[3]);
    row[3] = (Key[12] && col[0]) || (Key[13] && col[1]) || (Key[14] && col[2]) || (Key[15] && col[3]);
end

endmodule
