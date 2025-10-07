// top.v – Top-level module for Smart Traffic Light (DE10-Lite)
module top (
    input  wire clk_50,       // 50 MHz clock input
    input  wire rst_n,        // active-low reset
    input  wire ped_btn,      // pedestrian button
    output wire led_red,
    output wire led_yellow,
    output wire led_green
);

    wire slow_clk;

    // Clock divider (to slow down 50 MHz)
    clk_div clk_div_inst (
        .clk_in(clk_50),
        .rst_n(rst_n),
        .clk_out(slow_clk)
    );

    // FSM for light control
    fsm traffic_fsm (
        .clk(slow_clk),
        .rst_n(rst_n),
        .ped_btn(ped_btn),
        .led_red(led_red),
        .led_yellow(led_yellow),
        .led_green(led_green)
    );

endmodule
