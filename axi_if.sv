`ifndef AXI_IF_SV
`define AXI_IF_SV

interface axi_if (input clk, input rstn);


		parameter	 								c_apb_num_slaves = 3;
		bit 	[32*c_apb_num_slaves-1 : 0]			memory_regions1 = 32'd0 + 64'h00000041_00000000 + 96'h00000081_00000000_00000000;
		bit 	[32*c_apb_num_slaves-1 : 0]			memory_regions2 = 32'd64 + 64'h00000080_00000000 + 96'h000000c0_00000000_00000000;

  		 logic [31:0] 				aw_addr;
  		logic [31:0] 				ar_addr;
  		logic [31:0] 				w_data;
  		 logic [31:0] 				r_data;

  		 logic  				      aw_valid;
  		 logic  				      aw_ready;

  		 logic  				      ar_valid;
  		 logic  				      ar_ready;

  		 logic  				      w_valid;
  		 logic  				      w_ready;

  		 logic  				      r_valid;
  		 logic  				      r_ready;
  		 logic  [1:0]				      r_resp;

  		 logic  				      b_ready;
  		 logic  [1:0]				      b_resp;
  		 logic  				      b_valid;


  logic [31:0] paddr;
  logic        pwrite;
  logic  [c_apb_num_slaves-1:0]      psel;
  logic        penable;
  logic [31:0] pwdata;
/*  logic [31:0] prdata;
  logic [31:0] prdata2;
  logic [31:0] prdata3;*/
  logic [c_apb_num_slaves-1:0] p_ready;
  logic [c_apb_num_slaves-1:0]  m_apb_pslverr;

	logic [31:0] prdata[2:0] ;




covergroup cg_axi_transfer @(posedge clk iff rstn);




	aw_valid : coverpoint aw_valid{
			
		//	bins	on_2_off  = (1 => 0) ;
		//	bins	off_2_on  = (0 => 1) ;
			bins  on = {1};
			bins  off = {0};

}


	ar_valid : coverpoint ar_valid{
			
		//	bins	on_2_off  = (1 => 0) ;
		//	bins	off_2_on  = (0 => 1) ;
			bins  on = {1};
			bins  off = {0};
			  



			  

}




	cmd : cross aw_valid, ar_valid {
				
	
			bins idle = binsof(aw_valid.off) &&  binsof(ar_valid.off);
			bins single_write = binsof(aw_valid.on) &&  binsof(ar_valid.off);
			bins single_read = binsof(aw_valid.off) &&  binsof(ar_valid.on);
			bins write_read = binsof(aw_valid.on) &&  binsof(ar_valid.on);







}






endgroup








covergroup cg_apb_transfer @(posedge clk iff rstn);




	pwrite : coverpoint pwrite{
			
		//	bins	on_2_off  = (1 => 0) ;
		//	bins	off_2_on  = (0 => 1) ;
			bins  on = {1};
			bins  off = {0};

}


	penable : coverpoint penable{
			
		//	bins	on_2_off  = (1 => 0) ;
		//	bins	off_2_on  = (0 => 1) ;
			bins  on = {1};
			bins  off = {0};
			  



			  

}




	cmd : cross pwrite, penable {
				
	
			bins idle = binsof (penable.off);
			bins write = binsof(pwrite.on) &&  binsof(penable.on);
			bins read = binsof(pwrite.off) &&  binsof(penable.on);
			







}






endgroup





covergroup cg_sel @(posedge clk iff rstn);




	psel : coverpoint psel{
			
		//	bins	on_2_off  = (1 => 0) ;
		//	bins	off_2_on  = (0 => 1) ;
			bins  sel_1 = {3'b001};
			bins  sel_2 = {3'b010};
			bins  sel_3 = {3'b100};

}


	penable : coverpoint penable{
			
		//	bins	on_2_off  = (1 => 0) ;
		//	bins	off_2_on  = (0 => 1) ;
			bins  on = {1};
			bins  off = {0};
			  



			  

}




	cmd : cross psel, penable {
				
	
			bins sel_1_on = binsof(psel.sel_1) &&  binsof(penable.on);
			bins sel_2_on = binsof(psel.sel_2) &&  binsof(penable.on);
			bins sel_3_on = binsof(psel.sel_3) &&  binsof(penable.on);
			







}






endgroup





/*
  clocking cb_mst @(posedge clk);
    // USER: Add clocking block detail
    default input #1ps output #1ps;
    input r_data, aw_ready, ar_ready, w_ready, r_valid, r_resp, b_resp, b_valid;
    output aw_addr, ar_addr, w_data, aw_valid, ar_valid, w_valid, r_ready, b_ready;
  endclocking : cb_mst

  clocking cb_slv @(posedge clk);
   // USER: Add clocking block detail
    default input #1ps output #1ps;
    input paddr, pwrite, psel, penable, pwdata;
    output prdata;
  endclocking : cb_slv

  clocking cb_mon @(posedge clk);
   // USER: Add clocking block detail
    default input #1ps output #1ps;
    input r_data, aw_ready, ar_ready, w_ready, r_valid, r_resp, b_resp, b_valid, aw_addr, ar_addr, w_data, aw_valid, ar_valid, w_valid, r_ready, b_ready;
  endclocking : cb_mon

  // Coverage and assertions to be implemented here.
  // USER: Add assertions/coverage here
*/
  

	initial begin	
		
		automatic cg_axi_transfer cg1 = new();
		automatic cg_apb_transfer cg2 = new();
		automatic cg_sel cg3 = new();

		end





endinterface : axi_if

`endif 

