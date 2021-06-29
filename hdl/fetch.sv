import rv32i_types::*;
import stage_ports::*;

module fetch
(
	input clk,
	input rst,
	input rv32i_word alu_out,
	input rv32i_word instr_i,
	input rv32i_opcode ex_op,
	input logic br_en,
	input logic load_pc,
	input logic flush_pipeline_i,
	
	output rv32i_word pc_out,
	output rv32i_word instr_o
);

logic discard_inst;
rv32i_word pcmux_out;
pcmux::pcmux_sel_t pcmux_sel;
//rv32i_word pc_out;
assign instr_o = instr_i;

always_comb begin
	if(rst)
		discard_inst = 0;
	unique case (ex_op)
		op_br: pcmux_sel = pcmux::pcmux_sel_t'(br_en);
		op_jal: pcmux_sel = pcmux::alu_mod2;
		op_jalr: pcmux_sel = pcmux::alu_mod2;
		default: pcmux_sel = pcmux::pc_plus4;
	endcase
	unique case (pcmux_sel)
		pcmux::pc_plus4: pcmux_out = pc_out + 4;
		pcmux::alu_out: pcmux_out = alu_out;
		pcmux::alu_mod2: pcmux_out = {alu_out[31:1], 1'b0};
		default: pcmux_out = 0;
	endcase

	// unique case (discard_inst)
	// 	0: begin
	// 		instr_o = instr_i;
	// 		discard_inst = flush_pipeline_i & ~load_pc;
	// 	end
	// 	1: begin
	// 		instr_o = 32'b0;
	// 		discard_inst = ~load_pc;
	// 	end
	// endcase
end

pc_register PC(
    .clk(clk),
    .rst(rst),
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);

endmodule : fetch