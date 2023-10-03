//virtual class gen;
class gen;
	trans trans_h;

	mailbox #(trans) gen_drv;
	
	

	function  new( mailbox #(trans) gen_drv );
		this.gen_drv = gen_drv ;
	endfunction 

        
	// pure virtual task for generating sequence 
//	pure virtual task run();
	task run();
	repeat(20)begin
	     trans_h = new();
	     assert(trans_h.randomize() with { trans_kind_e == WRITE ; });
	     put_gen_drv();
    end
	repeat(20)begin
	     trans_h = new();
	     assert(trans_h.randomize() with { trans_kind_e == READ ; });
	     put_gen_drv();
    end
	repeat(10)begin
	     trans_h = new();
	     assert(trans_h.randomize() with { trans_kind_e == SIM_RW ; });
	     put_gen_drv();
    end
	endtask
        

	// task for put data in generator to driver mailbox 
	protected task put_gen_drv();
		gen_drv.put(trans_h);
	endtask


endclass


