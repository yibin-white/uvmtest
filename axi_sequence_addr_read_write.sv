`ifndef AXI_SEQUENCE_ADDR_READ_WRITE_SV
`define AXI_SEQUENCE_ADDR_READ_WRITE_SV



class axi_sequence_addr_read_write extends axi_apb_base_test_sequence ;
   
   int cyc_num = 50;
   rand bit [31:0] 				aw_addr;
   rand bit [31:0] 				w_data;
   rand bit [31:0] 				ar_addr;
   

  `uvm_object_utils(axi_sequence_addr_read_write)
  function new(string name=""); 
    super.new(name);
  endfunction : new



  virtual task body();
	axi_transfer req, rsp;
	req = axi_transfer::type_id::create("req");
	rsp = axi_transfer::type_id::create("rsp");
//	repeat(cyc_num) begin	
	
 //    `uvm_do_with(req,  {ar_addr inside {[1:63] }; })


	for(cyc_num = 60; cyc_num <=150; cyc_num++)  begin
			
	
     			`uvm_do_with(req,  {ar_addr == cyc_num; w_data == cyc_num; aw_addr == cyc_num;})
     
			
			get_response(rsp);
end
	

	repeat(cyc_num) begin	
	
    `uvm_do_with(req,  {ar_addr inside {[60:150] }; aw_addr inside {[60:150] };})



//	for(cyc_num = 60; cyc_num <=150; cyc_num++)  begin
			
	
  //   			`uvm_do_with(req,  {ar_addr == cyc_num; w_data == cyc_num; aw_addr == cyc_num;})
     
			
//			get_response(rsp);
	

	

     


     

 

      

    end

  endtask: body


endclass


`endif
