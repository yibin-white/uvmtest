`ifndef AXI_TRANSFER_SV
`define AXI_TRANSFER_SV

import uvm_pkg::*;

class axi_transfer extends uvm_sequence_item;

  		rand bit [31:0] 				aw_addr;
  		rand bit [31:0] 				ar_addr;
  		rand bit [31:0] 				w_data;
  		rand bit [31:0] 				r_data;

  	/*	 bit  				      aw_valid;
  		 bit  				      aw_ready;

  		 bit  				      ar_valid;
  		 bit  				      ar_ready;

  		 bit  				      w_valid;
  		 bit  				      w_ready;

  		 bit  				      r_valid;
  		 bit  				      r_ready;
  		 bit  [1:0]				      r_resp;

  		 bit  				      b_ready;
  		 bit  [1:0]				      b_resp;
  		 bit  				      b_valid;*/

		




  		
 

  	//	rand int unsigned 			transmit_delay=0;




		
	//	constraint c_transmit_delay { transmit_delay <= 10; }



		
		`uvm_object_utils_begin(axi_transfer)
		  `uvm_field_int(aw_addr, UVM_DEFAULT)
		  `uvm_field_int(ar_addr, UVM_DEFAULT)
		  `uvm_field_int(w_data, UVM_DEFAULT)
		  `uvm_field_int(r_data, UVM_DEFAULT)
		  

	 	`uvm_object_utils_end


function new(string name = "axi_transfer");
   		 super.new(name);
endfunction






endclass


`endif
