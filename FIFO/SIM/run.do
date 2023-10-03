vlib work 
make vlog
vsim -novopt tb +NORMAL_WRITE_READ
run 0ns
do wave.do
run -all

