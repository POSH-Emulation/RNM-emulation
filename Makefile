ZCUIWORK	=		zcui.work
ZEBUWORK	=		zcui.work/zebu.work
EMULATION_RUNDIR		=	emulation
EMULATION_SRC			=	emulation_src
SIMULATION_RUNDIR		=	simulation
SIMULATION_SRC			=	simulation_src

compil:
	REMOTECMD="$(REMOTECMD)" VCS_HOME="${VCS_HOME}" SNPS_ZEBU_ZFAST_RNM_SYNTHESIS_SUPPORT=1 zCui -u project.utf -n -e -c -w $(ZCUIWORK)

run_zebu: simulation
	make -C $(ZEBUWORK) -f dpixtor.mk clean all
	\rm -rf $(EMULATION_RUNDIR)
	\mkdir $(EMULATION_RUNDIR)
	\cd $(EMULATION_RUNDIR) && \ln -s ../$(EMULATION_SRC)/compile
	\cd $(EMULATION_RUNDIR) && \ln -s ../$(EMULATION_SRC)/main.fwc.cc
	\cd $(EMULATION_RUNDIR) && g++ $(ARCHI) -g -fPIC -o testbench.fwc main.fwc.cc -I../$(ZEBUWORK) -I$(ZEBU_ROOT)/include/ -L$(ZEBU_ROOT)/lib -lZebuZEMI3 -lZebu -rdynamic ../$(ZEBUWORK)/*.so
	\cd $(EMULATION_RUNDIR) && ./testbench.fwc |&tee run.log
	\cd $(EMULATION_RUNDIR) && \grep SNPS run.log | \sed 's/# //'> run.sort.log
	\cd $(EMULATION_RUNDIR) && zConvertToFsdb -i myfwc.ztdb -o myfwc.fsdb --timescale 1ns --zebu-work ../$(ZEBUWORK)

simulation:
	\rm -rf $(SIMULATION_RUNDIR)
	\mkdir $(SIMULATION_RUNDIR)
	\cd $(SIMULATION_RUNDIR) && \ln -s ../$(SIMULATION_SRC)/run
	\cd $(SIMULATION_RUNDIR) && \ln -s ../$(SIMULATION_SRC)/eg.sv
	\cd $(SIMULATION_RUNDIR) && \ln -s ../$(SIMULATION_SRC)/constants.vams
	\cd $(SIMULATION_RUNDIR) && ./run

run: run_zebu
	diff -b -B $(EMULATION_RUNDIR)/run.sort.log $(SIMULATION_RUNDIR)/run.sort.log; if [ $$? -eq 0 ]; then echo "TEST OK"; else echo "### Simulation V.S. Emulation mismatch"; echo "TEST KO"; exit 1; fi

clean:
	\rm -rf *.log novas* fsdbhierdiag.txt nWaveLog vcsdebug zebu_nettype_support_*.v ZEBU_GLOBAL_SYSTEM_DIR_global_mngt.db
	\rm -rf $(SIMULATION_RUNDIR)
	\rm -rf $(EMULATION_RUNDIR)

.PHONY : clean simulation run run_zebu compil 
