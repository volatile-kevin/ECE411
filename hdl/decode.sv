import rv32i_types::*;
import stage_ports::*;

module decode
(
    // input from IFID
	input logic clk,
	input logic rst,
	input rv32i_word pc,
	input [2:0] funct3,
	input [6:0] funct7,
	input rv32i_opcode opcode,
	input [31:0] i_imm,
	input [31:0] s_imm,
	input [31:0] b_imm,
	input [31:0] u_imm,
	input [31:0] j_imm,
	input [4:0] rs1,
	input [4:0] rs2,
	input [4:0] rd,

    //input from WB control word
    input logic reg_write,
	input [4:0] dest_reg,
	//input from WB
	input rv32i_word reg_in,

	output [31:0] pc_o,
	output [31:0] i_imm_o,
	output [31:0] u_imm_o,
	output [31:0] b_imm_o,
	output [31:0] s_imm_o,
	output [31:0] j_imm_o,
	output logic [31:0] rs1_o,
	output logic [31:0] rs2_o,
	output [4:0] rd_o,

	output [4:0] rs1_idx_o,
	output [4:0] rs2_idx_o,
	
	output rv32i_control_word WB_o,
	output rv32i_control_word M_o,
	output rv32i_control_word EX_o


);
logic [31:0] rs2_output, rs1_output;
assign pc_o = pc;
assign i_imm_o = i_imm;
assign u_imm_o = u_imm;
assign b_imm_o = b_imm;
assign s_imm_o = s_imm;
assign j_imm_o = j_imm;
assign rd_o = rd;

assign rs1_idx_o = rs1;
assign rs2_idx_o = rs2;

rv32i_control_word control_word;
assign WB_o = control_word;
assign M_o = control_word;
assign EX_o = control_word;

always_comb begin //mini forwarding
	rs1_o = rs1_output;
	rs2_o = rs2_output;
	if (reg_write) begin
		if (dest_reg == rs2) rs2_o = reg_in;
		if (dest_reg == rs1) rs1_o = reg_in;
	end
end	

regfile regfile
(
    .clk(clk),
    .rst(rst),
    .load(reg_write),
    .in(reg_in),
    .src_a(rs1), 
    .src_b(rs2), 
    .dest(dest_reg),
    .reg_a(rs1_output), 
    .reg_b(rs2_output)
);

control controller (
	.ctrl(control_word),
	.*
);
endmodule : decode