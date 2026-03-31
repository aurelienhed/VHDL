# Simulation script for ModelSim

vlib work
vcom -93 ../src/spi_temp.vhd
vcom -93 spi_temp_tb.vhd
vsim spi_temp_tb
add wave /uut/*
run -a
