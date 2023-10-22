package cfg_pkg; 

//import driver_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class CFG extends uvm_object;
`uvm_object_param_utils (CFG)

virtual RAM_IF config_vif;
virtual GM_IF scoreboard_vif ;

function new (string name = "config");
super.new (name);
endfunction

  
endclass

 
endpackage
