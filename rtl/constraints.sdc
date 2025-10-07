# 50 MHz clock on top.v port clk_50
create_clock -name CLK50 -period 20.000 [get_ports {clk_50}]
