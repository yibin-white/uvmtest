`ifndef REFERENCE_MODEL_SV
`define REFERENCE_MODEL_SV





class reference_model extends uvm_component;
  

 

  `uvm_component_utils(reference_model)

   axi_transfer ref_trans[$];

	axi_transfer get_trans;
  

  uvm_blocking_get_port #(axi_transfer)  port;
  uvm_analysis_port #(axi_transfer)  analysis_port;

  


  function new(string name, uvm_component parent);
    super.new(name, parent);
		
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
       port = new("port", this);
	analysis_port = new("analysis_port", this);

	
  endfunction 



 


  task run_phase(uvm_phase phase);
		fork
		
		while (1) begin
		port.get(get_trans);
		ref_trans.push_back(get_trans);
  		`uvm_info("my_model", $sformatf("ref_trans number is %d", ref_trans[0].aw_addr), UVM_LOW)
		end
		

		begin
    	 	axi_transfer in_trans  ;
   	 	axi_transfer out_trans ;
   	 	while(1) begin
       	 	wait(ref_trans.size()>0);
       	 	in_trans     =    ref_trans.pop_front();
       	 	out_trans    =    new();
        		out_trans.aw_addr = in_trans.aw_addr;
        		out_trans.ar_addr = in_trans.ar_addr;
        		out_trans.w_data = in_trans.w_data;
        		out_trans.r_data = in_trans.r_data;

        		analysis_port.write(out_trans);
  		`uvm_info("my_model", $sformatf("aw_addr number is %0d", out_trans.w_data), UVM_LOW)
   		 end
		end

		join_none
endtask : run_phase





	
 




 

endclass










`endif
