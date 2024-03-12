`ifndef APB_SLAVE_AGENT_SV
`define APB_SLAVE_AGENT_SV





class apb_slave_agent extends uvm_agent;

  	virtual axi_if vif;

	int number;
 
  	apb_driver driver;
  	apb_monitor monitor;
  
  `uvm_component_utils(apb_slave_agent)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build();
  	
 	 if( !uvm_config_db#(virtual axi_if)::get(this,"","vif", vif)) begin
    	`uvm_fatal("GETVIF","cannot get vif handle from config DB")
  	end

	if(!uvm_config_db#(int)::get(this, "", "number", number)) begin
	    	`uvm_fatal("GETINT","cannot get int handle from config DB")
	end
 	 
   		`uvm_info($psprintf("my_slave[%0d]", number), $psprintf("number is %0d", number), UVM_LOW)




   	 driver = apb_driver::type_id::create("driver",this);
   	 monitor = apb_monitor::type_id::create("monitor",this);
  
  endfunction 



  function void connect_phase(uvm_phase phase);

     		 driver.vif = vif; 
     		 monitor.vif = vif; 
		driver.number = number;
		monitor.number = number;
      
  
  endfunction 




 

endclass










`endif
