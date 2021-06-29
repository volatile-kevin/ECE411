import rv32i_types::*;
import stage_ports::*;
module mp4
(    
	input logic clk,
    input logic rst,
	input logic pmem_resp,
	input logic [63:0] pmem_rdata,
	output logic [63:0] pmem_wdata,
	output logic pmem_read,
	output logic pmem_write,
	output logic [31:0] pmem_address
);

IFID_access_i IFID_i;
IFID_access_o IFID_o;
IDEX_access IDEX_i, IDEX_o;
EXMEM_access EXMEM_i, EXMEM_o;
MEMWB_access MEMWB_i, MEMWB_o;

// intermediate signals
rv32i_word regfilemux_out;
forwardAmux::forwardAmux_sel_t forwardAmux_sel;
forwardBmux::forwardBmux_sel_t forwardBmux_sel;
forwardCmux::forwardCmux_sel_t forwardCmux_sel;
logic memstall;
logic flush_pipeline;

rv32i_word instr_rdata, data_rdata;
rv32i_word data_wdata;
logic [3:0] mem_byte_enable;


fetch fetch
(
	.clk(clk),
	.rst(rst),
	.alu_out(EXMEM_o.alu_out),
	.br_en(EXMEM_o.br_en),
	.instr_i(instr_rdata),
	.flush_pipeline_i(flush_pipeline),
	.pc_out(IFID_i.pc),
	.instr_o(IFID_i.instr),
	.ex_op(EXMEM_o.WB.opcode),
	.load_pc(flush_pipeline || (memstall && mem_resp_inst))
);

IFID IFID
(
	.clk(clk),
	.rst(rst | flush_pipeline | ~mem_resp_inst),
	.load(memstall && mem_resp_inst),
	.pc_i(IFID_i.pc),
	.instr_i(IFID_i.instr), //need to look at clock cycles if instruction being delivered at correct time
	.pc_o(IFID_o.pc),
	.funct3(IFID_o.funct3),
	.funct7(IFID_o.funct7),
	.opcode(IFID_o.opcode),
	.i_imm(IFID_o.i_imm),
	.s_imm(IFID_o.s_imm),
	.b_imm(IFID_o.b_imm),
	.u_imm(IFID_o.u_imm),
	.j_imm(IFID_o.j_imm),
	.rs1(IFID_o.rs1),
	.rs2(IFID_o.rs2),
	.rd(IFID_o.rd)
);

decode decode
(
	.clk(clk),
	.rst(rst),
	.pc(IFID_o.pc),
	.funct3(IFID_o.funct3),
	.funct7(IFID_o.funct7),
	.opcode(IFID_o.opcode),
	.i_imm(IFID_o.i_imm),
	.s_imm(IFID_o.s_imm),
	.b_imm(IFID_o.b_imm),
	.u_imm(IFID_o.u_imm),
	.j_imm(IFID_o.j_imm),
	.rs1(IFID_o.rs1),
	.rs2(IFID_o.rs2),
	.rd(IFID_o.rd),
	
	// depends on MEMWB_o.WB
	.reg_write(MEMWB_o.WB.load_regfile),
	.dest_reg(MEMWB_o.rd),

	.reg_in(regfilemux_out),
	.pc_o(IDEX_i.pc),
	.i_imm_o(IDEX_i.i_imm),
	.u_imm_o(IDEX_i.u_imm),
	.b_imm_o(IDEX_i.b_imm),
	.s_imm_o(IDEX_i.s_imm),
	.j_imm_o(IDEX_i.j_imm),
	.rs1_o(IDEX_i.rs1),
	.rs2_o(IDEX_i.rs2),
	.rd_o(IDEX_i.rd),

	.rs1_idx_o(IDEX_i.rs1_idx),
	.rs2_idx_o(IDEX_i.rs2_idx),

	.WB_o(IDEX_i.WB),
	.M_o(IDEX_i.M),
	.EX_o(IDEX_i.EX)
);

IDEX IDEX
(
	.clk(clk),
	.rst(flush_pipeline),
	.load(memstall), //fine for now
	.WB_i(IDEX_i.WB),
	.M_i(IDEX_i.M),
	.EX_i(IDEX_i.EX),
	.WB_o(IDEX_o.WB),
	.M_o(IDEX_o.M),
	.EX_o(IDEX_o.EX),

	.pc(IDEX_i.pc),
	.rs1(IDEX_i.rs1),
	.rs2(IDEX_i.rs2), 
	.rd(IDEX_i.rd),
	.i_imm(IDEX_i.i_imm),
	.u_imm(IDEX_i.u_imm),
	.b_imm(IDEX_i.b_imm),
	.s_imm(IDEX_i.s_imm),
	.j_imm(IDEX_i.j_imm),

	.rs1_idx(IDEX_i.rs1_idx),
	.rs2_idx(IDEX_i.rs2_idx),

	.pc_o(IDEX_o.pc),
	.rs1_o(IDEX_o.rs1),
	.rs2_o(IDEX_o.rs2),
	.rd_o(IDEX_o.rd),
	.i_imm_o(IDEX_o.i_imm),
	.u_imm_o(IDEX_o.u_imm),
	.b_imm_o(IDEX_o.b_imm),
	.s_imm_o(IDEX_o.s_imm),
	.j_imm_o(IDEX_o.j_imm),

	.rs1_idx_o(IDEX_o.rs1_idx),
	.rs2_idx_o(IDEX_o.rs2_idx)
);

execute execute
(
	.clk(clk),
	.rst(flush_pipeline),
	// depends on IDEX_o.EX
	.alumux1_sel(IDEX_o.EX.alumux1_sel),
	.alumux2_sel(IDEX_o.EX.alumux2_sel),
    .aluop(IDEX_o.EX.aluop),
	.cmpop(IDEX_o.EX.cmpop),
	.cmpmux_sel(IDEX_o.EX.cmpmux_sel),
	
	.pc(IDEX_o.pc),
	.rs1(IDEX_o.rs1),
	.rs2(IDEX_o.rs2),
	.i_imm(IDEX_o.i_imm),
	.u_imm(IDEX_o.u_imm),
	.b_imm(IDEX_o.b_imm),
	.s_imm(IDEX_o.s_imm),
	.j_imm(IDEX_o.j_imm),
	
	.forwardAmux_sel(forwardAmux_sel),
	.forwardBmux_sel(forwardBmux_sel),
	.EXMEM_rd_i(EXMEM_o.alu_out),
	.MEMWB_rd_i(regfilemux_out),

	.alu_out(EXMEM_i.alu_out),
	.alumux2_out(EXMEM_i.alumux2_out),
	.br_en(EXMEM_i.br_en),
	.data_rdata(data_rdata)
);

// for clarity's sake
assign EXMEM_i.WB = IDEX_o.WB;
assign EXMEM_i.M = IDEX_o.M;
assign EXMEM_i.u_imm = IDEX_o.u_imm;
assign EXMEM_i.pc = IDEX_o.pc;
assign EXMEM_i.rd = IDEX_o.rd;
assign EXMEM_i.rs2 = IDEX_o.rs2;

EXMEM EXMEM
(
	.clk(clk),
	.rst(flush_pipeline),
	.load(memstall), //fine for now

	.WB_i(EXMEM_i.WB),
	.M_i(EXMEM_i.M),
	.alu_out_i(EXMEM_i.alu_out),
	.alumux2_out_i(EXMEM_i.alumux2_out),
	.rs2_i(EXMEM_i.rs2),
	.rd_i(EXMEM_i.rd),
	.u_imm_i(EXMEM_i.u_imm),
	.br_en_i(EXMEM_i.br_en),
	.pc_i(EXMEM_i.pc),

	.WB_o(EXMEM_o.WB),
	.M_o(EXMEM_o.M),
	.alu_out_o(EXMEM_o.alu_out),
	.alumux2_out_o(EXMEM_o.alumux2_out),
	.rs2_o(EXMEM_o.rs2),
	.rd_o(EXMEM_o.rd),
	.u_imm_o(EXMEM_o.u_imm),
	.br_en_o(EXMEM_o.br_en),
	.pc_o(EXMEM_o.pc)
);

mem mem
(
	.clk(clk),
	.rst(rst),
	// depends on EXMEM_o.M
	.mem_read(EXMEM_o.M.mem_read),
	.mem_write(EXMEM_o.M.mem_write),
	.mem_byte_enable_i(EXMEM_o.M.mem_byte_enable),
	.br_en(EXMEM_o.br_en),
	.opcode(EXMEM_o.M.opcode),
	.flush_pipeline(flush_pipeline),
	
	.address_i(EXMEM_o.alu_out),
	.rs2_i(EXMEM_o.rs2), //what used to be mem_wdata_i
	.regfile_i(regfilemux_out),
	.forwardCmux_sel(forwardCmux_sel),
	.mem_wdata_o(data_wdata),
	.mem_byte_enable_o(mem_byte_enable),
	
	// from D-cache
	.mem_resp(mem_resp_data),
	.address_o(MEMWB_i.addr),
	.store_funct3(EXMEM_o.M.store_funct3),
	.memstall(memstall),
	.ex_pc(IDEX_o.pc),
	.cur_pc(EXMEM_o.pc),
	.id_pc(IFID_o.pc),
	.if_pc(IFID_i.pc)
);

// for clarity's sake
assign MEMWB_i.rd = EXMEM_o.rd;
assign MEMWB_i.WB = EXMEM_o.WB;
assign MEMWB_i.alu_out = EXMEM_o.alu_out;
assign MEMWB_i.u_imm = EXMEM_o.u_imm;
assign MEMWB_i.br_en = EXMEM_o.br_en;
assign MEMWB_i.pc = EXMEM_o.pc;

MEMWB MEMWB
(
	.clk(clk),
	.rst(rst),
	.load(memstall), //fine for now

	.WB_i(MEMWB_i.WB),
	.addr_i(MEMWB_i.addr),
	.mem_rdata_i(data_rdata), //change for cache
	.alu_out_i(MEMWB_i.alu_out),
	.rd_i(MEMWB_i.rd),
	.u_imm_i(MEMWB_i.u_imm),
	.br_en_i(MEMWB_i.br_en),
	.pc_i(MEMWB_i.pc),

	.WB_o(MEMWB_o.WB),
	.addr_o(MEMWB_o.addr),
	.mem_rdata_o(MEMWB_o.mem_rdata),
	.alu_out_o(MEMWB_o.alu_out),
	.rd_o(MEMWB_o.rd),
	.u_imm_o(MEMWB_o.u_imm),
	.br_en_o(MEMWB_o.br_en),
	.pc_o(MEMWB_o.pc)
);

writeback writeback
(
	.mem_rdata(MEMWB_o.mem_rdata),
	.alu_out(MEMWB_o.alu_out),
	// depends on MEMWB_o.WB
	.regfilemux_sel(MEMWB_o.WB.regfilemux_sel),
	
	.br_en(MEMWB_o.br_en),
	.u_imm(MEMWB_o.u_imm),
	.addr(MEMWB_o.addr),
	.pc_out(MEMWB_o.pc),
	// should drive the write data to reg file
	.regfilemux_out(regfilemux_out)
);

FU FU
(
    .clk(clk),
    .rst(rst),
    .rs1_i(IDEX_o.rs1_idx),
    .rs2_i(IDEX_o.rs2_idx),
    .EXMEM_rd_i(EXMEM_o.rd),
    .MEMWB_rd_i(MEMWB_o.rd),
    .EXMEM_reg_write_i(EXMEM_o.WB.load_regfile),
    .MEMWB_reg_write_i(MEMWB_o.WB.load_regfile),
	.MEMWB_address_i(MEMWB_o.addr),
	.EXMEM_address_i(EXMEM_o.alu_out),
	.EXMEM_opcode(EXMEM_o.WB.opcode),
	.MEMWB_opcode(MEMWB_o.WB.opcode),
    .forwardAmux_sel(forwardAmux_sel),
    .forwardBmux_sel(forwardBmux_sel),
	.forwardCmux_sel(forwardCmux_sel)
);

logic [255:0] pmem_rdata_ca, pmem_wdata_ca, pmem_rdata_inst, pmem_wdata_inst,
	pmem_rdata_data, pmem_wdata_data;
logic pmem_read_ca, pmem_write_ca, pmem_resp_ca,
	pmem_write_data, pmem_write_inst, pmem_read_data,
	pmem_read_inst, pmem_resp_inst, pmem_resp_data;

rv32i_word pmem_address_ca, pmem_address_data, pmem_address_inst;


arbiter arbiter (
	.clk(clk),
	.rst(rst),
	//to caches
	.mem_resp_i(pmem_resp_inst),
	.mem_resp_d(pmem_resp_data),
	.mem_rdata_i(pmem_rdata_inst),
	.mem_wdata_i(pmem_wdata_inst),
	.mem_rdata_d(pmem_rdata_data),
	.mem_wdata_d(pmem_wdata_data),
	.mem_read_i(pmem_read_inst),
	.mem_write_i(1'b0),
	.mem_read_d(pmem_read_data),
	.mem_write_d(pmem_write_data),
	.mem_address_i(pmem_address_inst),
	.mem_address_d(pmem_address_data),

	//to adapter
	.pmem_rdata(pmem_rdata_ca),
	.pmem_wdata(pmem_wdata_ca),
	.pmem_resp(pmem_resp_ca),
	.pmem_write(pmem_write_ca),
	.pmem_read(pmem_read_ca),
	.pmem_address(pmem_address_ca)
);

cacheline_adaptor ca(
	.clk(clk),
	.reset_n(rst),
	//port to arbiter
	.line_i(pmem_wdata_ca),
	.line_o(pmem_rdata_ca),
	.address_i(pmem_address_ca),
	.read_i(pmem_read_ca),
	.write_i(pmem_write_ca),
	.resp_o(pmem_resp_ca),

	//port to mem
	.burst_i(pmem_rdata),
	.burst_o(pmem_wdata),
	.address_o(pmem_address),
	.read_o(pmem_read),
	.write_o(pmem_write),
	.resp_i(pmem_resp)
);

dcache data_cache(
	.clk(clk),
	//to arbiter
	.pmem_resp(pmem_resp_data),
	.pmem_rdata(pmem_rdata_data),
	.pmem_address(pmem_address_data),
	.pmem_wdata(pmem_wdata_data),
	.pmem_read(pmem_read_data),
	.pmem_write(pmem_write_data),

	//to cpu
	.mem_read(EXMEM_o.M.mem_read),
	.mem_write(EXMEM_o.M.mem_write),
	.mem_byte_enable_cpu(mem_byte_enable),
	.mem_address(EXMEM_o.alu_out),
	.mem_wdata_cpu(data_wdata),
	.mem_resp(mem_resp_data),
	.mem_rdata_cpu(data_rdata) //goes directly to MEMWB
);

icache instruction_cache(
	.clk(clk),
	//to arbiter
	.pmem_resp(pmem_resp_inst), //in
	.pmem_rdata(pmem_rdata_inst),
	.pmem_address(pmem_address_inst),
	.pmem_wdata(pmem_wdata_inst),
	.pmem_read(pmem_read_inst),
	.pmem_write(pmem_write_inst),

	//to cpu
	.mem_read(~flush_pipeline), //changed for stalling
	.mem_write(1'b0),
	.mem_byte_enable_cpu(4'b1111),
	.mem_address(IFID_i.pc),
	.mem_wdata_cpu(32'b0),
	.mem_resp(mem_resp_inst),
	.mem_rdata_cpu(instr_rdata) //goes directly to MEMWB
);
endmodule : mp4
