transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/src {G:/FPGAProject/EP4CE6F17C8/AHT10/src/data_drive.v}
vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/src {G:/FPGAProject/EP4CE6F17C8/AHT10/src/uart_tx.v}
vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/src {G:/FPGAProject/EP4CE6F17C8/AHT10/src/param.v}
vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/src {G:/FPGAProject/EP4CE6F17C8/AHT10/src/aht10_top.v}
vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/ip {G:/FPGAProject/EP4CE6F17C8/AHT10/ip/fifo.v}
vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/src {G:/FPGAProject/EP4CE6F17C8/AHT10/src/i2c_master.v}
vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/src {G:/FPGAProject/EP4CE6F17C8/AHT10/src/i2c_intf.v}

vlog -vlog01compat -work work +incdir+G:/FPGAProject/EP4CE6F17C8/AHT10/prj/../sim {G:/FPGAProject/EP4CE6F17C8/AHT10/prj/../sim/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
add wave -position insertpoint sim:/tb/u_aht10_top/u_i2c_intf/*
add wave -position insertpoint sim:/tb/u_aht10_top/u_i2c_master/*
add wave -position insertpoint sim:/tb/u_aht10_top/u_data_drive/*
view structure
view signals
run -all
