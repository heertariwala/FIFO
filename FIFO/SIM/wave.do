onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DUT/rstn
add wave -noupdate /tb/DUT/wr_clk
add wave -noupdate /tb/DUT/rd_clk
add wave -noupdate /tb/DUT/wr_enb
add wave -noupdate /tb/DUT/rd_enb
add wave -noupdate /tb/DUT/input_data
add wave -noupdate /tb/DUT/output_data
add wave -noupdate /tb/DUT/full
add wave -noupdate /tb/DUT/empty
add wave -noupdate /tb/DUT/almost_full
add wave -noupdate /tb/DUT/almost_empty
add wave -noupdate /tb/DUT/half_full
add wave -noupdate /tb/DUT/mem
add wave -noupdate /tb/DUT/i
add wave -noupdate /tb/DUT/j
add wave -noupdate /tb/DUT/wr_ptr
add wave -noupdate /tb/DUT/rd_ptr
add wave -noupdate /tb/inf/driver_wr/driver_wr_event
add wave -noupdate /tb/inf/driver_wr/wr_data
add wave -noupdate /tb/inf/driver_wr/wr_enb
add wave -noupdate /tb/inf/driver_wr/rstn
add wave -noupdate /tb/inf/driver_rd/driver_rd_event
add wave -noupdate /tb/inf/driver_rd/rd_enb
add wave -noupdate /tb/inf/driver_rd/rstn
add wave -noupdate /tb/inf/monitor_wr/monitor_wr_event
add wave -noupdate /tb/inf/monitor_wr/full
add wave -noupdate /tb/inf/monitor_wr/almost_full
add wave -noupdate /tb/inf/monitor_wr/almost_empty
add wave -noupdate /tb/inf/monitor_wr/half_full
add wave -noupdate /tb/inf/monitor_wr/empty
add wave -noupdate /tb/inf/monitor_wr/wr_data
add wave -noupdate /tb/inf/monitor_wr/rstn
add wave -noupdate /tb/inf/monitor_wr/wr_enb
add wave -noupdate /tb/inf/monitor_rd/monitor_rd_event
add wave -noupdate /tb/inf/monitor_rd/full
add wave -noupdate /tb/inf/monitor_rd/almost_full
add wave -noupdate /tb/inf/monitor_rd/almost_empty
add wave -noupdate /tb/inf/monitor_rd/empty
add wave -noupdate /tb/inf/monitor_rd/half_full
add wave -noupdate /tb/inf/monitor_rd/rd_data
add wave -noupdate /tb/inf/monitor_rd/rstn
add wave -noupdate /tb/inf/monitor_rd/rd_enb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 310
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {837 ns}
