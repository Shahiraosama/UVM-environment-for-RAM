package monitor_pkg;

import seq_item_pkg::*;
import uvm_pkg ::*;
`include "uvm_macros.svh" 

class MONITOR extends uvm_monitor;
`uvm_component_utils(MONITOR)

virtual RAM_IF monitor_vif;


SEQ_ITEM rsp_seq_item;

uvm_analysis_port #(SEQ_ITEM ) mon_ap;

function new (string name = "monitor",uvm_component parent = null);

super.new(name,parent);

endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);

mon_ap = new("mon_ap", this );

endfunction

task run_phase (uvm_phase phase);
super.run_phase(phase);

forever begin
rsp_seq_item = SEQ_ITEM :: type_id :: create("rsp_seq_item");

@(negedge monitor_vif.clk);


rsp_seq_item.rx_valid = monitor_vif.rx_valid;
rsp_seq_item.din = monitor_vif.din;
rsp_seq_item.rst_n = monitor_vif.rst_n;
rsp_seq_item.tx_valid = monitor_vif.tx_valid;
rsp_seq_item.dout = monitor_vif.dout;

mon_ap.write(rsp_seq_item);
`uvm_info ("run_phase", rsp_seq_item.convert2string_stimulus,UVM_HIGH)

end



endtask

endclass

endpackage

