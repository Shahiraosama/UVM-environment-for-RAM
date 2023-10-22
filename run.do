vlib work
vlog -f src_files.list +cover
vsim -voptargs=+acc work.TOP -classdebug -uvmcontrol=all -cover
add wave /TOP/ram_if/*
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/agt/driver/stim_seq_item
coverage save RAM.ucdb -du work.ram -onexit
run -all