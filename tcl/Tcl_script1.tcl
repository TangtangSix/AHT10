#clk rst_n
set_location_assignment PIN_E1  -to clk
set_location_assignment PIN_E15 -to rst_n

#uart
set_location_assignment PIN_M2	-to uart_rxd
set_location_assignment PIN_G1	-to uart_txd

#led
set_location_assignment PIN_G15 -to led[0]
set_location_assignment PIN_F16 -to led[1]
set_location_assignment PIN_F15 -to led[2]
set_location_assignment PIN_D16 -to led[3]

set_location_assignment	PIN_M12 -to scl 
set_location_assignment	PIN_L12 -to sda 