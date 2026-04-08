vlib work

#Compilation des fichiers src

vcom -93 src/registre4bitsparas.vhd
vcom -93 src/registre16bits.vhd


#compile du test_bench

vcom -93 testbenchs/registre16bits_tb.vhd

vsim work.registre16bits_tb

add wave *

run 200ns