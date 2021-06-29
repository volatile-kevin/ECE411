module cacheline_adaptor
(
    input clk,
    input reset_n,

    // Port to LLC (Lowest Level Cache)
    input logic [255:0] line_i,
    output logic [255:0] line_o,
    input logic [31:0] address_i,
    input read_i,
    input write_i,
    output logic resp_o,

    // Port to memory
    input logic [63:0] burst_i,
    output logic [63:0] burst_o,
    output logic [31:0] address_o,
    output logic read_o,
    output logic write_o,
    input resp_i
);

int count = 0;
int count2 = 0;
logic [31:0] addr;
assign addr = address_i;
logic [255:0] line_out = 123;
assign line_o = line_out;

always_comb begin
    if (~reset_n) begin
        //$display("hello %d", $time);
        //line_out = 0;
        //address_o = 0;
    end
end 

always_ff @(posedge clk) begin
    if (read_i) begin
        read_o <= 1'b1;
        if (count == 0)
            count <= 1;
        address_o <= addr;
    end 

    if (write_i) begin 
       write_o <= 1'b1;
        if (count2 == 0)
            count2 <= 1;
        address_o <= addr;
        line_out <= line_i;
        burst_o <= line_out[63:0];
    end

    if (reset_n) begin
        count <= 0;
        count2 <= 0;
        address_o <= addr;
        burst_o <= 64'b0;
        read_o <= 1'b0;
        write_o <= 1'b0;
        line_out <= 256'b0;
        resp_o <= 1'b0;
    end

    else if ((count2 && resp_i) || count2 == 5 || count2 == 6)begin 
        //$display("lineo: %h %d", line_out, $time);
        if (count2 == 1) begin 
            burst_o <= line_out[127:64];
            count2 <= 2;
        end
        else if (count2 == 2) begin 
            burst_o <= line_out[191:128];
            
            count2 <= 3;
        end
        else if (count2 == 3) begin 
            burst_o <= line_out[255:192];
            count2 <= 4;
        end
        else if (count2 == 4) begin 
            count2 <= 5;
            write_o <= 1'b0;
        end
        else if (count2 == 5) begin
            resp_o <= 1'b1;
            count2 <= 6;
            write_o <= 1'b0;
            
        end
        else if (count2 == 6) begin
            resp_o <= 1'b0;
            write_o <= 1'b0;
            count2 <= 0;
        end
        //$display("bursto: %h %d", burst_o, $time);
    end



    
    else if ((count && resp_i) || count == 5 || count == 6) begin
    //    $display("count: %d", count);
        if (count == 1) begin
            line_out[63:0] <= burst_i;
            //$display("burst     %d", burst_i);
            count<=2;
        end
        else if (count == 2) begin 
            line_out[127:64] <= burst_i;
            //$display("burst     %d", burst_i);
            count<=3;
        end
        else if (count == 3) begin 
            line_out[191:128] <= burst_i;
            //$display("burst     %d", burst_i);
            count<=4;
        end
        else if (count == 4) begin 
            line_out[255:192] <= burst_i;
            //$display("burst4     %d", burst_i);
            count<=5;
            read_o <= 1'b0;
        end
        else if (count == 5) begin
            //$display("got here  %d", $time);
            //$display("lineo     %d", line_out);
            resp_o <= 1'b1;
            count<=6;
            read_o <=1'b0;
        end
        else if (count == 6) begin 
            count <= 0;
            resp_o <= 1'b0;
            read_o <= 1'b0;
            end
    end
end 

endmodule : cacheline_adaptor
