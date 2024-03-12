`timescale 1ns/1ns





`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "axi_if.sv"
  

module axi_apb_tb;



`include "axi_apb.svh" 



  reg clk;
  reg rstn;

	reg [31:0]prdata1;
	reg [31:0]prdata2;
	reg [31:0]prdata3;




parameter c_apb_num_slaves = 3;
parameter [32*c_apb_num_slaves-1 : 0]  memory_regions1  = 32'd0 + 64'h00000041_00000000 + 96'h00000081_00000000_00000000;
parameter [32*c_apb_num_slaves-1 : 0]  memory_regions2  = 32'd64 + 64'h00000080_00000000 + 96'h000000c0_00000000_00000000;






   
	


  initial begin 
		#10ns; 
		clk = 1'b0;
        forever #5ns clk = !clk;                                              //set initial signals :clk rst
  end


  initial begin
        #10ns;
        rstn <= 1'b1;
        #5ns;
        rstn <= 1'b0;
	  #5ns;
        rstn <= 1'b1;

      end
   
 


  axi_if intf(clk, rstn);

  initial begin 
		assign prdata1 = intf.prdata[0]; 
		assign prdata2 = intf.prdata[1]; 
		assign prdata3 = intf.prdata[2]; 
	                                             
  end




axi_apb_bridge #(
	.c_apb_num_slaves(c_apb_num_slaves),
	.memory_regions1(memory_regions1),
	.memory_regions2(memory_regions2)

    )



   axi_apb_bridge_user 

    (
   .s_axi_clk(clk),
   .s_axi_aresetn(rstn),
   .s_axi_awaddr(intf.aw_addr),
   .s_axi_awvalid(intf.aw_valid),
   .s_axi_awready(intf.aw_ready),
   .s_axi_wdata(intf.w_data),
   .s_axi_wvalid(intf.w_valid),
   .s_axi_wstrb(),
   .s_axi_wready(intf.w_ready),
   .s_axi_bresp(intf.b_resp),
   .s_axi_bvalid(intf.b_valid),
   .s_axi_bready(intf.b_ready),
   .s_axi_araddr(intf.ar_addr),
   .s_axi_arvalid(intf.ar_valid),
   .s_axi_arready(intf.ar_ready),
   .s_axi_rresp(intf.r_resp),
   .s_axi_rvalid(intf.r_valid),
   .s_axi_rdata(intf.r_data),
   .s_axi_rready(intf.r_ready),
   .s_axi_arprot(),
   .s_axi_awprot(),
   .m_apb_paddr(intf.paddr),
   .m_apb_pprot(),
   .m_apb_psel(intf.psel),
   .m_apb_penable(intf.penable),
   .m_apb_pwrite(intf.pwrite),
   .m_apb_pwdata(intf.pwdata),
   .m_apb_pstrb(),
   .m_apb_pready(intf.p_ready),
   .m_apb_prdata(intf.prdata[0]),
   .m_apb_prdata2(intf.prdata[1]),
   .m_apb_prdata3(intf.prdata[2]),
   .m_apb_prdata4(),
   .m_apb_prdata5(),
   .m_apb_prdata6(),
   .m_apb_prdata7(),
   .m_apb_prdata8(),
   .m_apb_prdata9(),
   .m_apb_prdata10(),
   .m_apb_prdata11(),
   .m_apb_prdata12(),
   .m_apb_prdata13(),
   .m_apb_prdata14(),
   .m_apb_prdata15(),
   .m_apb_prdata16(),
   .m_apb_pslverr(intf.m_apb_pslverr)
);






  initial begin
    uvm_config_db#(virtual axi_if)::set(null, "uvm_test_top.env.mst", "vif", intf);                //set interface
    uvm_config_db#(virtual axi_if)::set(null, "uvm_test_top.env.slv[0]", "vif", intf);                //set interface
    uvm_config_db#(virtual axi_if)::set(null, "uvm_test_top.env.slv[1]", "vif", intf);                //set interface
    uvm_config_db#(virtual axi_if)::set(null, "uvm_test_top.env.slv[2]", "vif", intf);                //set interface
    run_test("axi_addr_sequence_test");											//set intended sequence(test)
  end		



			

initial	begin
	    $fsdbDumpfile("tb.fsdb");
	    $fsdbDumpvars;
end			



initial       begin
   		#100000 $finish;
 end													

endmodule

