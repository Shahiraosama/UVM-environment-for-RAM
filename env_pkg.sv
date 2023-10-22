package env_pkg;

import uvm_pkg ::*;
import agent_pkg ::*;
import scoreboard_pkg ::*;
import cov_collector_pkg ::*;
import driver_pkg::*;
import sequencer_pkg ::*;

`include "uvm_macros.svh" 

class ENV extends uvm_env;
`uvm_component_utils(ENV)

SEQUENCER sqr;
AGENT agt;
SCORE_BOARD sb;
COVERAGE cov ;


function new (string name = "ENV" , uvm_component parent = null);

super.new(name,parent);

endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);

agt = AGENT :: type_id :: create ("agt", this) ; 
sb = SCORE_BOARD :: type_id :: create ("sb", this) ; 
cov = COVERAGE :: type_id :: create ("cov", this) ; 
sqr = SEQUENCER :: type_id :: create ("sqr", this) ;
endfunction

function void connect_phase (uvm_phase phase) ;

agt.agt_ap.connect (sb.sb_export);
agt.agt_ap.connect (cov.cov_export);
//driver.seq_item_port.connect(sqr.seq_item_export);


endfunction


endclass
endpackage
