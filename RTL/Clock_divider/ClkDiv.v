module ClkDiv #(
parameter div_ratio_width = 5
) (
input wire                               i_ref_clk,
input wire                               i_rst_n,
input wire                               i_clk_en,
input wire  [div_ratio_width-1:0]        i_div_ratio,
output reg                               o_div_clk            
);

reg  [div_ratio_width-2:0]   Count ;
wire [div_ratio_width-2:0]   edge_flip_half ;  
wire [div_ratio_width-2:0]   edge_flip_full ; 
reg                          odd_edge_tog_flag ;                                         
reg                          div_clk;
wire                         clk_en;

always @(posedge i_ref_clk or negedge i_rst_n ) 
begin
    if (!i_rst_n) begin
        Count <= 0;
	    div_clk <= 0;
        odd_edge_tog_flag <= 0;	
    end else if (clk_en) begin
        case (i_div_ratio[0])
            1'b0:begin           // even div_ratio
                if (Count == edge_flip_half) begin
                    Count <= 0;                                        
                    div_clk <= ~ div_clk;                               
                end else begin
                    Count <= Count + 1'd1;
                end 
            end


            1'b1:begin          // odd div_ratio
                if (((Count == edge_flip_half) && !odd_edge_tog_flag) || ((Count == edge_flip_full) && odd_edge_tog_flag)) begin
                    Count <= 0;                                        
                    div_clk <= ~ div_clk;
                    odd_edge_tog_flag <= ~ odd_edge_tog_flag;                        
                end else begin
                    Count <= Count + 1'd1;
                end 
            end
        endcase
end   

assign o_div_clk = (i_clk_en & (i_div_ratio == 'd0) & (i_div_ratio == 'd1)) ?  div_clk : i_ref_clk ;
assign clk_en = (i_clk_en & (i_div_ratio != 'd0) & (i_div_ratio != 'd1)) ?  1'b1 : 1'b0 ;
assign edge_flip_half = (i_div_ratio>>1);
assign edge_flip_full = edge_flip_half + 1;

endmodule