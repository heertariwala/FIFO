class simultaneous_TC extends gen;
	
	function new (mailbox #(trans) gen_drv);
		super.new(gen_drv);
	endfunction
        

	task run();


                //applay simultaneous read and write 
		//check :- simultaneous working properly or not 

	repeat(20) begin
		trans_h = new();
		assert(trans_h.randomize() with{ trans_kind_e == SIM_RW;  });
                put_gen_drv();
		end
	endtask 

endclass
