module icache_datapath (
  input clk,

  /* CPU memory data signals */
  input logic  [31:0]  mem_byte_enable,
  input logic  [31:0]  mem_address,
  input logic  [255:0] mem_wdata,
  output logic [255:0] mem_rdata,

  /* Physical memory data signals */
  input  logic [255:0] pmem_rdata,
  output logic [255:0] pmem_wdata,
  output logic [31:0]  pmem_address,

  /* Control signals */
  input logic tag_load,
  input logic valid_load,
  input logic dirty_load,
  input logic dirty_in,
  input logic check_next,
  output logic dirty_out, dirty_out_next,
  output logic valid_out, valid_out_next,

  output logic hit, hit_next,
  input logic [1:0] writing,
  input logic prefetching
);

logic [255:0] line_in, line_out, line_temp;
logic [23:0] address_tag, tag_out, tag_out_next;
logic [2:0]  index, windex;
logic [31:0] mask;
logic [31:0]  store_address;

always_ff @(posedge clk) begin
  if(check_next) begin
    //line_temp <= line_out;
    store_address <= mem_address +32;
	end
  else begin 
    //line_temp <= line_temp;
    store_address <= store_address;
	end
end

always_comb begin
  index = mem_address[7:5];
  windex = index;
  address_tag = mem_address[31:8];
  hit = valid_out && (tag_out == address_tag);
  hit_next = valid_out_next && (tag_out_next == address_tag);
  mem_rdata = line_out;
  pmem_wdata = line_out;
  pmem_address = (dirty_out) ? {tag_out, mem_address[7:0]} : mem_address;
  if (prefetching) begin
    pmem_address = store_address;
    windex = pmem_address[7:5];
    //need to think about how we are gonna load the new tag/valid/dirty
  end
  
  // if(check_next) begin
  //   index = mem_address[7:5] + 1'b1;
  //   pmem_address = (dirty_out) ? {tag_out, mem_address[7:0]} : mem_address + 32;
  // end

  case(writing)
    2'b00: begin // load from memory
      mask = 32'hFFFFFFFF;
      line_in = pmem_rdata;
    end
    2'b01: begin // write from cpu
      mask = mem_byte_enable;
      line_in = mem_wdata;
    end
    default: begin // don't change data
      mask = 32'b0;
      line_in = mem_wdata;
    end
	endcase
end

idata_array DM_cache (clk, mask, index, windex, line_in, line_out);
iarray #(24) tag (clk, tag_load, index, windex, address_tag, tag_out, tag_out_next);
iarray #(1) valid (clk, valid_load, index, windex, 1'b1, valid_out, valid_out_next);
iarray #(1) dirty (clk, dirty_load, index, windex, dirty_in, dirty_out, dirty_out_next);

endmodule : icache_datapath
