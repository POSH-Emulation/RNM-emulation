# RNM-emulation
Enabling emulation capability for AMS real number models

Real number models (RNM) are a mechanism for creating behavioral abstractions of an analog mixed-signal (AMS) design.  These models are used in simulation because they execute much faster than their SPICE netlist counterparts.  However, due to several factors, such as the use of floating-point numbers as signal values, AMS RNMs are currently unable to be run on hardware emulators.  This results in much slower verification performance since emulation can be orders of magnitude faster than simulation.  The POSH RNM Emulation technology aims to remove this problem by enabling the emulation software to support AMS constructs (like floating-point numbers) that exist in RNMs.

An RNM example of a low-pass filter is illustrated, showing the RNM (eg.sv), support files (project.utf, simon.opt, constants.vams, Makefile) and the testbench (in the emulation_src folder).  The simulation and emulation folders will be created when run in VCS with the command options -compile:vcs_cmd.sh.  The log file produced is run_log_full_passed.

The flow is as follows:
1.  Set ZEBU_ROOT
2.  % make clean
3.  To run simulation:
    % make simulation
4.  To run emulation:
    a. Compilation:
       % make compil
    b. Log in to an emulator system and type:
       % source $ZEBU_ROOT/zebu_env.csh
       % setenv SYSTEMSIM_HOME/u/tools/co-design/v2.3.6/bin/arch/i686_Linux_2.4.2-2/
       % set path=($SYSTEMSIM_HOME $path)
       % setenv LD_LIBRARY_PATH ${SYSTEMSIM_HOME}:${LD_LIBRARY_PATH}
       % make run
