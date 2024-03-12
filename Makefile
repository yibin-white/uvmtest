
export UVM_HOME=/home/synopsys/uvm/uvm-1.1d

include /home/synopsys/uvm/uvm-1.1d/examples/Makefile.vcs




vcs_opts=-full64 \
	-sverilog \
	-timescale=1ns/1ps \
	+v2k \
	-lca \
	-debug_access+all \
	-fsdb \

file:
	find -name "*.v" >> filelist.f



compile:
	vcs \
	 -full64 \
	 +v2k \
	 +incdir+$(incfile) \
	 -sverilog \
	 +define+SIMULATION_EN \
	 -timescale=1ns/1ns \
	 -error=noMPD \
	 -f filelist.f \
	 -P $(VERDI_HOME)/share/PLI/VCS/LINUX64/novas.tab $(VERDI_HOME)/share/PLI/VCS/LINUX64/pli.a \
	 +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
	 $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
	 -debug_all \
	 -cm assert \





elaborate:
	vcs #$(vcs_opts) \#
	#-top work.axi_apb_tb \#
	-o ./simv \



simulate:
	./simv +notimingcheck +nospecify +ntb_random_seed=${SEED}  \
	-cm_assert \
	-cm_name axi_apb_test \
	-l covergroup_log/sim.log \

	



verdi:
	verdi -f filelist.lst -ssf tb.fsdb \



coverage:
	dve -cov \
	-full64 -dir ./simv.vdb \



clean:
	rm -rf AN.DB DVEfiles csrc simv.* *simv inter.vpd ucli.key *.log *fsdb verdiLog nWaveLog tb.fsdb.* novas.* work 
