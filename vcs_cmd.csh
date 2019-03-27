#!/bin/csh
vcs -full64 -xlrm coerce_nettype -wreal res_def -sverilog eg.sv -lca -debug_access+all -realport -kdb -hw_top=LPF1s_TB -l vcs.log +define+EMULATION -Xzemi3=dynamic_array -lca -Xdmma2=0x2000   
