`define DATA_WIDTH 8
`define ADDR_WIDTH 4
`define DEPTH 16

module  Asynchronous_fifo( rstn , wr_clk , rd_clk , wr_enb ,rd_enb, input_data , output_data , full , empty , almost_full , almost_empty , half_full );

input 						  rstnp, 
						wr_clk, 
						rd_clk,
						wr_enb, 
						rd_enb;

input		[(`DATA_WIDTH -1) : 0]		input_data;
output reg 	[(`DATA_WIDTH -1) : 0] 		output_data;


output  full , empty , almost_full;
output  almost_empty , half_full  ;


reg [(`DATA_WIDTH -1):0] mem [0:`DEPTH-1];
reg [(`ADDR_WIDTH):0] 			i , j;
reg [(`ADDR_WIDTH): 0] rd_ptr , wr_ptr	 ;

always @(posedge wr_clk or negedge rstn) begin 
	if(!rstn) begin 
		for(i = 0; i<`DEPTH ; i = i+1) begin 
			mem[i] <= 0;
		end
	
		rd_ptr <= 0;
		wr_ptr <= 0;
                output_data <= 0;

	end // rstn of rd_clk
	
	else begin 
		if(!full && wr_enb) begin

			mem[wr_ptr[ (`ADDR_WIDTH - 1) : 0] ] <= input_data;
			wr_ptr <= wr_ptr + 1'b1;	

		end	
	end 
end //end always block of wr_clk
//

always@(posedge rd_clk or negedge rstn) begin 
	if(!rstn) begin  
		for(j = 0 ; j<`DEPTH ; j = j+1) begin
			mem[j] <= 0; 
		end
		rd_ptr <= 0 ;
		wr_ptr <= 0;
                output_data <= 0;
	end
	else begin
		if(!empty && rd_enb) begin	
		output_data <= mem[rd_ptr[(`ADDR_WIDTH-1):0]];
		rd_ptr <= rd_ptr + 1'b1;
		end
	end
end


assign full         =    ({ ( ~wr_ptr[`ADDR_WIDTH ]) , wr_ptr[`ADDR_WIDTH-1 : 0 ]}  ==  rd_ptr);
assign empty        =    ( wr_ptr                                 ==   rd_ptr );
assign almost_full  =    (((wr_ptr - rd_ptr)  == (`DEPTH - 1'b1)) || ((rd_ptr - wr_ptr)  == (`DEPTH + 1'b1)));
assign almost_empty =    (( (wr_ptr - rd_ptr) == (1) )            || ((rd_ptr - wr_ptr)  == ((`DEPTH*2)-1)));
assign half_full    =    (((wr_ptr - rd_ptr)  == (`DEPTH/2))      || ((rd_ptr - wr_ptr)  == (`DEPTH/2)));

 

endmodule 
