package stage_ports;
import rv32i_types::*;



typedef struct packed {
	rv32i_word pc;
	rv32i_word instr;
}  IFID_access_i;

typedef struct packed {
	rv32i_word pc;
	logic [2:0] funct3;
    logic [6:0] funct7;
    rv32i_opcode opcode;
    logic [31:0] i_imm;
    logic [31:0] s_imm;
    logic [31:0] b_imm;
    logic [31:0] u_imm;
    logic [31:0] j_imm;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
}  IFID_access_o;

typedef struct packed {
	rv32i_control_word WB;
	rv32i_control_word M;
	rv32i_control_word EX;

	rv32i_word pc;
    logic [31:0] rs1;
    logic [31:0] rs2;
    logic [4:0] rd;
	rv32i_word i_imm;
	rv32i_word u_imm;
	rv32i_word b_imm;
	rv32i_word s_imm;
	rv32i_word j_imm;

	logic [4:0] rs1_idx;
    logic [4:0] rs2_idx;
}  IDEX_access;

typedef struct packed {
	rv32i_control_word WB;
	rv32i_control_word M;
	rv32i_word alu_out;
	rv32i_word alumux2_out;
	rv32i_word rs2;
	rv32i_word u_imm;
	rv32i_word pc;
	logic [4:0] rd;
	logic br_en;
}  EXMEM_access;

typedef struct packed {
	rv32i_control_word WB;
	rv32i_word addr;
	rv32i_word mem_rdata;
	rv32i_word alu_out;
	rv32i_word u_imm;
	logic br_en;
	rv32i_word pc;
	logic [4:0] rd;
}  MEMWB_access;


endpackage : stage_ports