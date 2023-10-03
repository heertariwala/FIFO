class b2b_TC extends gen ;


     function new(mailbox #(trans) gen_drv);
	     super.new( gen_drv );
     endfunction
     

     // random write and read operation 
     task run();


       //apply 20 times back to back write and read operations 
			 
    	 repeat(20)begin
	       trans_h = new();
	       assert(trans_h.randomize() with { trans_kind_e == WRITE ; });
	       put_gen_drv();

	       trans_h = new();
	       assert(trans_h.randomize() with { trans_kind_e == READ  ; });
	       put_gen_drv();

     	 end
         

		endtask
				
endclass
