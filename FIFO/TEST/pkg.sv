`include "fifo_inf.sv"

package fifo_pkg;

  `include "define.sv"
  `include "trans.sv"
  `include "gen.sv"
  `include "driver.sv"
  `include "monitor.sv"
  `include "ref_model.sv"
  `include "score_board.sv"
  `include "env.sv"

  //test cass
  /*`include "write_read.sv"
  `include "rstn_drn_opn_TC.sv"
  `include "simultaneous_TC.sv"
  `include "b2b_TC.sv"*/
  `include "base_test.sv"
  
endpackage
