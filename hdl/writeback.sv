import rv32i_types::rv32i_word;
import stage_ports::*;

module writeback
(
	input rv32i_word mem_rdata,
	input rv32i_word alu_out,
	input regfilemux::regfilemux_sel_t regfilemux_sel,
	input logic br_en,
	input rv32i_word u_imm,
	input rv32i_word addr,
	input rv32i_word pc_out,

	output rv32i_word regfilemux_out
);


always_comb begin
	unique case(regfilemux_sel)
		regfilemux::alu_out: regfilemux_out = alu_out;
		regfilemux::br_en: regfilemux_out = {31'b0, br_en};
		regfilemux::u_imm: regfilemux_out = u_imm;
		regfilemux::lw: regfilemux_out = mem_rdata;
		regfilemux::pc_plus4: regfilemux_out = pc_out + 4;
		regfilemux::lb: begin
				case (addr & 2'b11)
					0: regfilemux_out = $signed(mem_rdata[7:0]);
					1: regfilemux_out = $signed(mem_rdata[15:8]);
					2: regfilemux_out = $signed(mem_rdata[23:16]);
					3: regfilemux_out = $signed(mem_rdata[31:24]);
				endcase
			end
		regfilemux::lbu: begin
			case (addr & 2'b11)
				0: regfilemux_out = {24'b0, mem_rdata[7:0]};
				1: regfilemux_out = {24'b0, mem_rdata[15:8]};
				2: regfilemux_out = {24'b0, mem_rdata[23:16]};
				3: regfilemux_out = {24'b0, mem_rdata[31:24]};
			endcase
		end
		regfilemux::lh: begin
			case (addr & 2'b10)
				0: regfilemux_out = $signed(mem_rdata[15:0]);
				2: regfilemux_out = $signed(mem_rdata[31:16]);
			endcase
		end
		regfilemux::lhu: begin
			case (addr & 2'b10)
				0: regfilemux_out = {16'b0, mem_rdata[15:0]};
				2: regfilemux_out = {16'b0, mem_rdata[31:16]};
			endcase
		end
		default: regfilemux_out = 31'b0;
	endcase
end


endmodule : writeback