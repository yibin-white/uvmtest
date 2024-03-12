`ifndef AXI_SCOREBOARD_SV
`define AXI_SCOREBOARD_SV





class axi_scoreboard extends uvm_scoreboard;
  

 

  `uvm_component_utils(axi_scoreboard)

   
  

  uvm_blocking_get_port #(axi_transfer)  exp_port;
  uvm_blocking_get_port #(apb_transfer)  act_port;

  axi_transfer exp_trans[$];


  function new(string name, uvm_component parent);
    super.new(name, parent);
		
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
       exp_port = new("exp_port", this);
	act_port = new("act_port", this);
  endfunction 





  		task run_phase(uvm_phase phase);
			axi_transfer get_exp_trans,  temp_trans;
			apb_transfer get_act_trans;

			bit result;
				fork
					while (1) begin
						exp_port.get(get_exp_trans);
						exp_trans.push_back(get_exp_trans);
					end

					while (1) begin
						act_port.get(get_act_trans);
						wait (exp_trans.size() > 0) begin
							temp_trans = exp_trans.pop_front();
						
							case (get_act_trans.pwrite)

								0: begin
									
									if ((get_act_trans.paddr == temp_trans.ar_addr) && (get_act_trans.prdata == temp_trans.r_data))	begin
									result = 1;
      								`uvm_info("my_scoreboard", "compare successful", UVM_LOW)
									end
									else
      								`uvm_info("my_scoreboard", "compare wrong", UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("paddr number is %d", get_act_trans.paddr), UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("ar_addr number is %d", temp_trans.ar_addr), UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("prdata number is %d", get_act_trans.prdata), UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("r_data number is %d", temp_trans.r_data), UVM_LOW)
									
								end

								1: begin
									if ((get_act_trans.paddr == temp_trans.aw_addr) && (get_act_trans.pwdata == temp_trans.w_data))	begin
									result = 1;
      								`uvm_info("my_scoreboard", "compare successful", UVM_LOW)
									end	
									else
      								`uvm_info("my_scoreboard", "compare wrong", UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("paddr number is %d", get_act_trans.paddr), UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("aw_addr number is %d", temp_trans.aw_addr), UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("pwdata number is %d", get_act_trans.pwdata), UVM_LOW)
      								`uvm_info("my_scoreboard", $sformatf("w_data number is %d", temp_trans.w_data), UVM_LOW)


								end

								default: 
									
      								`uvm_info("my_scoreboard", "pwrite wrong", UVM_LOW)

							endcase

						end
					end
				join_none
			




 		 endtask


 


			
endclass





`endif
