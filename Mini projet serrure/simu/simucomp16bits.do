vlib work

#Compilation des fichiers src

vcom -93 src/comp4bits.vhd
vcom -93 src/comp16bits.vhd


#compile du test_bench

vcom -93 testbenchs/comp4bits_tb.vhd
vcom -93 testbenchs/comp16bits_tb.vhd

vsim work.comp16bits_tb

add wave *

run 40ns
wave zoom full
