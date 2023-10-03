class rstn_drn_opn_TC extends gen;
	
	function new (mailbox #(trans) gen_drv);
		super.new(gen_drv);
	endfunction
        

	task run();
		
        // write some data in fifo
		repeat(10) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == WRITE;  });
                        put_gen_drv();
		end

		repeat(5) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == READ ;  });
                        put_gen_drv();
		end

 		
 		//trans_h.reset_after_num_tran = 15;
        //put_gen_drv();


		repeat(12) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == WRITE;  });
                        put_gen_drv();
		end

  

		repeat(2) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == READ ;  });
                        put_gen_drv();
		end


	endtask 
endclass
