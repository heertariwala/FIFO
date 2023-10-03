// cover group sample with sample function
// pass transection class as argument
//

  covergroup fifo_cvg with function sample (trans trans_h , virtual fifo_inf.MONITOR vif) ;
        option.comment = "FIFO  coverage ";
        
	// when rstn is high than check trans kind bins 
	TRANS_KIND : coverpoint trans_h.trans_kind_e iff(vif.rstn) {
		option.comment = "trans_kind";
		bins trans_kind[] = { READ , WRITE };
		bins trans_wr_rd  = (WRITE => READ );
		bins trans_rd_wr  = (READ  => WRITE);
}
        
	// when rstn is high than check back to back bins 
	TRANS_KIND_B_2B : coverpoint trans_h.trans_kind_e iff(vif.rstn) {
		option.comment   ="trans_kind_B2B";
		bins trans_b2b_r_w_r = (READ => WRITE=>READ);
	    bins trans_b2b_w_r_w = (WRITE => READ => WRITE);	
	}
       

       // bins for full signal
	FULL : coverpoint trans_h.full iff(vif.rstn){
		option.comment = "FULL_FLAG";
		bins full_c   = ( 0 => 1 );
		bins full_c1  = ( 1 => 0 );
	}

        // when reset is low than empty should be on
	EMPTY_RSTN: coverpoint trans_h.empty iff(!vif.rstn){
		option.comment = "EMPTY_AT_RSTN";
		bins empty_rstn_c   = (0 => 1);
	}

        // bins for empty signal
	EMPTY: coverpoint trans_h.empty iff(vif.rstn){
		option.comment = "WHEN RESET IS OFF check EMPTY";
		bins empty_c  = (0 => 1);
		bins empty_c1 = (1 => 0);
	}

        // bins for almost full signal
	ALMOST_FULL : coverpoint trans_h.almost_full iff(vif.rstn){
		option.comment = "ALMOST FULL";
	        bins almost_full_c  = (0 => 1 );
			bins almost_full_c1 = (1 => 0 );

	}

        // bins for amost empty signal
	ALMOST_EMPTY : coverpoint trans_h.almost_empty iff(vif.rstn){
		option.comment = "almost  empty ";
		bins almost_empty_c  = (0 => 1 );
		bins almost_empty_c1 = (1 => 0 );
	}

	// bins for half full signal
	HALF_FULL : coverpoint trans_h.half_full iff(vif.rstn){
		option.comment = "half full ";
		bins almost_empty_c = (0 => 1 );
		bins almost_empty_c1 = (1 => 0 );
	}


        // bins for read data with range 
	READ_DATA : coverpoint trans_h.rd_data iff(vif.rstn){
		option.comment = "read data ";
	        bins low_range  = {[0:63]};
	        bins mid_range  = {[64:127]};
	        bins high_range = {[128:255]};	
	}

  endgroup





  
class score_board;
  trans exp_trans , act_trans;
  trans exp_trans_c , act_trans_c;

  // covergroup handle 
  fifo_cvg fifo_cvg_h;

  mailbox #(trans) mon_sb ;
  mailbox #(trans) rf_sb  ;
  
  // virtual interface 
  virtual fifo_inf.MONITOR vif;

  // new function
  function new ( mailbox #(trans) mon_sb ,
  		 mailbox #(trans) rf_sb, 
        virtual fifo_inf.MONITOR vif);
    this.mon_sb = mon_sb ;
    this.rf_sb  = rf_sb  ;
	this.vif    = vif    ;
    fifo_cvg_h  = new();
  endfunction

 // diplay coverage percentage 
 // use in final block 
 function cvg_display();
	 $display("coverage :- " , fifo_cvg_h.get_coverage());
 endfunction 
  
  task run();
    forever begin
	
    // act trans handle get from monitor
    mon_sb.get(act_trans);

	//exp trans handle get from monitor
	rf_sb.get(exp_trans);

	//comparing act and exp trans
	cmp_act_exp(act_trans , exp_trans);

	//display values
	act_trans.sb_display(act_trans , exp_trans);
       
	// coverage sample and send actual value 
	fifo_cvg_h.sample(act_trans , vif);
        

	
    end	    
  endtask

 //compare act trans and expected trans;
 task cmp_act_exp(trans act_trans_t , trans exp_trans_t);


     // comparing read data 
     if(act_trans_t.rd_data !== exp_trans_t.rd_data)
         $error($time,"--FAIL-- !! act_rd_data :- %3d  , exp_rd_data :- %3d" , act_trans_t.rd_data , exp_trans_t.rd_data );
    
     // comparing empty signal
     if(act_trans_t.empty !== exp_trans_t.empty)
         $error($time,"--FAIL-- !! act_empty :- %d  , exp_empty :- %d" , act_trans_t.empty , exp_trans_t.empty );

     //comparing full signal
     if(act_trans_t.full !== exp_trans_t.full)
         $error($time,"--FAIL-- !! act_full :- %d  , exp_full :- %d" , act_trans_t.full , exp_trans_t.full );

     //comparing almost full
     if(act_trans_t.almost_full !== exp_trans_t.almost_full)
         $error($time,"--FAIL-- !!  act_almost_full :- %d  , exp_almost_full :- %d" , act_trans_t.almost_full , exp_trans_t.almost_full );

     //comparing almost empty
     if(act_trans_t.almost_empty !== exp_trans_t.almost_empty)
         $error($time,"--FAIL-- !!  act_almost_empty :- %d  , exp_almost_empty :- %d" , act_trans_t.almost_empty , exp_trans_t.almost_empty );

     //comparing almost empty
     if(act_trans_t.almost_empty !== exp_trans_t.almost_empty)
	   $error($time,"--FAIL-- !!  act_half_full :- %d  , exp_half_full :- %d" , act_trans_t.half_full , exp_trans_t.half_full );

    
 endtask  

endclass
