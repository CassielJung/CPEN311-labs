onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decrypt_message_fsm_tb/clk
add wave -noupdate /decrypt_message_fsm_tb/shuffle_array_fsm_done
add wave -noupdate /decrypt_message_fsm_tb/rst
add wave -noupdate /decrypt_message_fsm_tb/in_data_s
add wave -noupdate /decrypt_message_fsm_tb/in_data_m
add wave -noupdate /decrypt_message_fsm_tb/mem_address_s
add wave -noupdate /decrypt_message_fsm_tb/mem_address_m
add wave -noupdate /decrypt_message_fsm_tb/mem_address_d
add wave -noupdate /decrypt_message_fsm_tb/out_data_s
add wave -noupdate /decrypt_message_fsm_tb/out_data_d
add wave -noupdate /decrypt_message_fsm_tb/wren_s
add wave -noupdate /decrypt_message_fsm_tb/wren_d
add wave -noupdate -radix unsigned /decrypt_message_fsm_tb/DUT/state
add wave -noupdate -radix unsigned /decrypt_message_fsm_tb/DUT/i
add wave -noupdate /decrypt_message_fsm_tb/DUT/j
add wave -noupdate -radix unsigned /decrypt_message_fsm_tb/DUT/k
add wave -noupdate /decrypt_message_fsm_tb/DUT/data_f
add wave -noupdate /decrypt_message_fsm_tb/DUT/data_i
add wave -noupdate /decrypt_message_fsm_tb/DUT/data_j
add wave -noupdate /decrypt_message_fsm_tb/led0
add wave -noupdate /decrypt_message_fsm_tb/fail_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {193 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 169
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
WaveRestoreZoom {0 ps} {986 ps}
