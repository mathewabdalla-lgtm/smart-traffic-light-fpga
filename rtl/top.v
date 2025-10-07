// top.v – Top-level module for Smart Traffic Light (DE10-Lite)
module top (
    input  wire clk_50,      // 50 MHz clock
    input  wire rst_n,       // active-low reset (e.g., KEY0)
    input  wire ped_btn,     // pedestrian button (active-high)
    output wire led_red,     // map to LEDR[0]
    output wire led_yellow,  // map to LEDR[1]
    output wire led_green    // map to LEDR[2]
);

    // ~1 Hz slow clock for human-visible timing
    wire clk_1hz;

    clk_div #(.DIV_COUNT(25_000_000)) u_div (  // toggle every 0.5s -> 1 Hz
        .clk_in (clk_50),
        .rst_n  (rst_n),
        .clk_out(clk_1hz)
    );

    fsm u_fsm (
        .clk       (clk_1hz),
        .rst_n     (rst_n),
        .ped_btn   (ped_btn),
        .led_red   (led_red),
        .led_yellow(led_yellow),
        .led_green (led_green)
    );

endmodule
