class base_test;
  //environment class instance 
  env env_h;

  //test cases class handles 
  /*write_read           wr_rd_h;
  rstn_drn_opn_TC      rstn_drn_opn_TC_h;
  simultaneous_TC      simultaneous_TC_h; 
  b2b_TC               b2b_TC_h;*/
 
 
  virtual fifo_inf.DRIVER  vif_drv ;
  virtual fifo_inf.MONITOR vif_mon;
  virtual fifo_inf         vif_rstn;

  function new( virtual fifo_inf.DRIVER vif_drv ,
                virtual fifo_inf.MONITOR vif_mon,
		        virtual fifo_inf        vif_rstn );
	
    this.vif_drv  = vif_drv ;
	this.vif_mon  = vif_mon ;
	this.vif_rstn = vif_rstn;

  endfunction
  

  task build_and_run();
    	  
    env_h = new(.vif_mon(vif_mon) , .vif_drv(vif_drv) , .vif_rstn(vif_rstn) );
    
    env_h.build();

    /*if($test$plusargs("NORMAL_WRITE_READ")) begin
      wr_rd_h = new( env_h.gen_drv);
      env_h.gen_h = wr_rd_h ; 
    end
    

    if($test$plusargs("RSTN_DRN_OPN_TC")) begin
      rstn_drn_opn_TC_h = new(env_h.gen_drv);
      env_h.gen_h = rstn_drn_opn_TC_h ; 
    end

    if($test$plusargs("SIMULTANEOUS_TC")) begin
      simultaneous_TC_h = new(env_h.gen_drv);
      env_h.gen_h = simultaneous_TC_h ; 

    end

    if($test$plusargs("B2B_TC")) begin
      b2b_TC_h = new(env_h.gen_drv);
      env_h.gen_h = b2b_TC_h ; 
    end*/

    

    env_h.run();


  endtask



endclass

