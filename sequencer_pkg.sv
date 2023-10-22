package sequencer_pkg;

import seq_item_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh" 

class SEQUENCER extends uvm_sequencer #(SEQ_ITEM);

`uvm_component_utils(SEQUENCER)

function new (string name = "sequencer", uvm_component parent = null);

super.new(name,parent);

endfunction

endclass

endpackage
