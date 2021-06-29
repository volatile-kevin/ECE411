onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/dut/clk
add wave -noupdate /mp4_tb/dut/rst
add wave -noupdate -label pc -radix hexadecimal /mp4_tb/dut/fetch/pc_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/instr_read
add wave -noupdate -radix hexadecimal /mp4_tb/dut/instr_rdata
add wave -noupdate -radix hexadecimal /mp4_tb/itf/inst_rdata
add wave -noupdate -radix hexadecimal /mp4_tb/itf/inst_read
add wave -noupdate -radix hexadecimal /mp4_tb/itf/inst_addr
add wave -noupdate /mp4_tb/itf/inst_resp
add wave -noupdate /mp4_tb/dut/fetch/pcmux_sel
add wave -noupdate /mp4_tb/dut/execute/CMP/f
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[0]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[1]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[2]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[3]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[4]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[5]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[6]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[7]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[8]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[9]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[10]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[11]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[12]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[13]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[14]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[15]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[16]}
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alu_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/pc
add wave -noupdate /mp4_tb/dut/execute/alumux2_sel
add wave -noupdate -radix hexadecimal /mp4_tb/dut/writeback/pc_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/decode/regfile/dest
add wave -noupdate -radix hexadecimal /mp4_tb/dut/decode/regfile/in
add wave -noupdate /mp4_tb/dut/decode/regfile/load
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1049395 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 280
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
WaveRestoreZoom {1031126 ps} {1087836 ps}
