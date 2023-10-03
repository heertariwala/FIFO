//typedef driver;

interface fifo_inf(input bit wr_clk , rd_clk );
		
	logic rstn;
		

	//write signals
	
	logic 		   	     wr_enb  ;
	logic [(`DATA_WIDTH-1) : 0 ] wr_data ;

	//read signals
	
	logic 			     rd_enb  ;

	//output signals 
	logic [(`DATA_WIDTH-1) : 0 ] rd_data ;
	logic 			     full    ;
	logic  			     empty   ;
	logic 			     almost_full;
	logic 			     almost_empty;
	logic 			     half_full;



	// clocking block for driver workes on wr clock
	clocking driver_wr@(posedge wr_clk  );
		default input #0 output #1;
		
		input   rstn ;
	        output  wr_enb;
		output  wr_data ;
	endclocking 

        // clocking block for driver workes on read cock
	clocking driver_rd@(posedge rd_clk);
		default input #0 output #1;
		input rstn ;
	        output	rd_enb ;
	endclocking 


        // cocking block for monitor workes on write clock
	clocking monitor_wr@(posedge wr_clk);
		default input #0 output #1;
		input rstn , wr_enb ;
		input wr_data ;
		input full, almost_full , almost_empty , half_full , empty;   // sb
	endclocking 


	// clocking block for monitor workes on read clock
	clocking monitor_rd@(posedge rd_clk);
		default input #0 output #1;
		input rstn , rd_enb;
		input rd_data;
		input full ,almost_full , almost_empty , empty , half_full  ;
	endclocking 


	modport DRIVER(clocking driver_wr   , clocking driver_rd , input rstn);

	modport MONITOR(clocking monitor_wr , clocking monitor_rd , input rstn);


	task reset(int delay = 1);

 					$display("===============RESET applyed=========================");
	   rstn = 0;
	   	
       //##vif.driver_wr;
	   #delay;
	    // @    :-  (1 -> 0) but again (0 -> 1) dont work perfectely
	    // wait :-  than constant one 
		  $display("=============== now apply one  =====================");
	    rstn = 1 ;

	endtask

	/*task reset();

	   rstn = 0;
	   	
       @(posedge wr_clk);
	   
	    // @    :-  (1 -> 0) but again (0 -> 1) dont work perfectely
	    // wait :-  than constant one 
		  $display("=============== now apply one  =====================");
	    rstn = 1 ;

	endtask*/

	
endinterface 
