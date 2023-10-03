
class full_flag_TC extends gen;
	
	function new (mailbox #(trans) gen_drv);
		super.new(gen_drv);
	endfunction
        

	task run();


               // apply 20 times write opeation 
	       // expectation :- after 17 times write operation full flag will on
	       // check :- if full flag is on than write operation should not happen   
		repeat(20) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == WRITE;  });
                        put_gen_drv();
		end

		repeat(2) begin
			trans_h = new();
			assert(trans_h.randomize() with{ trans_kind_e == READ;  });
                        put_gen_drv();
		end

	endtask 
endclass
