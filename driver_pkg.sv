package driver_pkg;

import cfg_pkg ::*;
import uvm_pkg::*;
import seq_item_pkg ::*;

//import env_pkg ::*;

`include "uvm_macros.svh"

class DRIVER extends uvm_driver #(SEQ_ITEM);
`uvm_component_param_utils (DRIVER)

virtual RAM_IF driver_vif;

//virtual config config_obj_driver;

CFG config_obj_driver;

SEQ_ITEM stim_seq_item;

function new (string name = "driver" , uvm_component parent = null);
super.new (name,parent);
endfunction

function void build_phase (uvm_phase phase);
super.build_phase (phase);
if(!uvm_config_db #(CFG):: get(this , "" , "CFG" , config_obj_driver))
`uvm_fatal ("build_phase" , "Driver -unable to get configuration object")
endfunction
/*
function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);
shift_driver_vif = shift_config_obj_driver.shift_config_vif;
endfunction
*/
//reset, serial_in, direction, mode , datain

task run_phase (uvm_phase phase);
super.run_phase (phase);

forever begin
stim_seq_item = SEQ_ITEM :: type_id :: create("stim_seq_item");

seq_item_port.get_next_item (stim_seq_item);

driver_vif.rst_n = stim_seq_item.rst_n;
driver_vif.din = stim_seq_item.din;
driver_vif.rx_valid = stim_seq_item.rx_valid ;

@(negedge driver_vif.clk);
seq_item_port.item_done();

`uvm_info ("run_phase", stim_seq_item.convert2string_stimulus,UVM_HIGH)
end
endtask



endclass

 
endpackage



