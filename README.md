# RNM-emulation
Enabling emulation capability for AMS real number models

Real number models (RNM) are a mechanism for creating behavioral abstractions of an analog mixed-signal (AMS) design.  These models are used in simulation because they execute much faster than their SPICE netlist counterparts.  However, due to several factors, such as the use of floating-point numbers as signal values, AMS RNMs are currently unable to be run on hardware emulators.  This results in much slower verification performance since emulation can be orders of magnitude faster than simulation.  The POSH RNM Emulation technology aims to remove this problem by enabling the emulation software to support AMS constructs (like floating-point numbers) that exist in RNMs.
