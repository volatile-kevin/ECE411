onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp4_tb/f
add wave -noupdate /mp4_tb/hits_i
add wave -noupdate /mp4_tb/misses_i
add wave -noupdate /mp4_tb/hits_d
add wave -noupdate /mp4_tb/misses_d
add wave -noupdate /mp4_tb/temp_address
add wave -noupdate /mp4_tb/f
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5144944 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {5144323 ps} {5145036 ps}
