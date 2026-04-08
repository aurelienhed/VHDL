# Script de simulation ModelSim pour le mini projet serrure
# Nettoie la librairie work et la recrée
vlib work

# Compilation des fichiers source
vcom -93 src/basculed.vhd
vcom -93 src/registre4bitsparas.vhd
vcom -93 src/registre16bits.vhd
vcom -93 src/comp4bits.vhd
vcom -93 src/comp16bits.vhd
vcom -93 src/decodeur7.vhd
vcom -93 src/affichagex4.vhd
vcom -93 src/detect.vhd
vcom -93 src/serrure.vhd

# Compilation du testbench
vcom -93 testbenchs/serrure_tb.vhd

# Lancement de la simulation
vsim work.serrure_tb

# Ajout de tous les signaux à l'oscilloscope
add wave *

# Exécution de la simulation jusqu'à la fin
run 2000ns
