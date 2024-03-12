`ifndef AXI_MONITOR_SV
`define AXI_MONITOR_SV





class axi_monitor extends uvm_monitor;
  
   virtual axi_if vif;
 

  `uvm_component_utils(axi_monitor)


  

  uvm_analysis_port #(axi_transfer)  analysis_port;

  axi_transfer mon_trans;

	int transfer_num ;


  function new(string name, uvm_component parent);
    super.new(name, parent);
		
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
       mon_trans = new();
	analysis_port = new("analysis_port", this);
  endfunction 


  task run_phase(uvm_phase phase);

	while (1) begin
		@(posedge vif.clk);
		if (vif.rstn)  begin
  		`uvm_info("my_master_monitor", "RESET", UVM_LOW)
			
		
		 	get_monitor();
		end
	end
  endtask


  task get_monitor();

	axi_transfer trans_temp;

	@(negedge vif.aw_valid or posedge vif.r_valid);


	mon_trans.aw_addr = vif.aw_addr;
	mon_trans.w_data = vif.w_data;
	mon_trans.ar_addr = vif.ar_addr;
	mon_trans.r_data = vif.r_data;
	
	if (!$cast(trans_temp,mon_trans.clone()))
		`uvm_error(get_full_name(),"cast error")
	transfer_num++;

  		`uvm_info("my_master_monitor", $sformatf("transfer number is %d", transfer_num), UVM_LOW)
  		`uvm_info("my_master_monitor", $sformatf("aw_addr number is %d", mon_trans.aw_addr), UVM_LOW)
  		`uvm_info("my_master_monitor", $sformatf("w_data number is %d", mon_trans.w_data), UVM_LOW)
	analysis_port.write(trans_temp);

//	wait (vif.aw_addr == 32'hzzzzzzzz);

endtask

	
 




 

endclass










`endif
