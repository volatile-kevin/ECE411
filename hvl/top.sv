module mp4_tb;
`timescale 1ns/10ps

/********************* Do not touch for proper compilation *******************/
// Instantiate Interfaces
tb_itf itf();
rvfi_itf rvfi(itf.clk, itf.rst);

// Instantiate Testbench
source_tb tb(
    .magic_mem_itf(itf),
    .mem_itf(itf),
    .sm_itf(itf),
    .tb_itf(itf),
    .rvfi(rvfi)
);

// For local simulation, add signal for Modelsim to display by default
// Note that this signal does nothing and is not used for anything
bit f;

/****************************** End do not touch *****************************/

/************************ Signals necessary for monitor **********************/
// This section not required until CP2

assign rvfi.commit = 0; // Set high when a valid instruction is modifying regfile or PC
assign rvfi.halt = (dut.writeback.alu_out == dut.writeback.pc_out) && (dut.writeback.pc_out != 0) && (dut.writeback.br_en) && (dut.MEMWB.WB_o.alumux2_sel == 3'b010);
// && (dut.execute.alumux2_sel == 3'b010);   // Set high when you detect an infinite loop
initial rvfi.order = 0;
always @(posedge itf.clk iff rvfi.commit) rvfi.order <= rvfi.order + 1; // Modify for OoO

// riscv_formal_monitor_rv32i monitor(
//     .clock(itf.clk),
//     .reset(itf.rst),
// );

// performance counter for prefetching
int hits_i, misses_i, hits_d, misses_d;
logic [31:0] temp_address;
always_ff @(posedge itf.clk)
begin
    if(dut.instruction_cache.mem_read == 1 && dut.instruction_cache.mem_address != temp_address)
    begin
        if(dut.instruction_cache.hit == 1)
            hits_i++;
        else if(dut.instruction_cache.hit == 0)
            misses_i++;
        temp_address = dut.instruction_cache.mem_address;
    end
    temp_address = dut.instruction_cache.mem_address;

end
always_ff @(posedge itf.clk)
begin
    if((dut.data_cache.mem_read == 1 || dut.data_cache.mem_write == 1) && dut.data_cache.mem_address != temp_address)
    begin
        if(dut.data_cache.hit == 1)
            hits_d++;
        else if(dut.data_cache.hit == 0)
            misses_d++;
        temp_address = dut.data_cache.mem_address;
    end
    temp_address = dut.data_cache.mem_address;
end

/*
The following signals need to be set:
Instruction and trap:
    rvfi.inst
    rvfi.trap

Regfile:
    rvfi.rs1_addr
    rvfi.rs2_add
    rvfi.rs1_rdata
    rvfi.rs2_rdata
    rvfi.load_regfile
    rvfi.rd_addr
    rvfi.rd_wdata

PC:
    rvfi.pc_rdata
    rvfi.pc_wdata

Memory:
    rvfi.mem_addr
    rvfi.mem_rmask
    rvfi.mem_wmask
    rvfi.mem_rdata
    rvfi.mem_wdata

Please refer to rvfi_itf.sv for more information.
*/

/**************************** End RVFIMON signals ****************************/

/********************* Assign Shadow Memory Signals Here *********************/
// This section not required until CP2
/*
The following signals need to be set:
*/
// icache signals:
    // assign itf.inst_read = dut.instr_read
    // assign itf.inst_addr = 
    // itf.inst_resp
    // itf.inst_rdata

// dcache signals:
    // itf.data_read
    // itf.data_write
    // itf.data_mbe
    // itf.data_addr
    // itf.data_wdata
    // itf.data_resp
    // itf.data_rdata
/*
Please refer to tb_itf.sv for more information.
*/

/*********************** End Shadow Memory Assignments ***********************/

// Set this to the proper value
assign itf.registers = dut.decode.regfile.data;//'{default: '0};

/*********************** Instantiate your design here ************************/
/*
The following signals need to be connected to your top level:
Clock and reset signals:
*/
// assign itf.clk = dut.clk;
// assign itf.rst = dut.rst;

// Burst Memory Ports:
// assign itf.mem_read = dut.pmem_read;
// assign itf.mem_write = dut.pmem_write;
// assign itf.mem_wdata = dut.pmem_wdata;
// assign itf.mem_rdata = dut.pmem_rdata;
// assign itf.mem_addr = dut.pmem_address;
// assign itf.mem_resp = dut.pmem_resp;
//
 /*
Please refer to tb_itf.sv for more information.
*/

mp4 dut
(
   	.clk(itf.clk),
    .rst(itf.rst),
    .pmem_resp(itf.mem_resp),
	.pmem_rdata(itf.mem_rdata),
    .pmem_wdata(itf.mem_wdata),
	.pmem_address(itf.mem_addr),
	.pmem_read(itf.mem_read),
	.pmem_write(itf.mem_write)
);

// mp4 dut
// (
//    	.clk(itf.clk),
//     .rst(itf.rst),
//     .data_mem_resp(itf.data_resp),
// 	.instr_mem_resp(itf.inst_resp),
// 	.data_rdata(itf.data_rdata),
// 	.instr_rdata(itf.inst_rdata),
// 	.data_read(itf.data_read),
// 	.data_write(itf.data_write),
// 	.mem_byte_enable(itf.data_mbe),
// 	.data_addr(itf.data_addr),
// 	.data_wdata(itf.data_wdata),
// 	.instr_addr(itf.inst_addr),
// 	.instr_read(itf.inst_read)
// );
/***************************** End Instantiation *****************************/

endmodule
