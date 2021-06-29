transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache/line_adapter.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache/idata_array.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache/icache_datapath.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache/icache_control.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache/iarray.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache/dline_adapter.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache/ddata_array.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache/dcache_datapath.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache/dcache_control.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache/darray.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/cacheline_adaptor.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/regfile.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/pc_reg.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/rv32i_mux_types.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/new_cache/icache.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache {/home/kwh2/ECE411/MPgang/mp4/hdl/given_cache/dcache.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/rv32i_types.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl/arbiter {/home/kwh2/ECE411/MPgang/mp4/hdl/arbiter/arbiter.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/stage_ports.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/cmp.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/control.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/alu.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/IDEX.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/ir.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/execute.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/mem.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/fetch.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/IFID.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/EXMEM.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/MEMWB.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/writeback.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/FU.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/mp4.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hdl {/home/kwh2/ECE411/MPgang/mp4/hdl/decode.sv}

vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/top.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/magic_dual_port.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/param_memory.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/rvfi_itf.sv}
vlog -vlog01compat -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/rvfimon.v}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/shadow_memory.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/source_tb.sv}
vlog -sv -work work +incdir+/home/kwh2/ECE411/MPgang/mp4/hvl {/home/kwh2/ECE411/MPgang/mp4/hvl/tb_itf.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L arriaii_hssi_ver -L arriaii_pcie_hip_ver -L arriaii_ver -L rtl_work -L work -voptargs="+acc"  mp4_tb

add wave *
view structure
view signals
run -all
