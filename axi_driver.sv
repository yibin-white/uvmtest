`ifndef AXI_DRIVER_SV
`define AXI_DRIVER_SV

class axi_driver extends uvm_driver#(axi_transfer);

  virtual axi_if vif;

	int number ;

  		typedef enum logic [3 : 0] {IDLE, WRITE_STATE, WAIT_B_VALID, FINISH, BREAK } state_w;

		state_w STATE;

  		typedef enum logic [3 : 0] {idle, read_state, wait_r_valid, finish, break_r } state_r;

		state_r R_STATE;

  	/*	typedef enum logic [3 : 0] {IDLE_B, GET_B_VALID, FINISH_B, BREAK_B } state_b;

		state_b B_STATE;*/

  `uvm_component_utils(axi_driver)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//if (cfg==null)
		  //if (!uvm_config_db#(apb_config)::get(this, "", "cfg", cfg))
		 // `uvm_error("NO CONFIG", "apb_config not set for this component")
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
		
			
  		`uvm_info("my_driver", "RESET", UVM_LOW)
		  @(posedge vif.clk) ;
			if (vif.rstn) begin
	//		reset();
      		`uvm_info("my_driver", "response1", UVM_LOW)
		    seq_item_port.get_next_item(req);
           		`uvm_info("my_driver", "response2", UVM_LOW)
    		    `uvm_info(this.get_type_name(), "sequencer got next item", UVM_HIGH)
    		    drive_transfer(req);
    		    void'($cast(rsp, req.clone()));
    		    rsp.set_sequence_id(req.get_sequence_id());
    		    seq_item_port.item_done(rsp);
    		    `uvm_info(get_type_name(), "sequencer item_done_triggered", UVM_HIGH)
		  end
		end
	
endtask : get_and_drive


protected task reset_listener();
  		`uvm_info(get_type_name(), "reset_listener ...", UVM_HIGH)
  		
    		  forever begin
      		@(negedge vif.rstn); 
  		   	 vif.aw_valid <= 0;
  		 	 vif.aw_addr <= 0;
  		  	 vif.w_valid <= 0;
    		       vif.w_data <= 0;


  		  	 vif.ar_addr <=0;
  		   	 vif.ar_valid <= 0;
  		       vif.r_ready <= 0;
  			 

  		       vif.b_ready <= 0;


		     	
  		 	 
  		  	 

    		  end
  		
endtask


protected task reset();
		begin
  		
 		  	

  		   	 vif.aw_valid <= 0;
  		// 	 vif.aw_addr <= 0;
  		  	 vif.w_valid <= 0;
    		//       vif.w_data <= 0;


  		  	 vif.ar_addr <=0;
  		   	 vif.ar_valid <= 0;
  		       vif.r_ready <= 0;
  			 

  		       vif.b_ready <= 0;


		     
  		

	//	repeat (2)  @(posedge vif.clk);

		end
endtask


protected task drive_transfer(axi_transfer trans);
		`uvm_info("my_driver", "drive_transfer", UVM_LOW)
			STATE = IDLE; 
			R_STATE = idle;
	//		B_STATE = IDLE_B;
		fork
			write_drive(trans);
			read_drive(trans);
	//		back_drive();
		join

endtask


protected task write_drive(axi_transfer trans);
	
			
		while (STATE != BREAK) begin


                 	case(STATE)

				IDLE : 
					begin
   							 
      		`uvm_info("my_driver", "response3", UVM_LOW)
						if (trans.aw_addr <= 193 && trans.aw_addr >= 0) begin
      		`uvm_info("my_driver", "response4", UVM_LOW)
							STATE = WRITE_STATE;
							end
						else begin
      		`uvm_info("my_driver", "response5 WRITE DRIVER END", UVM_LOW)
							STATE = FINISH;
							end
							
							
					end
			
			
		  //		@(posedge vif.clk) ;

				WRITE_STATE : 
				begin


				`uvm_info("my_driver", " at WRITE_STATE", UVM_LOW)
		    		vif.aw_addr <= trans.aw_addr;
				vif.aw_valid <= 1;
	//			vif.b_ready <= 1;
				vif.w_data <= trans.w_data;


			      @(negedge vif.aw_ready) ;
				

				vif.w_valid <= 1;
				`uvm_info("my_driver", "get aw_ready", UVM_LOW)
				vif.b_ready <= 1;

			      @(negedge vif.w_ready) ;

		    		vif.aw_valid <= 0;		
				vif.w_valid <= 0;
				`uvm_info("my_driver", "get w_ready", UVM_LOW)


				STATE = WAIT_B_VALID;
					
				end
				

				WAIT_B_VALID : 

				begin
				`uvm_info("my_driver", "at WAIT_B_VALID", UVM_LOW)
					
				@(negedge vif.b_valid);

					
		//		while(B_STATE != BREAK_B)  begin
		//			@(posedge vif.clk) ;
		//		end
		   			vif.aw_addr <= 32'hzzzzzzzz;
					
					vif.w_data <= 32'hzzzzzzzz;
					vif.b_ready <= 0;
				`uvm_info("my_driver", "get b_valid", UVM_LOW)

				
					STATE = FINISH;	
				
				end

				FINISH : 

						 STATE = BREAK;
							

				
				default : `uvm_error("ERRTYPE", "unrecognized transaction type")

			endcase

		end
		

endtask


protected task read_drive(axi_transfer trans);

			
				
			while (R_STATE != break_r) begin

                 	case(R_STATE)

				idle : 
					begin
   							 
      		`uvm_info("my_driver", "response13", UVM_LOW)
						if (trans.ar_addr <= 193 && trans.ar_addr >= 0) begin
      		`uvm_info("my_driver", "response14", UVM_LOW)
							R_STATE = read_state;
							end
						else begin
      		`uvm_info("my_driver", "response15 READ DRIVER END", UVM_LOW)
							R_STATE = finish;
							end
							
							
							
					end
			
			
		  



				read_state : 
				begin
				`uvm_info("my_driver", " at READ_STATE", UVM_LOW)
		    		vif.ar_addr <= trans.ar_addr;
				vif.ar_valid <= 1;
	//			vif.r_ready <= 1;
		
			      
				
   				 @(negedge vif.ar_ready) ;

				vif.ar_valid <= 0;
				vif.r_ready <= 1;

				`uvm_info("my_driver", "get ar_ready", UVM_LOW)
				R_STATE = wait_r_valid;
						
				end



				wait_r_valid : 
				begin

				@(negedge vif.r_valid);

		//		while (vif.r_valid != 1) begin
		//			@(posedge vif.clk) ;
		//			end
				vif.ar_addr <= 32'hzzzzzzzz;

				`uvm_info("my_driver", "get r_valid", UVM_LOW)



				

				
				
				
				vif.r_ready <= 0;

			


				R_STATE = finish;
					
				end
				

				

				finish : 

						 R_STATE = break_r;
							

						
				default : `uvm_error("ERRTYPE", "unrecognized read_state type")



			endcase

		end		
			
					
endtask		
				
				

				
/*		    	
protected task back_drive();
			


			while (B_STATE != BREAK_B) begin

			

                 	case(B_STATE)

				IDLE_B : 
					begin
   						while (vif.b_valid != 0)	 begin
							@(posedge vif.clk);
							end
					`uvm_info("my_driver", "AT GET_B_VALID STATE", UVM_LOW)
					B_STATE = GET_B_VALID;


      				
					end
			
			
		  



				GET_B_VALID : 


				begin
					@(negedge vif.b_valid);
		    			vif.b_ready = 0;
					B_STATE = FINISH_B;
				end
				
		
			      
				
   				



				FINISH_B : 
				


					 B_STATE = BREAK_B;

				
			

						
				default : `uvm_error("ERRTYPE", "unrecognized read_state type")



			endcase

		end		


endtask
		  
*/		
  		  



endclass: axi_driver



`endif

