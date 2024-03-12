`ifndef AXI_CONFIG_SV
`define AXI_CONFIG_SV


class axi_config extends uvm_object;

  int slv_num = 3;
 
  

		`uvm_object_utils_begin(axi_config)
		  `uvm_field_int(slv_num, UVM_DEFAULT)
	 	`uvm_object_utils_end

  function new(string name=""); 
    super.new(name);
  endfunction : new

	




                                                            
endclass


`endif
