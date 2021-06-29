import rv32i_types::*;
import stage_ports::*;

module IFID
(
	input logic clk,
	input logic rst,
	input logic load,

	input rv32i_word pc_i,
	input rv32i_word instr_i,
	output rv32i_word pc_o,
	output [2:0] funct3,
	output [6:0] funct7,
	output rv32i_opcode opcode,
	output [31:0] i_imm,
	output [31:0] s_imm,
	output [31:0] b_imm,
	output [31:0] u_imm,
	output [31:0] j_imm,
	output [4:0] rs1,
	output [4:0] rs2,
	output [4:0] rd
);


ir ir
(
	.clk(clk),
	.rst(rst),
	.load(load),
	.in(instr_i),
	.funct3(funct3),
	.funct7(funct7),
	.opcode(opcode),
	.i_imm(i_imm),
	.s_imm(s_imm),
	.b_imm(b_imm),
	.u_imm(u_imm),
	.j_imm(j_imm),
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd)
);

rv32i_word pc_data;
always_ff @(posedge clk)
begin
    if (rst)
    begin
		pc_data <= '0;
    end
    else if (load)
    begin
		pc_data <= pc_i;
    end
	else 
	begin
		pc_data <= pc_data;
	end
end

always_comb
begin
    pc_o = pc_data;
end


endmodule : IFID