`ifndef APB_TRANSFER_SV
`define APB_TRANSFER_SV



class apb_transfer extends uvm_sequence_item;

  bit [31:0] paddr;
  bit        pwrite;
  bit [2:0]       psel;
  bit        penable;
  bit [31:0] pwdata;
  bit [31:0] prdata;
  bit [c_apb_num_slaves-1:0] p_ready;
//  bit [c_apb_num_slaves-1:0]  m_apb_pslverr;


		




  		
 

  	//	rand int unsigned 			transmit_delay=0;




		
	//	constraint c_transmit_delay { transmit_delay <= 10; }



		
		`uvm_object_utils_begin(apb_transfer)
		  `uvm_field_int(paddr, UVM_DEFAULT)
		  `uvm_field_int(pwrite, UVM_DEFAULT)
		  `uvm_field_int(pwdata, UVM_DEFAULT)
		  `uvm_field_int(prdata, UVM_DEFAULT)
		  `uvm_field_int(p_ready, UVM_DEFAULT)
		  

	 	`uvm_object_utils_end


function new(string name = "apb_transfer");
   		 super.new(name);
endfunction






endclass


`endif
