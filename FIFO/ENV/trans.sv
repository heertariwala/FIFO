
class trans;

            // trans kind
	rand trans_kind trans_kind_e ;


            // write data 
	rand bit [`DATA_WIDTH - 1 : 0 ] wr_data ; 

            // read data
	     bit [`DATA_WIDTH - 1 : 0 ] rd_data ;

	    //flags 
	     bit			full;
	     bit 			empty ;
	     bit 			almost_full ;
	     bit 			almost_empty ;
	     bit 			half_full ;  

	static int reset_after_num_tran = 500 ;	




	 // display specific for score board    
	task sb_display(trans act_trans , trans exp_trans);     
	  $display("\n--------Score_board_display-----------------");
	  $display(" sig Name   | act Value | exp value |time");
	  $display("trans_kind  | %5p     | %5p     | %5t " , act_trans.trans_kind_e , exp_trans.trans_kind_e , $time);
	  $display(" rd_data    | %5d     | %5d     | %5t " , act_trans.rd_data , exp_trans.rd_data , $time);
	  $display(" full       | %5d     | %5d     | %5t " , act_trans.full , exp_trans.full , $time);	
	  $display(" empty      | %5d     | %5d     | %5t " , act_trans.empty , exp_trans.empty , $time);
	  $display("almost_full | %5d     | %5d     | %5t " , act_trans.almost_full , exp_trans.almost_full , $time );
	  $display("almost_emp  | %5d     | %5d     | %5t " , act_trans.almost_empty , exp_trans.almost_empty , $time);
	  $display(" half_full  | %5d     | %5d     | %5t " , act_trans.half_full , exp_trans.half_full  , $time);

	endtask


        // 
	task display();
		$display("\n--------------------------------------");
		$display(" sig Name  |  Value  |time");
		$display("wr_data    | %5d  |%5t" , wr_data , $time);
		$display("rd_data    | %5d  |%5t" , rd_data , $time);
		$display("full       | %5d  |%5t" , full, $time);
		$display("almost_full| %5d  |%5t" , almost_full, $time);
		$display("empty      | %5d  |%5t" , empty, $time);
		$display("almost_empty| %5d |%5t" ,almost_empty, $time);
		$display("half_full  | %5d  |%5t" , half_full, $time);

	endtask		

endclass
