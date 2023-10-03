class monitor;

  // trans class handler 	  
  trans act_trans , rf_trans ,trans_h , trans_h1 ;

  //mailbox for monitor to scoreboard 
  mailbox #(trans) mon_sb;
  mailbox #(trans) mon_rf;
 

  // interface 
  virtual fifo_inf.MONITOR vif;

  //new function 
  function new( mailbox #(trans) mon_sb ,
             mailbox #(trans) mon_rf   ,      
             virtual fifo_inf.MONITOR vif);
	 this.mon_rf    =  mon_rf ; 
	 this.mon_sb    =  mon_sb ; 
	 this.vif       =  vif    ;		 
  endfunction 


 // run task , monitor from interface and store in trans_h class 
 task run();
    trans_h  = new();
	wait(vif.rstn);
	forever  begin 
    	fork
			begin
                fork
             
                   forever begin
                           //if write clock event is triggere than write task call 
                           @(vif.monitor_wr) write();
                   end
             
                   forever begin
                           //if read clock event is triggere than read task call 
                           @(vif.monitor_rd) read();
                   end
 
   		       join

            end // forever / fork / begin
			begin
					@(negedge vif.rstn);
					$info("reset asserted ");
			end
		join_any		
        // if any thread will complete than stop monitoring and wait
		// posedge of reset signal
		disable fork;
        // wait till reset to one
		wait(vif.rstn);

	end		
 endtask



  // write task workes on write clocking block
  task write();
    trans_h.trans_kind_e[1]  =  vif.monitor_wr.wr_enb      ;   
    trans_h.trans_kind_e[0]  =  0                          ;
    trans_h.wr_data          =  vif.monitor_wr.wr_data     ;
    trans_h.almost_full      =  vif.monitor_wr.almost_full ;
    trans_h.full             =  vif.monitor_wr.full        ;
    trans_h.almost_empty     =  vif.monitor_wr.almost_empty;
    trans_h.half_full        =  vif.monitor_wr.half_full   ;
	trans_h.empty            =  vif.monitor_wr.empty       ;

    mon_rf.put(trans_h);
    mon_sb.put(trans_h);

  endtask

  //read task working on read clock 
  task read();
    
    trans_h.trans_kind_e[1]  =  0                          ;   //(same trans) when read clock came at that time if write enable is on than it data re write								  		in rf model
    trans_h.trans_kind_e[0]  =  vif.monitor_rd.rd_enb      ; 
    trans_h.rd_data          =  vif.monitor_rd.rd_data     ;
    trans_h.full             =  vif.monitor_rd.full        ;
    trans_h.almost_full      =  vif.monitor_rd.almost_full ;
    trans_h.almost_empty     =  vif.monitor_rd.almost_empty;
    trans_h.empty            =  vif.monitor_rd.empty       ;
    trans_h.half_full        =  vif.monitor_rd.half_full   ;
    
    mon_rf.put(trans_h);
    mon_sb.put(trans_h);
  endtask
	
endclass
