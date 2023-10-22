package seq_item_pkg;

import uvm_pkg ::*;
`include "uvm_macros.svh" 

class SEQ_ITEM extends uvm_sequence_item;
`uvm_object_utils(SEQ_ITEM)


rand bit rst_n;
rand bit [9:0] din;
rand bit rx_valid;

bit [7:0] dout;
bit tx_valid;

bit	[1:0] 	last_2_bits ;


//////////////////////////// constraints on rx_valid to be 1 most of the times ///////////////////////////////////
constraint rx_valid_c {
rx_valid dist {0:= 30 , 1:= 70};
}

//////////////////////////// constraint on reset to be deasserted most of the times //////////////////////////////////
constraint reset_c {
rst_n dist {1:=90 , 0:=10};
}

//////////////////////////// constraints on din[9:8] ////////////////////////////////////////////////////////////

constraint last_2_bits_c {

if (last_2_bits == 2'b00) 
{
din[9:8] == 2'b01;
}

else if (last_2_bits == 2'b10)
{
din[9:8] == 2'b11;
}

else 
{
din[9:8] dist {2'b00 := 50 , 2'b10 := 50};
}


}

///////////////////////////// constraint on the write addresses to be fully exercised ////////////////////////////// 

constraint write_add_c {

if(last_2_bits == 2'b00)
{
din[7:0] dist {[0:128]:= 20 , [129:255] := 20 };
}
}

///////////////////////////// post_randomize fuction ///////////////////////////////////////////

function void post_randomize ;

last_2_bits = din[9:8];

endfunction



function new (string name = "seq_item");

super.new(name);

endfunction


function string convert2string ();

return $sformatf ("%s reset = 0b%0b , din = 0b%0b , rx_valid = 0b%0b , dout = 0b%0b , tx_valid = 0b%0b",super.convert2string(),rst_n,din,rx_valid,dout,tx_valid);

endfunction

function string convert2string_stimulus ();

return $sformatf ("%s reset = 0b%0b ,din = 0b%0b , rx_valid = 0b%0b ",super.convert2string(),rst_n,din,rx_valid);

endfunction

endclass
endpackage

