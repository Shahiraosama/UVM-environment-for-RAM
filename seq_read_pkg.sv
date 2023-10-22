package seq_main_pkg ;

import seq_item_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh" 


//////////////////////////////////// write only sequence /////////////////////////////////////

class SEQ_WRITE extends uvm_sequence #(SEQ_ITEM) ;
`uvm_object_utils(SEQ_WRITE)

SEQ_ITEM seq_item;


function new (string name = "seq_write_item");

super.new(name);

endfunction

task body;

repeat(20000)
begin
seq_item = SEQ_ITEM :: type_id :: create ("seq_item");
seq_item.last_2_bits_c.constraint_mode(0);

start_item(seq_item);

assert (seq_item.randomize() with {din[9:8] == 2'b00;} );
finish_item (seq_item);

seq_item = SEQ_ITEM :: type_id :: create ("seq_item");
seq_item.last_2_bits_c.constraint_mode(0);
start_item(seq_item);
assert (seq_item.randomize() with {din[9:8] == 2'b01;} );
finish_item (seq_item);

end

endtask
endclass
//////////////////////////////////// read only sequence /////////////////////////////////////

class SEQ_READ extends uvm_sequence #(SEQ_ITEM) ;
`uvm_object_utils(SEQ_READ)

SEQ_ITEM seq_item;


function new (string name = "seq_read_item");

super.new(name);

endfunction

task body;

repeat(20000)
begin
seq_item = SEQ_ITEM :: type_id :: create ("seq_item");
seq_item.last_2_bits_c.constraint_mode(0);

start_item(seq_item);
assert (seq_item.randomize() with {din[9:8] == 2'b10;} );
finish_item (seq_item);

seq_item = SEQ_ITEM :: type_id :: create ("seq_item");
seq_item.last_2_bits_c.constraint_mode(0);
start_item(seq_item);
assert (seq_item.randomize() with {din[9:8] == 2'b11;} );
finish_item (seq_item);
end

endtask
 endclass
//////////////////////////////////// write and read sequence /////////////////////////////////////

class SEQ_W_R extends uvm_sequence #(SEQ_ITEM) ;
`uvm_object_utils(SEQ_W_R)

SEQ_ITEM seq_item;


function new (string name = "seq_w_r_item");

super.new(name);

endfunction

task body;

repeat(20000)
begin

seq_item = SEQ_ITEM :: type_id :: create ("seq_item");
seq_item.last_2_bits_c.constraint_mode(1);

start_item(seq_item);
assert (seq_item.randomize());
finish_item (seq_item);
end

endtask 

endclass
endpackage
