//import rv32i_types::rv32i_word;
//import rv32i_types::rv32i_opcode;
import rv32i_types::*;
import stage_ports::*;

module mem
(
    input clk,
    input rst,
    input logic mem_read,
    input logic mem_write,
    input logic[3:0] mem_byte_enable_i,
    input rv32i_word address_i,
    input rv32i_word rs2_i,
    input rv32i_word regfile_i,
    input forwardCmux::forwardCmux_sel_t forwardCmux_sel,
    input store_funct3_t store_funct3,
    input logic mem_resp,
    input logic br_en,
    input rv32i_opcode opcode,
    input rv32i_word ex_pc,
    input rv32i_word cur_pc,
    input rv32i_word id_pc,
    input rv32i_word if_pc,
    output rv32i_word mem_wdata_o,
    output rv32i_word address_o,
    output logic[3:0] mem_byte_enable_o,

    output logic memstall,
    output logic flush_pipeline
);

rv32i_word mem_wdata_i;

always_comb begin
    case (forwardCmux_sel)
        forwardCmux::RS2: mem_wdata_i = rs2_i;
        forwardCmux::MEMWB: mem_wdata_i = regfile_i;
    endcase
end

// For branch and jump instructions
always_comb begin
    if (br_en && opcode == op_br && address_i != ex_pc) begin
        flush_pipeline = 1'b1;
    end
    else if (!br_en && opcode == op_br) begin
        if(ex_pc != 0)
            if(cur_pc+4 != ex_pc)
                flush_pipeline = 1'b1;
            else 
                flush_pipeline = 0;
        else if(id_pc != 0)
            if(cur_pc+4 != id_pc)
                flush_pipeline = 1'b1;
            else
                flush_pipeline = 0;
        else if(if_pc != 0)
            if(cur_pc + 4 != if_pc)
                flush_pipeline = 1'b1;
            else
                flush_pipeline = 0;
        else 
            flush_pipeline = 0;
    end
    else if(opcode == op_jal || opcode == op_jalr)begin
        flush_pipeline = 1;
    end
    else begin
        flush_pipeline = 0;
    end
end

always_comb begin
    //defaults
    mem_byte_enable_o = mem_byte_enable_i;
    address_o = address_i;
    mem_wdata_o = 0;

    if (mem_write) begin
        case (store_funct3)
            sb: begin //find out which byte to send and shift it
                case (address_i & 2'b11)
                    0: begin
                        mem_byte_enable_o = 4'b0001;
                        mem_wdata_o = mem_wdata_i << 0;
                    end
                    1: begin
                        mem_byte_enable_o = 4'b0010;
                        mem_wdata_o = mem_wdata_i << 8;
                    end
                    2: begin
                        mem_byte_enable_o = 4'b0100;
                        mem_wdata_o = mem_wdata_i << 16;
                    end
                    3: begin
                        mem_byte_enable_o = 4'b1000;
                        mem_wdata_o = mem_wdata_i << 24;
                    end
                endcase
            end
            sh: begin
                case (address_i & 2'b10)
                    0: begin
                        mem_byte_enable_o = 4'b0011;
                        mem_wdata_o = mem_wdata_i << 0;
                    end
                    2: begin
                        mem_byte_enable_o = 4'b1100;
                        mem_wdata_o = mem_wdata_i << 16;
                    end
                endcase
            end
            sw: begin
                mem_byte_enable_o = 4'b1111;
                mem_wdata_o = mem_wdata_i;
            end
        endcase
    end
end


always_comb begin
    if((mem_read||mem_write) && !mem_resp) 
        memstall = 0;
    else
        memstall = 1;
end

endmodule : mem