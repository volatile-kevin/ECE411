onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/f
add wave -noupdate /mp4_tb/dut/clk
add wave -noupdate /mp4_tb/dut/rst
add wave -noupdate -label pc -radix hexadecimal /mp4_tb/dut/fetch/pc_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/instr_rdata
add wave -noupdate -radix hexadecimal /mp4_tb/itf/inst_rdata
add wave -noupdate -radix hexadecimal /mp4_tb/itf/inst_addr
add wave -noupdate /mp4_tb/itf/inst_resp
add wave -noupdate /mp4_tb/dut/fetch/pcmux_sel
add wave -noupdate /mp4_tb/dut/execute/CMP/f
add wave -noupdate -radix hexadecimal /mp4_tb/dut/fetch/alu_out
add wave -noupdate /mp4_tb/dut/pmem_rdata
add wave -noupdate /mp4_tb/dut/pmem_address
add wave -noupdate /mp4_tb/dut/pmem_read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {217651 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
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
WaveRestoreZoom {811515 ps} {1009921 ps}
