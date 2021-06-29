import rv32i_types::*;
import stage_ports::*;

module execute
(
	input clk,
	input rst,
	input alumux::alumux1_sel_t alumux1_sel,
	input alumux::alumux2_sel_t alumux2_sel,
	input cmpmux::cmpmux_sel_t cmpmux_sel,
    input alu_ops aluop,
	input branch_funct3_t cmpop,
	input rv32i_word pc,
	input rv32i_word rs1,
	input rv32i_word rs2,
	input rv32i_word i_imm,
	input rv32i_word u_imm,
	input rv32i_word b_imm,
	input rv32i_word s_imm,
	input rv32i_word j_imm,
	
    input forwardAmux::forwardAmux_sel_t forwardAmux_sel,
    input forwardBmux::forwardBmux_sel_t forwardBmux_sel,

	input rv32i_word EXMEM_rd_i,
	input rv32i_word MEMWB_rd_i,
	input rv32i_word data_rdata,

	output rv32i_word alu_out,
	output rv32i_word alumux2_out,
	output logic br_en
);
rv32i_word alumux1_out;
rv32i_word cmpmux_out;
rv32i_word forwardAmux_out;
rv32i_word forwardBmux_out;

/*****************************************************************************/

/******************************* ALU and CMP *********************************/


	alu ALU(
		.aluop (aluop),
		.a (alumux1_out),
		.b (alumux2_out),
		.f (alu_out)
	);

	cmp CMP(
		.cmpop (cmpop),
		.a (forwardAmux_out),
		.b (cmpmux_out),
		.f (br_en)
	);

always_comb begin : MUXES
	unique case (forwardAmux_sel)
		forwardAmux::IDEX: forwardAmux_out = rs1;
		forwardAmux::EXMEM: forwardAmux_out = EXMEM_rd_i;
		forwardAmux::MEMWB: forwardAmux_out = MEMWB_rd_i;
		forwardAmux::EXMEM_rdata: forwardAmux_out = data_rdata;
		default:;
	endcase

	unique case (forwardBmux_sel)
		forwardBmux::IDEX: forwardBmux_out = rs2;
		forwardBmux::EXMEM: forwardBmux_out = EXMEM_rd_i;
		forwardBmux::MEMWB: forwardBmux_out = MEMWB_rd_i;
		forwardBmux::EXMEM_rdata: forwardBmux_out = data_rdata;
		default:;
	endcase

	unique case (cmpmux_sel)
		cmpmux::rs2_out: cmpmux_out = forwardBmux_out;
		cmpmux::i_imm: cmpmux_out = i_imm;
		default:;
	endcase
	
	unique case (alumux1_sel)
		alumux::rs1_out: alumux1_out = forwardAmux_out;
		alumux::pc_out: alumux1_out = pc;
		default:;
	endcase
	
	unique case (alumux2_sel)
		alumux::i_imm: alumux2_out = i_imm;
		alumux::u_imm: alumux2_out = u_imm;
		alumux::b_imm: alumux2_out = b_imm;
		alumux::s_imm: alumux2_out = s_imm;
		alumux::j_imm: alumux2_out = j_imm;
		alumux::rs2_out: alumux2_out = forwardBmux_out;
		default:;
	endcase
end

endmodule : execute