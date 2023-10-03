
/*
  task write();
    @(vif.monitor_wr);	  
    rf_trans  		      =  new();
    rf_trans.trans_kind_e[1]  =  vif.monitor_wr.wr_enb ;
    rf_trans.trans_kind_e[0]  =  vif.monitor_rd.rd_enb ;
    rf_trans.wr_data          =  vif.monitor_wr.wr_data;
    rf_trans.rstn             =  vif.monitor_wr.rstn   ;
    rf_trans.almost_full      =  vif.monitor_wr.almost_full ;
    rf_trans.full             =  vif.monitor_wr.full        ;
    rf_trans.almost_empty     =  vif.monitor_wr.almost_empty;
    rf_trans.half_full        =  vif.monitor_wr.half_full   ;
    
    mon_rf.put(rf_trans);

  endtask


  task read(); 
    @(vif.monitor_rd);
    act_trans                  =  new();
    act_trans.trans_kind_e[1]  =  vif.monitor_wr.wr_enb ;
    act_trans.trans_kind_e[0]  =  vif.monitor_rd.rd_enb ;
    act_trans.rd_data          =  vif.monitor_rd.rd_data;
    act_trans.full             =  vif.monitor_rd.full   ;
    act_trans.almost_full      =  vif.monitor_rd.almost_full;
    act_trans.almost_empty     =  vif.monitor_rd.almost_empty;
    act_trans.empty            =  vif.monitor_rd.empty       ;
    act_trans.half_full        =  vif.monitor_rd.half_full   ;
    
    mon_sb.put(act_trans);
  endtask

*/
 /* 
  task run(); 
   forever
     fork
       @(vif.monitor_rd) send_to_act();
       @(vif.monitor_wr) send_to_rf ();  			 
     join_any

  endtask

   


  // store data in act act_trans and put in act_sb_mailbox 
    task send_to_act();
    act_trans = new();

    act_trans.rstn         =  vif.monitor_rd.rstn;	 
    act_trans.rd_data      =  vif.monitor_rd.rd_data;
   // $cast( act_trans.trans_kind_e , {vif.monitor_wr.wr_enb, vif.monitor_rd.rd_enb} );
    act_trans.full         =  vif.monitor_rd.full   ;
    act_trans.empty        =  vif.monitor_rd.empty  ;
    act_trans.half_full    =  vif.monitor_rd.half_full;
    act_trans.almost_full  =  vif.monitor_rd.almost_full ; 
    act_trans.almost_empty =  vif.monitor_rd.almost_empty;

    //put act_trans 
    mon_sb.put(act_trans);
    	 
  endtask :send_to_act



  // store data in exp_trans which is comming from 
  task send_to_rf();

    rf_trans 		      =  new();
    //flag_wr_trans	      =  new();

    rf_trans.rstn             =  vif.monitor_wr.rstn   ;
    rf_trans.wr_data          =  vif.monitor_wr.wr_data;
    rf_trans.trans_kind_e[1]  =  vif.monitor_wr.wr_enb ; 
    rf_trans.trans_kind_e[0]  =  vif.monitor_rd.rd_enb ;
    
    //put rf_trans
    mon_rf.put(rf_trans);
			 
  endtask :send_to_rf

  
	 
*/



  task write();
    trans_h.trans_kind_e[1]  =  vif.monitor_wr.wr_enb      ;
    trans_h.wr_data          =  vif.monitor_wr.wr_data     ;
    trans_h.rstn             =  vif.monitor_wr.rstn        ;
    trans_h.almost_full      =  vif.monitor_wr.almost_full ;
    trans_h.full             =  vif.monitor_wr.full        ;
    trans_h.almost_empty     =  vif.monitor_wr.almost_empty;
    trans_h.half_full        =  vif.monitor_wr.half_full   ;
  endtask


  task read(); 
    trans_h.trans_kind_e[0]  =  vif.monitor_rd.rd_enb ;
    trans_h.rd_data          =  vif.monitor_rd.rd_data;
    trans_h.full             =  vif.monitor_rd.full   ;
    trans_h.almost_full      =  vif.monitor_rd.almost_full;
    trans_h.almost_empty     =  vif.monitor_rd.almost_empty;
    trans_h.empty            =  vif.monitor_rd.empty       ;
    trans_h.half_full        =  vif.monitor_rd.half_full   ;
    
    $display("\n",$time, "read :- %p" , trans_h);
    mon_rf.put(trans_h);
    mon_sb.put(trans_h);
  endtask

