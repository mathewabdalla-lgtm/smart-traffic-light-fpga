// clk_div.v – simple clock divider (Verilog-2001)
module clk_div #
(
    parameter integer DIV_COUNT = 25_000_000  // 50 MHz -> 0.5 s to toggle (1 Hz output)
)
(
    input  wire clk_in,
    input  wire rst_n,
    output reg  clk_out
);

    // enough bits to count DIV_COUNT-1 (25 bits covers 33,554,432)
    reg [24:0] cnt;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            cnt     <= 25'd0;
            clk_out <= 1'b0;
        end else if (cnt == DIV_COUNT - 1) begin
            cnt     <= 25'd0;
            clk_out <= ~clk_out;
        end else begin
            cnt <= cnt + 25'd1;
        end
    end
endmodule
