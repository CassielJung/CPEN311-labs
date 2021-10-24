onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /addrCal_tb/clk
add wave -noupdate /addrCal_tb/startCal
add wave -noupdate /addrCal_tb/direction
add wave -noupdate /addrCal_tb/restart
add wave -noupdate -radix decimal /addrCal_tb/addr
add wave -noupdate /addrCal_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {20 ps} {74 ps}
