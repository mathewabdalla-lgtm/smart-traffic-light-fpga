// fsm.v – traffic light finite state machine (Verilog-2001)
module fsm (
    input  wire clk,        // ~1 Hz from clk_div
    input  wire rst_n,      // active-low reset
    input  wire ped_btn,    // pedestrian request (active-high)
    output reg  led_red,
    output reg  led_yellow,
    output reg  led_green
);

    // states
    localparam [1:0] S_RED    = 2'b00,
                     S_GREEN  = 2'b01,
                     S_YELLOW = 2'b10,
                     S_PED    = 2'b11;

    // durations in seconds (counts of clk)
    localparam integer RED_DUR    = 5;
    localparam integer GREEN_DUR  = 5;
    localparam integer YELLOW_DUR = 2;
    localparam integer PED_DUR    = 4;

    reg [1:0]  state, next_state;
    reg [3:0]  sec_cnt;           // enough for small second counts
    reg        ped_req_latched;   // remembers a button press until served

    // latch pedestrian request (simple, no debounce here)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            ped_req_latched <= 1'b0;
        else if (state == S_PED)
            ped_req_latched <= 1'b0;       // served
        else if (ped_btn)
            ped_req_latched <= 1'b1;
    end

    // state register + per-state second counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_RED;
            sec_cnt <= 4'd0;
        end else begin
            state <= next_state;

            // increment/reset timing counter
            if (state != next_state)
                sec_cnt <= 4'd0;
            else
                sec_cnt <= sec_cnt + 4'd1;
        end
    end

    // next-state logic
    always @* begin
        next_state = state;
        case (state)
            S_RED:    next_state = (sec_cnt >= RED_DUR-1)   ? S_GREEN : S_RED;
            S_GREEN:  next_state = (sec_cnt >= GREEN_DUR-1) ? S_YELLOW : S_GREEN;
            S_YELLOW: next_state = (sec_cnt >= YELLOW_DUR-1)? (ped_req_latched ? S_PED : S_RED) : S_YELLOW;
            S_PED:    next_state = (sec_cnt >= PED_DUR-1)   ? S_RED : S_PED;
            default:  next_state = S_RED;
        endcase
    end

    // outputs
    always @* begin
        led_red    = 1'b0;
        led_yellow = 1'b0;
        led_green  = 1'b0;

        case (state)
            S_RED:    led_red    = 1'b1;
            S_GREEN:  led_green  = 1'b1;
            S_YELLOW: led_yellow = 1'b1;
            S_PED:    led_red    = 1'b1;   // cars stop while pedestrians cross
        endcase
    end
endmodule
