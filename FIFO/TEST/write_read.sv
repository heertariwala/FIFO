
// check normal operations

class write_read extends gen;
     
     function new(mailbox #(trans) gen_drv);
	     super.new( gen_drv );
     endfunction
     

     // random write and read operation 
     task run();


      //apply 20 times write operation to check "full flag" , "almost_full"
	 //, "half full flag" , " almost em pty flag "
	     
		 trans::reset_after_num_tran = 5;
		 

    	 repeat(20)begin
	     trans_h = new();
	     assert(trans_h.randomize() with { trans_kind_e == WRITE ; });
	     put_gen_drv();
     	 end

         
	 //apply 20 times read operation to check "empty flag" , "almost empty flag" , "almost full flag "
	 //and "half full flag"
    	 repeat(20)begin
	     trans_h = new();
	     assert(trans_h.randomize() with { trans_kind_e == READ ; });
	     put_gen_drv();
     	 end 
	 
       //apply 20 times write operation to check "full flag" , "almost_full"
   	   //, "half full flag" , " almost em pty flag "
    	 repeat(20)begin
	     trans_h = new();
		 //trans_h.reset_after_num_tran = 5;
	     assert(trans_h.randomize() with { trans_kind_e == WRITE ; });
	     put_gen_drv();
     	 end
         
	 //apply 20 times read operation to check "empty flag" , "almost empty flag" , "almost full flag "
	 //and "half full flag"
    	 repeat(20)begin
	     trans_h = new();
	     assert(trans_h.randomize() with { trans_kind_e == READ ; });
	     put_gen_drv();
     	 end 


 endtask

endclass
