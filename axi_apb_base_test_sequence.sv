`ifndef AXI_APB_BASE_TEST_SEQUENCE_SV
`define AXI_APB_BASE_TEST_SEQUENCE_SV



class axi_apb_base_test_sequence extends uvm_sequence #(axi_transfer);

  
  `uvm_object_utils(axi_apb_base_test_sequence)

  function new(string name=""); 
    super.new(name);
  endfunction : new



    int cyc_num;

endclass



`endif
