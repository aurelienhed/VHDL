vlib work

#Compilation des fichiers src

vcom -93 src/comp4bits.vhd


#compile du test_bench

vcom -93 testbenchs/comp4bits_tb.vhd

vsim work.comp4bits_tb

add wave *

run 8ns
wave zoom full
