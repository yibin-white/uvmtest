`ifndef AXI_SEQUENCER_SV
`define AXI_SEQUENCER_SV




class axi_sequencer extends uvm_sequencer #(axi_transfer);

  `uvm_component_utils(axi_sequencer)

  virtual axi_if vif;


 function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


endclass : axi_sequencer


`endif

