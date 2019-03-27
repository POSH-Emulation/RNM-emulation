`include "constants.vams"
//`timescale 1ns/1ps 
module LPF1s(OUT,IN,clk); 
output OUT; 
input IN; 
output clk;
real OUT,IN; 
bit clk;
always #5 clk = ~clk;
parameter real Fp = 10000000;  // corner frequency (Hz) 
parameter real Ts = 10;  // sample rate (sec) 
real d0,d1,ts_ns; 
initial begin  
ts_ns = Ts/1;    // sample rate converted to nanoseconds  
d0 = 1+2/(`M_TWO_PI*Fp*Ts);  // denominator coeffficients
d1 = 1-2/(`M_TWO_PI*Fp*Ts); 
end 
real INold,OUTval;    // saved values of input & output 
always #(ts_ns) begin    // sample input every Ts seconds 
 OUTval = (IN + INold - OUTval*d1)/d0; // compute output from input & state 
 INold = IN;     // save old value for use next step
end 
assign OUT = OUTval;   // pass value to output pin 
endmodule

module LPF1s_TB; // testbench to check response of low-pass filters
real OUT1,OUT2,OUT3,IN;
wire clk;
LPF1s #(.Fp(10000000), .Ts(1)) LP1(OUT1,IN,clk); // Tau = 1/2piFp = 16ns
LPF1s #(.Fp(30000000), .Ts(1)) LP2(OUT2,IN,clk); // Tau = 5.3ns
LPF1s #(.Fp(100000000),.Ts(1)) LP3(OUT3,IN,clk); // Tau = 1.6ns
xtor x0(clk,IN);
`ifdef SIMULATION
initial #1020 $finish; // stop after several cycles
`endif
endmodule

module xtor (clk,IN);
output IN;
input clk;
real IN;
wire clk;
real Vin=0; // Initialize input to 0
always #20 Vin=1-Vin; // alternate between 0 and 1 every 20ns
assign IN=Vin; // drive input pin with Vin value
always @(IN) begin
$display("SNPS: IN = %0d", IN);
end
endmodule

`ifdef EMULATION
module dumpvars();
	initial begin: debug_fwc
		$dumpvars(0, LPF1s_TB.OUT1);
		$dumpvars(0, LPF1s_TB.OUT2);
		$dumpvars(0, LPF1s_TB.OUT3);
		$dumpvars(0, LPF1s_TB.IN);
	end
endmodule
`endif
