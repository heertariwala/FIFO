class empty_flag_TC extends gen;
	
	function new (mailbox #(trans) gen_drv);
		super.new(gen_drv);
	endfunction
        

	task run();



               // apply 18 times write opeation 
	       // expectation :- after 17 times write operation full flag will on
	       // check :- if full flag is on than write operation should not happen   
		repeat(18) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == WRITE;  });
                        put_gen_drv();
		end

		// applay 18 times read operation
		// expectation :- after 17 times read empry flag should be on
		// check :- empty flag 
		repeat(18) begin
			trans_h = new();
			assert(trans_h.randomize() with{trans_kind_e == READ ;  });
                        put_gen_drv();
		end

	endtask 
endclass
