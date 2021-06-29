import rv32i_types::*;
import stage_ports::*;

module IDEX
(
	input clk,
	input rst,
	input load,

	input rv32i_control_word WB_i,
	input rv32i_control_word M_i,
	input rv32i_control_word EX_i,

	output rv32i_control_word WB_o,
	output rv32i_control_word M_o,
	output rv32i_control_word EX_o,

	input rv32i_word pc,
	input logic [31:0] rs1,
	input logic [31:0] rs2,
	input logic [4:0] rd,
	input rv32i_word i_imm,
	input rv32i_word u_imm,
	input rv32i_word b_imm,
	input rv32i_word s_imm,
	input rv32i_word j_imm,

	input logic [4:0] rs1_idx,
	input logic [4:0] rs2_idx,

	output rv32i_word pc_o,
	output logic [31:0] rs1_o,
	output logic [31:0] rs2_o,
	output logic [4:0] rd_o,
	output rv32i_word i_imm_o,
	output rv32i_word u_imm_o,
	output rv32i_word b_imm_o,
	output rv32i_word s_imm_o,
	output rv32i_word j_imm_o,

	output logic [4:0] rs1_idx_o,
	output logic [4:0] rs2_idx_o
);

rv32i_control_word WB_data;
rv32i_control_word M_data;
rv32i_control_word EX_data;
rv32i_word pc_data;
logic [31:0] rs1_data;
logic [31:0] rs2_data;
logic [4:0] rd_data;
rv32i_word i_imm_data;
rv32i_word u_imm_data;
rv32i_word b_imm_data;
rv32i_word s_imm_data;
rv32i_word j_imm_data;
logic [4:0] rs1_idx_data;
logic [4:0] rs2_idx_data;

always_ff @(posedge clk)
begin
    if (rst)
    begin
        WB_data <= '0;
		M_data <= '0;
		EX_data <= '0;
		pc_data <= '0;
		rs1_data <= '0;
		rs2_data <= '0;
		rd_data <= '0;
		i_imm_data <= '0;
		u_imm_data <= '0;
		b_imm_data <= '0;
		s_imm_data <= '0;
		j_imm_data <= '0;
		rs1_idx_data <= '0;
		rs2_idx_data <= '0;
    end
    else if (load)
    begin
        WB_data <= WB_i;
		M_data <= M_i;
		EX_data <= EX_i;
		pc_data <= pc;
		rs1_data <= rs1;
		rs2_data <= rs2;
		rd_data <= rd;
		i_imm_data <= i_imm;
		u_imm_data <= u_imm;
		b_imm_data <= b_imm;
		s_imm_data <= s_imm;
		j_imm_data <= j_imm;
		rs1_idx_data <= rs1_idx;
		rs2_idx_data <= rs2_idx;
    end
    else
    begin
        WB_data <= WB_data;
		M_data <= M_data;
		EX_data <= EX_data;
		pc_data <= pc_data;
		rs1_data <= rs1_data;
		rs2_data <= rs2_data;
		rd_data <= rd_data;
		i_imm_data <= i_imm_data;
		u_imm_data <= u_imm_data;
		b_imm_data <= b_imm_data;
		s_imm_data <= s_imm_data;
		j_imm_data <= j_imm_data;
		rs1_idx_data <= rs1_idx_data;
		rs2_idx_data <= rs2_idx_data;
    end
end

always_comb
begin
	WB_o = WB_data;
	M_o = M_data;
	EX_o = EX_data;
	pc_o = pc_data;
	rs1_o = rs1_data;
	rs2_o = rs2_data;
	rd_o = rd_data;
	i_imm_o = i_imm_data;
	u_imm_o = u_imm_data;
	b_imm_o = b_imm_data;
	s_imm_o = s_imm_data;
	j_imm_o = j_imm_data;
	rs1_idx_o = rs1_idx_data;
	rs2_idx_o = rs2_idx_data;
end



endmodule : IDEX