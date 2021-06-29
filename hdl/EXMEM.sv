import rv32i_types::*;
import stage_ports::*;

module EXMEM
(
	input logic clk,
	input logic rst,
	input logic load,
	
	input rv32i_control_word WB_i,
	input rv32i_control_word M_i,
	input rv32i_word alu_out_i,
	input rv32i_word alumux2_out_i,
	input rv32i_word rs2_i,
	input logic [4:0] rd_i,
	input rv32i_word u_imm_i,
	input logic br_en_i,
	input rv32i_word pc_i,

	output rv32i_control_word WB_o,
	output rv32i_control_word M_o,
	output rv32i_word alu_out_o,
	output rv32i_word alumux2_out_o,
	output rv32i_word rs2_o,
	output logic [4:0] rd_o,
	output rv32i_word u_imm_o,
	output logic br_en_o,
	output rv32i_word pc_o
);

rv32i_control_word WB_data;
rv32i_control_word M_data;
rv32i_word alu_out_data;
rv32i_word alumux2_out_data;
logic [4:0] rd_data;
rv32i_word u_imm_data;
logic br_en_data;
rv32i_word pc_data;
rv32i_word rs2_data;

always_ff @(posedge clk)
begin
    if (rst)
    begin
		WB_data <= '0;
		M_data <= '0;
		alu_out_data <= '0;
		alumux2_out_data <= '0;
		rs2_data <= '0;
		rd_data <= '0;
		u_imm_data <= '0;
		br_en_data <= '0;
		pc_data <= '0;
    end
    else if (load)
    begin
		WB_data <= WB_i;
		M_data <= M_i;
		alu_out_data <= alu_out_i;
		alumux2_out_data <= alumux2_out_i;
		rs2_data <= rs2_i;
		rd_data <= rd_i;
		u_imm_data <= u_imm_i;
		br_en_data <= br_en_i;
		pc_data <= pc_i;
    end
	else 
	begin
		WB_data <= WB_data;
		M_data <= M_data;
		alu_out_data <= alu_out_data;
		alumux2_out_data <= alumux2_out_data;
		rs2_data <= rs2_data;
		rd_data <= rd_data;
		u_imm_data <= u_imm_data;
		br_en_data <= br_en_data;
		pc_data <= pc_data;
	end
end

always_comb
begin
 	WB_o = WB_data;
	M_o = M_data;
	alu_out_o = alu_out_data;
	alumux2_out_o = alumux2_out_data;
	rs2_o = rs2_data;
	rd_o = rd_data;
	u_imm_o = u_imm_data;
	br_en_o = br_en_data;
	pc_o = pc_data;
end

endmodule : EXMEM