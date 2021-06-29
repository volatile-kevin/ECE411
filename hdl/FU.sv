import rv32i_types::*;

module FU
(   
    input logic clk,
    input logic rst,
    input logic [4:0] rs1_i,
    input logic [4:0] rs2_i,
    input logic [4:0] EXMEM_rd_i,
    input logic [4:0] MEMWB_rd_i,
    input logic EXMEM_reg_write_i,
    input logic MEMWB_reg_write_i,
    input rv32i_word MEMWB_address_i,
    input rv32i_word EXMEM_address_i,
    input rv32i_opcode EXMEM_opcode,
    input rv32i_opcode MEMWB_opcode,

    output forwardAmux::forwardAmux_sel_t forwardAmux_sel,
    output forwardBmux::forwardBmux_sel_t forwardBmux_sel,
    output forwardCmux::forwardCmux_sel_t forwardCmux_sel
);

always_comb
begin
    forwardAmux_sel = forwardAmux::IDEX;
    forwardBmux_sel = forwardBmux::IDEX; //put exmem first because MEMWB's rd could be getting overwritten
    forwardCmux_sel = forwardCmux::RS2;
    if (MEMWB_address_i == EXMEM_address_i && EXMEM_opcode == op_store && MEMWB_opcode == op_load)
        forwardCmux_sel = forwardCmux::MEMWB;

    if(EXMEM_reg_write_i && EXMEM_rd_i && (EXMEM_rd_i == rs1_i)) begin
        forwardAmux_sel = forwardAmux::EXMEM;
        if(EXMEM_opcode == op_load)
            forwardAmux_sel = forwardAmux::EXMEM_rdata;
    end
    else if(MEMWB_reg_write_i && (MEMWB_rd_i != 0) && (MEMWB_rd_i == rs1_i)) begin
        forwardAmux_sel = forwardAmux::MEMWB;
    end

    if(EXMEM_reg_write_i && EXMEM_rd_i && (EXMEM_rd_i == rs2_i)) begin
        forwardBmux_sel = forwardBmux::EXMEM;
        if(EXMEM_opcode == op_load)
            forwardBmux_sel = forwardBmux::EXMEM_rdata;
    end
    else if(MEMWB_reg_write_i && (MEMWB_rd_i != 0) && (MEMWB_rd_i == rs2_i)) begin
        forwardBmux_sel = forwardBmux::MEMWB;
    end
end
endmodule : FU