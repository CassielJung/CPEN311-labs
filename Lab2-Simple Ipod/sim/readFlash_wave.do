onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /readFlash_tb/clk
add wave -noupdate /readFlash_tb/audio_clk
add wave -noupdate /readFlash_tb/wait_request
add wave -noupdate /readFlash_tb/read_data_valid
add wave -noupdate /readFlash_tb/startRead
add wave -noupdate /readFlash_tb/DUT/state
add wave -noupdate /readFlash_tb/read
add wave -noupdate /readFlash_tb/endRead
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22 ps} 0}
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
WaveRestoreZoom {0 ps} {198 ps}
