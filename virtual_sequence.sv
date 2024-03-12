`ifndef VIRTUAL_SEQUENCE_SV
`define VIRTUAL_SEQUENCE_SV

`include "axi_sequence_addr_burst.sv"
`include "axi_sequence_addr.sv"
`include "axi_sequence_addr_read.sv"
`include "axi_sequence_addr_read_write.sv"


class virtual_sequence extends axi_apb_base_test_sequence ;
   
   axi_sequence_addr_burst seq1;
   axi_sequence_addr seq2;
   axi_sequence_addr_read seq3;
   axi_sequence_addr_read_write seq4;
   

  `uvm_object_utils(virtual_sequence)
  function new(string name=""); 
    super.new(name);
  endfunction : new



  virtual task body();

   

	

      seq1 = axi_sequence_addr_burst::type_id::create("seq1");
     `uvm_do_with(seq1 , {} )

      seq2 = axi_sequence_addr::type_id::create("seq2");
     `uvm_do_with(seq2 , {} )

      seq3 = axi_sequence_addr_read::type_id::create("seq3");
     `uvm_do_with(seq3 , {} )
	
      seq4 = axi_sequence_addr_read_write::type_id::create("seq4");
     `uvm_do_with(seq4 , {} )

	

	

	

     


     

 

      

    

  endtask: body


endclass


`endif
