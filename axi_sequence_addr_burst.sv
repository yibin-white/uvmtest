`ifndef AXI_SEQUENCE_ADDR_BURST_SV
`define AXI_SEQUENCE_ADDR_BURST_SV



class axi_sequence_addr_burst extends axi_apb_base_test_sequence ;
   
   
   rand bit [31:0] 				aw_addr;
   rand bit [31:0] 				w_data;
   rand bit [31:0] 				ar_addr;


  `uvm_object_utils(axi_sequence_addr_burst)
  function new(string name=""); 
    super.new(name);
  endfunction : new



  virtual task body();
	axi_transfer req, rsp;
	req = axi_transfer::type_id::create("req");
	rsp = axi_transfer::type_id::create("rsp");
		
	

     `uvm_do_with(req,  {aw_addr == 32'd0 ; w_data == 32'd0; })
	get_response(rsp);

	

	

     


     

 

      

    

  endtask: body


endclass


`endif
