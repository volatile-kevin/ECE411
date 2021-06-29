module HDU
(   
    input logic clk,
    input logic rst,
    input logic [4:0] IDEX_rd_i,
    input logic [4:0] IFID_rs1_i,
    input logic [4:0] IFID_rs2_i,
    input logic IDEX_mem_read_i,

    output logic IFID_write_en,
    output logic pc_write_en,
    output logic nop
);

always_comb
begin
    if(IDEX_mem_read_i && ((IDEX_rd_i == IFID_rs1_i) || (IDEX_rd_i == IFID_rs2_i)))
    begin
        IFID_write_en = 0;
        pc_write_en = 0;
        nop = 1;
    end 
    else
    begin
        IFID_write_en = 1;
        pc_write_en = 1;
        nop = 0;
    end
end

endmodule : HDU