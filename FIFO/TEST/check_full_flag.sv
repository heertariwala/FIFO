class full_flag_TC extends gen;
	
	function new (mailbox #(trans) gen_drv);
		super.new(gen_drv);
	endfunction
        

	task run();
		// apply reset on write clock
		repeat(1) begin
			trans_h = new();
			assert(trans_h.randomize() with {rstn == 1 ; trans_kind_e == WRITE });
		end

               // apply 20 times write opeation 
	       // expectation :- after 17 times write operation full flag will on
	       // check :- if full flag is on than write operation should not happen   
		repeat(20) begin
			trans_h = new();
			assert(trans_h.randomize() with{ });
		end
	endtask 
endclass
