package agent_pkg;

import driver_pkg::*;
import monitor_pkg ::*;
import cfg_pkg ::*; 
import sequencer_pkg ::*;
import seq_item_pkg::*;
import uvm_pkg ::*;
`include "uvm_macros.svh"  

class AGENT extends uvm_agent ;
`uvm_component_utils(AGENT)
DRIVER driver;
SEQUENCER sqr; 
MONITOR monitor ;
CFG cfg;

uvm_analysis_port #(SEQ_ITEM ) agt_ap;
 
function new (string name = "agent",uvm_component parent = null);

super.new(name,parent);

endfunction

function void build_phase (uvm_phase phase);

super.build_phase(phase);

if(!uvm_config_db #(CFG) :: get(this,"","CFG",cfg))
`uvm_fatal ("build_phase", "Unable to get config object" );


sqr = SEQUENCER :: type_id :: create ("env", this);

driver = DRIVER :: type_id :: create ("cfg", this);

monitor = MONITOR :: type_id :: create ("monitor", this );

agt_ap = new("agt_ap", this );

endfunction





function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);

driver.driver_vif = cfg.config_vif;
monitor.monitor_vif = cfg.config_vif;
driver.seq_item_port.connect(sqr.seq_item_export);


monitor.mon_ap.connect(agt_ap);

endfunction





endclass


endpackage

