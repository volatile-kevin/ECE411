onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/f
add wave -noupdate -radix hexadecimal /mp4_tb/dut/clk
add wave -noupdate -radix hexadecimal /mp4_tb/dut/rst
add wave -noupdate /mp4_tb/dut/IDEX/EX_o.opcode
add wave -noupdate -radix hexadecimal /mp4_tb/dut/pmem_resp
add wave -noupdate -radix hexadecimal /mp4_tb/dut/pmem_rdata
add wave -noupdate -radix hexadecimal /mp4_tb/dut/pmem_wdata
add wave -noupdate -radix hexadecimal /mp4_tb/dut/pmem_read
add wave -noupdate -radix hexadecimal /mp4_tb/dut/pmem_write
add wave -noupdate -radix hexadecimal /mp4_tb/dut/pmem_address
add wave -noupdate -radix hexadecimal /mp4_tb/dut/fetch/load_pc
add wave -noupdate -radix hexadecimal /mp4_tb/dut/IDEX_o.pc
add wave -noupdate /mp4_tb/dut/arbiter/state
add wave -noupdate /mp4_tb/dut/arbiter/mem_read_d
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[1]}
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[2]}
add wave -noupdate -radix hexadecimal /mp4_tb/dut/regfilemux_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alu_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alumux2_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/alumux1_out
add wave -noupdate /mp4_tb/dut/execute/forwardAmux_sel
add wave -noupdate /mp4_tb/dut/execute/forwardBmux_sel
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/forwardAmux_out
add wave -noupdate -radix hexadecimal /mp4_tb/dut/execute/forwardBmux_out
add wave -noupdate /mp4_tb/dut/execute/alumux1_sel
add wave -noupdate /mp4_tb/dut/execute/alumux2_sel
add wave -noupdate /mp4_tb/dut/EXMEM_o.WB.load_regfile
add wave -noupdate /mp4_tb/dut/MEMWB_o.WB.load_regfile
add wave -noupdate /mp4_tb/dut/MEMWB_o.rd
add wave -noupdate /mp4_tb/dut/EXMEM_o.rd
add wave -noupdate /mp4_tb/dut/FU/rs1_i
add wave -noupdate /mp4_tb/dut/FU/rs2_i
add wave -noupdate /mp4_tb/dut/execute/forwardBmux_sel
add wave -noupdate -radix hexadecimal {/mp4_tb/dut/decode/regfile/data[7]}
add wave -noupdate -radix hexadecimal /mp4_tb/dut/writeback/pc_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3173807 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
configure wave -valuecolwidth 152
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
WaveRestoreZoom {3130150 ps} {3320309 ps}
