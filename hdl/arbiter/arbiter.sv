import rv32i_types::*;

module arbiter(
    input clk,
    input rst,

    //to caches (_i = instr, _d = data )
    output logic mem_resp_i, 
    output logic mem_resp_d, 
    output logic [255:0] mem_rdata_i,
    input logic [255:0] mem_wdata_i,
    output logic [255:0] mem_rdata_d,
    input logic [255:0] mem_wdata_d,
    input logic mem_read_i,
    input logic mem_write_i,
    input logic mem_read_d,
    input logic mem_write_d,
    input rv32i_word mem_address_i,
    input rv32i_word mem_address_d,
    
    //to cacheline
    input logic [255:0] pmem_rdata,
    output logic [255:0] pmem_wdata,
    input logic pmem_resp,
    output logic pmem_read,
    output logic pmem_write,
    output rv32i_word pmem_address

   // icache/dcache -> arbiter -> cacheline_adapter -> pmem
);
//logic [2:0] state, next_states;

enum int unsigned{
    IDLE=1, INST_ONLY=2,
    INST_DATA=3, DATA_ONLY=4
} state, next_states;

always_comb begin
    //defaults
    mem_resp_i = '0;
    mem_resp_d = '0;
	 pmem_read = '0;
	 pmem_address = 32'b0;
	 mem_rdata_i = 255'b0;
	 mem_rdata_d = 255'b0;
	 pmem_read  = '0;
	 pmem_write = '0;
	 pmem_wdata = 255'b0;
	 

    case (state)
        IDLE: begin
            
        end
        INST_ONLY: begin 
            pmem_read = mem_read_i;
            pmem_address = mem_address_i;
            mem_rdata_i = pmem_rdata;
            mem_resp_i = pmem_resp;
        end
        INST_DATA: begin 
            pmem_read = mem_read_i;
            pmem_address = mem_address_i;
            mem_rdata_i = pmem_rdata;
            mem_resp_i = pmem_resp;
        end
        DATA_ONLY: begin //data only
            pmem_read = mem_read_d;
            pmem_write = mem_write_d;
            pmem_address = mem_address_d;
            mem_rdata_d = pmem_rdata;
            pmem_wdata = mem_wdata_d;
            
            mem_resp_d = pmem_resp;
        end
    endcase
end

always_comb begin
    next_states = IDLE;
    case (state)
        IDLE: begin 
            if (mem_read_i && (mem_read_d || mem_write_d)) next_states = INST_DATA;
            else if (mem_read_i) next_states = INST_ONLY;
            else if (mem_read_d || mem_write_d) next_states = DATA_ONLY;
            else next_states = IDLE;
        end
        INST_ONLY: begin 
            if ((mem_read_d || mem_write_d)) next_states = INST_DATA;
            else if (pmem_resp) next_states = IDLE;
            else next_states = INST_ONLY; //waiting for mem, no data accesses
        end
        INST_DATA: begin 
            if (pmem_resp) next_states = DATA_ONLY;
            else next_states = INST_DATA; //waiting for mem (instruction access)
        end
        DATA_ONLY: begin
            if (pmem_resp) next_states = IDLE;
            else next_states = DATA_ONLY;
        end
    endcase
    
end

always_ff @(posedge clk) begin
    state <= next_states;
end
endmodule : arbiter