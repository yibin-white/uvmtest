`ifndef APB_MONITOR_SV
`define APB_MONITOR_SV





class apb_monitor extends uvm_monitor;
  

 

  `uvm_component_utils(apb_monitor)


  virtual axi_if vif;
	int number;

 // uvm_analysis_port #(apb_transfer)  analysis_port;

  apb_transfer mon_trans;

	int transfer_num ;


  function new(string name, uvm_component parent);
    super.new(name, parent);
		
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
              mon_trans = new();
  	


//	analysis_port = new("analysis_port", this);
  endfunction 


  task run_phase(uvm_phase phase);

	while (1) begin
		@(posedge vif.clk);
		if(vif.rstn) begin
		 	get_monitor();
		end
	end

  endtask


  task get_monitor();

	apb_transfer trans_temp;
	@(posedge vif.r_valid or negedge vif.aw_valid);


	mon_trans.paddr = vif.paddr;
	mon_trans.pwdata = vif.pwdata;
	mon_trans.prdata = vif.prdata[number];
	mon_trans.pwrite = vif.pwrite;
	if (!$cast(trans_temp,mon_trans.clone()))
		`uvm_error(get_full_name(),"cast error")
	transfer_num++;
	
  		`uvm_info("my_slave_monitor", $sformatf("prdata is %0d", vif.prdata[number]), UVM_LOW)
  		`uvm_info("my_slave_monitor", $sformatf("transfer_num is %0d", transfer_num), UVM_LOW)
//	analysis_port.write(trans_temp);


endtask
	
 




 

endclass










`endif
