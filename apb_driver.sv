`ifndef APB_DRIVER_SV
`define APB_DRIVER_SV

class apb_driver extends uvm_driver#(apb_transfer);

  	virtual axi_if vif;
	int number;

	bit   [31:0]  mem_fifo[bit[31:0]];

	//bit  [31:0]  prdata_p;

	apb_transfer apb_trans;

  `uvm_component_utils(apb_driver)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//if (cfg==null)
		  //if (!uvm_config_db#(apb_config)::get(this, "", "cfg", cfg))
		 // `uvm_error("NO CONFIG", "apb_config not set for this component")
		apb_trans = new();
endfunction : build_phase



function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
endfunction : connect_phase



 






		



		


task run_phase(uvm_phase phase);

     
		fork

     
		  reset_listener();	
    
	
			
    
		  get_and_drive();     
	
	

			
		join_none
    


endtask : run_phase


protected task get_and_drive();
	
	//	reset();
     
		forever begin
		
			
  	//	`uvm_info("my_driver", "RESET", UVM_LOW)
		  @(posedge vif.clk) ;
			if (vif.rstn) begin
				
    		    			drive_transfer(apb_trans);
					
				end
    		    
    		   
		 
		end
	
endtask : get_and_drive


protected task reset_listener();
  		`uvm_info(get_type_name(), "reset_listener ...", UVM_HIGH)
  		
    		  forever begin
      		@(negedge vif.rstn); 
  		   	 vif.prdata[number] <= 0;
  		 	 vif.p_ready <= 3'b111;
  		  	 vif.m_apb_pslverr <= 0;
    		       


		     	
  		 	 
  		  	 

    		  end
  		
endtask


protected task reset();
		begin
  		
 		  	@(posedge vif.clk);

 		   	 vif.prdata[number] <= 0;
  		 	 vif.p_ready <= 3'b111;
  		  	 vif.m_apb_pslverr <= 0;


		     
  		

	

		end
endtask


protected task drive_transfer(apb_transfer trans);
	//	`uvm_info("my_driver", "drive_transfer", UVM_LOW)
			
		fork
				begin
					@(negedge vif.w_ready);
					if(vif.psel[number] == 1) begin

		//			@(posedge vif.b_ready);
		//			while (vif.b_valid == 0) begin
		//				@(posedge vif.clk);
		//				end
					trans.pwdata = vif.w_data;
					trans.paddr = vif.aw_addr;
					mem_fifo[trans.paddr] = trans.pwdata;
		//			@(posedge vif.clk);
		//			`uvm_info("my_driver", "RECIEVE W_DATA", UVM_LOW)
				end
				end

				begin

					@(negedge vif.ar_ready);
					if(vif.psel[number] == 1) begin

		//			while (vif.ar_ready == 0) begin
		//				@(posedge vif.clk);
		//				end
					trans.paddr = vif.ar_addr;
					vif.prdata[number] = mem_fifo[trans.paddr];
					@(negedge vif.r_valid);
					vif.prdata[number] = 32'hzzzzzzzz;
		//			@(posedge vif.clk);
		//			`uvm_info("my_driver", "PUTOUT R_DATA", UVM_LOW)
				end
				end
		
		join_none
endtask



			
					
		
				
				

				
		    	

			



		    
		  
		
  		  



endclass: apb_driver



`endif

