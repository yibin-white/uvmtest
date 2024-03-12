`ifndef AXI_ADDR_SEQUENCE_TEST_SV
`define AXI_ADDR_SEQUENCE_TEST_SV

`include "axi_apb_base_test.sv"


class axi_addr_sequence_test extends axi_apb_base_test;
  


  `uvm_component_utils(axi_addr_sequence_test)

  string tID = get_type_name();


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  task run_phase(uvm_phase phase);
	virtual_sequence vseq ;
	phase.raise_objection(this);
     
      vseq = virtual_sequence::type_id::create("vseq");
     `uvm_info(tID, "virtual_sequence_test begins", "my_sequence")
      vseq.start(env.mst.sequencer);
     
      phase.drop_objection(this);
	
  endtask




  
endclass

`endif
