vlib work

vcom -93 fsm.vhd
vcom -93 fsmtb.vhd

vsim fsmtb(A1)

add wave *

run -all