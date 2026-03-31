
vlib work

vcom -93 encoder.vhd
vcom -93 encoder_tb.vhd

vsim encoder_tb(Behavioral)

add wave *

run -all