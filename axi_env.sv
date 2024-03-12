`ifndef AXI_ENV_SV
`define AXI_ENV_SV


class axi_env extends uvm_env;
  	axi_master_agent mst;
  	apb_slave_agent slv[];
 // 	reference_model model;
  //	axi_scoreboard scb;

	axi_config cfg;

	int slv_num;

	int number[2:0] ;

	





//	uvm_tlm_analysis_fifo #(axi_transfer) mst_ref_fifo;
//	uvm_tlm_analysis_fifo #(axi_transfer) ref_scb_fifo;
//	uvm_tlm_analysis_fifo #(apb_transfer) slv_scb_fifo;
 
  `uvm_component_utils(axi_env)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase(uvm_phase phase);
    	super.build_phase(phase);


	if(!uvm_config_db#(axi_config)::get(this, "", "cfg", cfg)) begin
	    	`uvm_fatal("GETCFG","cannot get cfg handle from config DB")
	end


	slv_num = cfg.slv_num;


    	mst = axi_master_agent::type_id::create("mst", this); 

	foreach(number[i])begin
		number[i] = i;
	end


	for(int i = 1; i <= slv_num; i++) begin                     
   		slv[i-1] = apb_slave_agent::type_id::create($psprintf("slv[%0d]", i-1), this);
		uvm_config_db#(int)::set(this, $psprintf("slv[%0d]", i-1), "number", number[i-1]);    
	end



//	vif.prdata = slv[0].driver.prdata_p;
//	vif.prdata2 = slv[1].driver.prdata_p;
//	vif.prdata3 = slv[2].driver.prdata_p;



 //   model = reference_model::type_id::create("model", this);  
 //   scb = axi_scoreboard::type_id::create("scb", this);  


//	mst_ref_fifo = new("mst_ref_fifo", this);
//	ref_scb_fifo = new("ref_scb_fifo", this);
//	slv_scb_fifo = new("slv_scb_fifo", this);                                      
  endfunction     


/*  function void connect_phase(uvm_phase phase);
    
	mst.monitor.analysis_port.connect(mst_ref_fifo.analysis_export);
	model.port.connect(mst_ref_fifo.blocking_get_export);
	model.analysis_port.connect(ref_scb_fifo.analysis_export);
	scb.exp_port.connect(ref_scb_fifo.blocking_get_export);
	slv.monitor.analysis_port.connect(slv_scb_fifo.analysis_export);
	scb.act_port.connect(slv_scb_fifo.blocking_get_export);


                
  endfunction */




                                                            
endclass


`endif
