onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/dut/FU/rs1_i
add wave -noupdate /mp4_tb/dut/FU/rs2_i
add wave -noupdate /mp4_tb/dut/FU/EXMEM_rd_i
add wave -noupdate /mp4_tb/dut/FU/MEMWB_rd_i
add wave -noupdate /mp4_tb/dut/FU/EXMEM_reg_write_i
add wave -noupdate /mp4_tb/dut/FU/MEMWB_reg_write_i
add wave -noupdate /mp4_tb/dut/FU/forwardAmux_sel
add wave -noupdate /mp4_tb/dut/FU/forwardBmux_sel
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[1]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[2]}
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/forwardAmux_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/forwardBmux_out
add wave -noupdate /mp4_tb/dut/execute/alumux2_sel
add wave -noupdate /mp4_tb/dut/execute/alumux1_sel
add wave -noupdate -radix hexadecimal /mp4_tb/dut/decode/opcode
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/EXMEM_rd_i
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/MEMWB_rd_i
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alu_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alumux1_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alumux2_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80363 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
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
WaveRestoreZoom {16174 ps} {123904 ps}
