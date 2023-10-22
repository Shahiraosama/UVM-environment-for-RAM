package seq_rst_pkg;

import seq_item_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh" 

class SEQ_RST extends uvm_sequence #(SEQ_ITEM);
`uvm_object_utils(SEQ_RST)

SEQ_ITEM seq_item;


function new (string name = "seq_reset_item");

super.new(name);

endfunction

task body;

seq_item = SEQ_ITEM :: type_id :: create ("seq_item");

start_item(seq_item);

seq_item.rst_n = 0;
seq_item.rx_valid = 0;
seq_item.din = 0;

finish_item (seq_item);


endtask

endclass
endpackage
