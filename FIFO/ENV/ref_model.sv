class ref_mod;
  // trans class handle	
  trans trans_exp , trans_h1; 

  //class mailbox 
  mailbox #(trans) mon_rf ;
  mailbox #(trans) rf_sb  ;
 
  //que array  
   bit [`DATA_WIDTH-1 : 0 ] que [$];

   // virtual interface 
   virtual fifo_inf.MONITOR vif;

  
  function new ( mailbox #(trans) mon_rf ,
	         mailbox #(trans) rf_sb,
	         virtual fifo_inf.MONITOR vif );
	 this.mon_rf    =  mon_rf ;
	 this.rf_sb     =  rf_sb  ;
	 this.vif       =  vif    ;
  endfunction  

  
  task run();
    trans_exp = new();
    forever begin

      // get data from monitor to referance model   
      mon_rf.get(trans_h1);			
      
      // call task to predict data
      predict_data(trans_h1);     

      //put dat in referance model to score board
      rf_sb.put(trans_exp);				      

    end
  endtask 


  task predict_data(input trans trans_h );  				// change name if error 
    if(!vif.rstn) begin
	    que = {};
	    trans_exp = new();
    end
    else begin

			// if input is read or simultaneous than read operation happen from que array and
       // store in read data

		if(!trans_exp.empty && ( (trans_h.trans_kind_e == READ)  || (trans_h.trans_kind_e == SIM_RW) ))
	        trans_exp.rd_data = que.pop_front();	

	    // if input is write or simultaneous than write operation happen in que array
	    if((!trans_exp.full) && ( (trans_h.trans_kind_e == WRITE) || (trans_h.trans_kind_e == SIM_RW) ))
	       que.push_back(trans_h.wr_data);


      
    // if fofo size is equal to depth than full flag will be on 
    if(que.size == `DEPTH)	    
	    trans_exp.full = 1;
    else 
	    trans_exp.full = 0;

    // almost full logic 
    if(que.size() == (`DEPTH - 1) )
	    trans_exp.almost_full = 1 ;
    else 
	    trans_exp.almost_full = 0 ;

    // almost empty logic
    if(que.size() == 1)
	    trans_exp.almost_empty = 1;
    else 
	    trans_exp.almost_empty = 0; 

    // empty logic
    if(que.size() == 0)
	    trans_exp.empty = 1;
    else 
	    trans_exp.empty = 0;

    // half full logic
    if(que.size() == (`DEPTH/2))
	    trans_exp.half_full = 1;
    else 
	    trans_exp.half_full = 0;

   end
    
  endtask


endclass
