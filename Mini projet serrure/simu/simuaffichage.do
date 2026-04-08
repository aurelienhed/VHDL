vlib work

#Compilation des fichiers src
vcom -93 src/decodeur7.vhd
vcom -93 src/affichagex4.vhd



#compile du test_bench
vcom -93 testbenchs/decodeur7_tb.vhd
vcom -93 testbenchs/affichagex4_tb.vhd

vsim work.affichagex4_tb
add wave *

run 200ns
wave zoom full