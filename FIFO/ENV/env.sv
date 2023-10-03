class env;
  // all verification component 	
  monitor	     mon_h;
  driver         drv_h;
  score_board    sb_h;
  ref_mod        rf_h;
  gen		     gen_h;


  //  mailbox  
  mailbox #(trans) gen_drv = new() ;
  mailbox #(trans) rf_sb   = new() ;
  mailbox #(trans) mon_sb  = new() ;
  mailbox #(trans) mon_rf  = new() ;
//  mailbox #(trans) mon_sb_wr = new();


  // interface 
  virtual fifo_inf.MONITOR vif_mon;
  virtual fifo_inf.DRIVER  vif_drv;
  virtual fifo_inf         vif_rstn    ;

  //new function
  function new(virtual fifo_inf.MONITOR vif_mon,
  	      virtual fifo_inf.DRIVER vif_drv,
          virtual fifo_inf        vif_rstn ); 
      this.vif_mon = vif_mon;
      this.vif_drv = vif_drv;
	  this.vif_rstn = vif_rstn;
  endfunction


  //creating object of each envronment component
  task build();
    gen_h = new(gen_drv);
    mon_h = new(.mon_rf(mon_rf)  , .mon_sb(mon_sb) , .vif(vif_mon));
    drv_h = new(.gen_drv(gen_drv), .vif(vif_drv) , .vif_rstn(vif_rstn));
    sb_h  = new(.mon_sb(mon_sb)  , .rf_sb(rf_sb) , .vif(vif_mon) );
    rf_h  = new(.mon_rf(mon_rf)  , .rf_sb(rf_sb) , .vif(vif_mon));   
  endtask
  
  // run task 
  task run();
    fork
      gen_h.run();	    
      mon_h.run();
      drv_h.run();
      sb_h.run();
      rf_h.run();
    join_any    
  endtask 


  

endclass
