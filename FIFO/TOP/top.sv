
import fifo_pkg :: *;

module tb();

time a , b;

bit wr_clk , rd_clk , out;

//istance of base test 
base_test test_h;


//interface 
fifo_inf inf(wr_clk , rd_clk);

// instantiate rtl
Asynchronous_fifo DUT(.wr_clk(wr_clk) ,  
		      .rd_clk(rd_clk) ,
		      .rstn(inf.rstn) ,
		      .wr_enb(inf.wr_enb) ,
		      .rd_enb(inf.rd_enb) ,
		      .input_data(inf.wr_data) ,
		      .output_data(inf.rd_data) ,
		      .full(inf.full) ,
		      .almost_full(inf.almost_full) ,
		      .empty(inf.empty) ,
		      .almost_empty(inf.almost_empty),
		      .half_full(inf.half_full)
	        );


// bind assertions 
bind Asynchronous_fifo 	assertion_fifo AUT(.wr_clk(wr_clk),
					   .rd_clk(rd_clk),
					   .wr_ptr(DUT.wr_ptr),
					   .rd_ptr(DUT.rd_ptr),
					   .wr_enb(wr_enb),
					   .rd_enb(rd_enb),
					   .rstn(rstn),
					   .full(full),
					   .empty(empty),
					   .almost_full(almost_full),
					   .almost_empty(almost_empty),
					   .half_full(half_full),
					   .out(out)
					);


 initial begin
    fork 
 	   forever #5  wr_clk = ~wr_clk;
	   forever #10 rd_clk = ~rd_clk;
    join
 end



 initial begin
	 inf.reset(5);

	 fork 
		 test_h = new(.vif_drv(inf) , .vif_mon(inf) ,. vif_rstn(inf));
		 test_h.build_and_run();
	 join_none
	 #1000;
	 $finish;

 end

 final begin
	test_h.env_h.sb_h.cvg_display();
 end

endmodule 
