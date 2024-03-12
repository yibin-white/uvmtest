`ifndef AXI_MASTER_AGENT_SV
`define AXI_MASTER_AGENT_SV





class axi_master_agent extends uvm_agent;
  virtual axi_if vif;

 
  axi_driver driver;
  axi_sequencer sequencer;
  axi_monitor monitor;

  `uvm_component_utils(axi_master_agent)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build();
  	// get config

  
  	// get virtual interface
 	 if( !uvm_config_db#(virtual axi_if)::get(this,"","vif", vif)) begin
    	`uvm_fatal("GETVIF","cannot get vif handle from config DB")
  	end
 	 // create and config to monitor/driver/sequencer
 


    	sequencer = axi_sequencer::type_id::create("sequencer",this);

   	 driver = axi_driver::type_id::create("driver",this);

   	 monitor = axi_monitor::type_id::create("monitor",this);

  
  endfunction 



  function void connect_phase(uvm_phase phase);
		sequencer.vif = vif; 
     		 driver.vif = vif; 
     		 monitor.vif = vif; 
   		 driver.seq_item_port.connect(sequencer.seq_item_export); 
      
  
  endfunction 




 

endclass










`endif
