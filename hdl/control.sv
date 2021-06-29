import rv32i_types::rv32i_word;
import rv32i_types::rv32i_opcode;
import rv32i_types::rv32i_control_word;
import rv32i_types::*;
import stage_ports::*;

module control(
    input rv32i_opcode opcode,
    input logic[2:0] funct3,
    input logic[6:0] funct7,
    input logic[4:0] rs1,
    input logic[4:0] rs2,
	input logic[4:0] rd,

    output rv32i_control_word ctrl
);

branch_funct3_t branch_funct3;
store_funct3_t store_funct3;
load_funct3_t load_funct3;
arith_funct3_t arith_funct3;

assign arith_funct3 = arith_funct3_t'(funct3);
assign load_funct3 = load_funct3_t'(funct3);
assign store_funct3 = store_funct3_t'(funct3);


function void loadRegfile(regfilemux::regfilemux_sel_t sel);
    ctrl.regfilemux_sel = sel;
    ctrl.load_regfile = 1'b1;
endfunction

function automatic void setCMP(cmpmux::cmpmux_sel_t sel,branch_funct3_t op);
    ctrl.cmpmux_sel = sel;
    ctrl.cmpop = op;
endfunction


always_comb begin
    //defaults
    ctrl.opcode = opcode;
    ctrl.aluop = alu_ops'(funct3);
    ctrl.cmpop = branch_funct3_t'(funct3);
    ctrl.regfilemux_sel = regfilemux::alu_out;
    ctrl.load_regfile = 1'b0;
    ctrl.alumux1_sel = alumux::rs1_out;
    ctrl.alumux2_sel = alumux::i_imm;
    ctrl.cmpmux_sel = cmpmux::rs2_out;
    ctrl.marmux_sel = marmux::pc_out;
    ctrl.mem_read = 1'b0;
    ctrl.mem_write = 1'b0;
    ctrl.mem_byte_enable = 4'b1111;
    ctrl.store_funct3 = store_funct3_t'(3'b000);

    case (opcode) 
        op_imm: begin
            //check arith_funct3
            case (arith_funct3)
                slt: begin
                    loadRegfile(regfilemux::br_en);
                    setCMP(cmpmux::i_imm, blt);
                end
                sltu: begin
                    loadRegfile(regfilemux::br_en);
                    setCMP(cmpmux::i_imm, bltu);
                end
                sr: begin //funct7 ? SRAI : SRLI
                    loadRegfile(regfilemux::alu_out);
                    ctrl.aluop = funct7 ? alu_sra : alu_srl;
                end
                default: begin //imm
                    loadRegfile(regfilemux::alu_out);
                    ctrl.aluop = alu_ops'(funct3);
                end
            endcase
        end
        op_br: begin
            ctrl.alumux1_sel = alumux::pc_out;
            ctrl.alumux2_sel = alumux::b_imm;
            ctrl.aluop = alu_add;
        end
        op_load: begin
            ctrl.aluop = alu_add;
            ctrl.mem_read = 1'b1;
            case(load_funct3)
                lb: loadRegfile(regfilemux::lb);
                lh: loadRegfile(regfilemux::lh);
                lw: loadRegfile(regfilemux::lw);
                lbu: loadRegfile(regfilemux::lbu);
                lhu: loadRegfile(regfilemux::lhu);
				endcase
        end
        op_store: begin
            //need to somehow implement shifting feature
            //Maybe it can be done in MEMWB?
            ctrl.alumux2_sel = alumux::s_imm;
            ctrl.aluop = alu_add;
            ctrl.mem_write = 1'b1;
            ctrl.store_funct3 = store_funct3;
        end
        op_auipc: begin
            ctrl.alumux1_sel = alumux::pc_out;
            ctrl.alumux2_sel = alumux::u_imm;
            loadRegfile(regfilemux::alu_out);
            ctrl.aluop = alu_add;
        end
        op_lui: begin
            loadRegfile(regfilemux::u_imm);
        end
        op_reg: begin
        //check arith_funct3
            case (arith_funct3)
                slt: begin
                    loadRegfile(regfilemux::br_en);
                    setCMP(cmpmux::rs2_out, blt);
                end
                sltu: begin
                    loadRegfile(regfilemux::br_en);
                    setCMP(cmpmux::rs2_out, bltu);
                end 
                sr: begin
                    loadRegfile(regfilemux::alu_out);
                    ctrl.alumux2_sel = alumux::rs2_out;
                    ctrl.aluop = funct7 ? alu_sra : alu_srl;
                end
                default: begin //reg
                    loadRegfile(regfilemux::alu_out);
                    if (arith_funct3 == add)
                        ctrl.aluop = funct7 ? alu_sub : alu_add;
                    else
                        ctrl.aluop = alu_ops'(funct3);
                    ctrl.alumux2_sel = alumux::rs2_out;
                end
            endcase
        end
        op_jal: begin
            ctrl.alumux1_sel = alumux::pc_out;
            ctrl.alumux2_sel = alumux::j_imm;
            ctrl.aluop = alu_add;
            loadRegfile(regfilemux::pc_plus4);
        end
        op_jalr: begin
            ctrl.alumux1_sel = alumux::rs1_out;
            ctrl.alumux2_sel = alumux::i_imm;
            ctrl.aluop = alu_add;
            loadRegfile(regfilemux::pc_plus4);
        end

        default: ctrl = 0; //something went very, very wrong
    endcase
end
endmodule : control