onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/f
add wave -noupdate /mp4_tb/f
add wave -noupdate /mp4_tb/f
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
add wave -noupdate -radix hexadecimal /mp4_tb/itf/data_addr
add wave -noupdate -radix hexadecimal /mp4_tb/itf/data_rdata
add wave -noupdate -radix hexadecimal /mp4_tb/itf/data_read
add wave -noupdate /mp4_tb/itf/data_write
add wave -noupdate -radix hexadecimal /mp4_tb/itf/data_wdata
add wave -noupdate /mp4_tb/dut/EXMEM/WB_i.opcode
add wave -noupdate /mp4_tb/dut/EXMEM/WB_o.opcode
add wave -noupdate -radix hexadecimal /mp4_tb/dut/EXMEM/alu_out_o
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/ALU/a
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/ALU/b
add wave -noupdate /mp4_tb/dut/execute/alumux1_sel
add wave -noupdate /mp4_tb/dut/execute/alumux2_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {833373 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
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
WaveRestoreZoom {826359 ps} {883901 ps}
