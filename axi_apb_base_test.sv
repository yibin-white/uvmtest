`ifndef AXI_APB_BASE_TEST_SV
`define AXI_APB_BASE_TEST_SV





class axi_apb_base_test extends uvm_test;
  

  	axi_env env;
	axi_config cfg;
 

  `uvm_component_utils(axi_apb_base_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	env = axi_env::type_id::create("env", this);                     
   	cfg = new();  

	uvm_config_db#(axi_config)::set(this, "env", "cfg", cfg);                  
    
    




  endfunction
endclass

`endif
